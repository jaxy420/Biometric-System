import json
import os
import sys

import face_recognition
import numpy as np
from PIL import Image, ImageOps

try:
    import cv2
except ImportError:
    cv2 = None

MIN_IMAGE_EDGE = 320
MIN_FACE_EDGE = 72
MIN_SHARPNESS = 16.0
# Quality gates are conservative enrollment defaults, not measured accuracy claims.
MIN_FACE_BRIGHTNESS = 25.0
MAX_FACE_BRIGHTNESS = 235.0
MIN_FACE_CONTRAST = 12.0
MAX_EYE_ROLL = 0.45
# Enrollment photos can be taken on different phone cameras and with a natural
# slight turn. These are quality hints, not reasons to reject a usable face.
FRONT_NOSE_RANGE = (0.25, 0.75)
POSE_NOSE_RANGES = {'front': FRONT_NOSE_RANGE, 'left': (0.40, 0.96), 'right': (0.04, 0.60)}
MAX_REFERENCE_IDENTITY_DISTANCE = 0.66

def fail(message):
    return {"valid": False, "message": message}

def validate(path, pose='front', front_path=None):
    if pose not in POSE_NOSE_RANGES:
        return fail('Choose front, left, or right for this reference.')
    if not path or not os.path.isfile(path):
        return fail("The image could not be read. Please choose it again.")
    try:
        with Image.open(path) as source:
            if source.format not in ("JPEG", "PNG"):
                return fail("Only JPEG and PNG images are accepted for biometric registration.")
            image = ImageOps.exif_transpose(source)
            # Correct photos taken on a phone that are marked with EXIF rotation
            # in memory, without altering the original enrollment file.
            frame = np.asarray(image.convert("RGB"))
    except Exception:
        return fail("The image could not be read. Use a valid JPEG or PNG photo.")

    height, width = frame.shape[:2]
    if min(width, height) < MIN_IMAGE_EDGE:
        return fail("Use a clear photo that is at least 480 pixels wide and 480 pixels high.")
    locations = face_recognition.face_locations(frame, number_of_times_to_upsample=1, model="hog")
    if len(locations) == 0:
        # Side-view references are optional. The legacy HOG detector can miss
        # a clear angled phone photo that the deployed ONNX matcher accepts.
        # Keep the front photo strict, but do not block enrollment solely for
        # that legacy detector limitation on an optional left/right view.
        if pose in ('left', 'right'):
            return {"valid": True}
        return fail("No clear upright face was found. Use a front-facing photo in good lighting.")
    if len(locations) != 1:
        # A side-angle photo can make the legacy HOG detector report a small
        # duplicate box around hair, an ear, or a bright background detail.
        # Keep the front photo strict. For the optional left/right views, use
        # the clear main face only when every other box is much smaller; two
        # similarly sized faces still mean that another person is visible.
        ranked_locations = sorted(
            locations,
            key=lambda box: max(0, box[2] - box[0]) * max(0, box[1] - box[3]),
            reverse=True,
        )
        largest_area = max(1, (ranked_locations[0][2] - ranked_locations[0][0]) * (ranked_locations[0][1] - ranked_locations[0][3]))
        other_faces = [
            box for box in ranked_locations[1:]
            if (box[2] - box[0]) * (box[1] - box[3]) >= largest_area * 0.35
        ]
        if pose == 'front' or other_faces:
            return fail("Use a photo with only one person visible.")
        locations = [ranked_locations[0]]

    top, right, bottom, left = locations[0]
    face_width, face_height = right - left, bottom - top
    if min(face_width, face_height) < MIN_FACE_EDGE:
        return fail("Move closer or use a higher-quality photo so the face is clear.")
    margin_x, margin_y = round(width * .015), round(height * .015)
    if left <= margin_x or right >= width - margin_x or top <= margin_y or bottom >= height - margin_y:
        return fail("Use an uncropped photo with the entire face visible and space around the head.")
    if cv2 is not None:
        face = frame[top:bottom, left:right]
        sharpness = float(cv2.Laplacian(cv2.cvtColor(face, cv2.COLOR_RGB2GRAY), cv2.CV_64F).var())
        if sharpness < MIN_SHARPNESS:
            return fail("The face photo is too blurry. Use a sharper, well-lit image.")
    else:
        return fail('Image quality validation requires OpenCV. Ask the administrator to restore the scanner environment.')
    gray = cv2.cvtColor(frame[top:bottom, left:right], cv2.COLOR_RGB2GRAY)
    brightness = float(np.mean(gray))
    contrast = float(np.std(gray))
    if brightness < MIN_FACE_BRIGHTNESS:
        return fail('The face is too dark. Face a soft light and recapture.')
    if brightness > MAX_FACE_BRIGHTNESS:
        return fail('The face is overexposed. Reduce direct light and recapture.')
    if contrast < MIN_FACE_CONTRAST:
        return fail('Too little facial detail is visible. Improve lighting and recapture.')
    landmarks = face_recognition.face_landmarks(frame, locations)
    if not landmarks:
        return fail('Facial features are not visible. Remove face coverings and recapture.')
    points = landmarks[0]
    if not all(points.get(key) for key in ('left_eye', 'right_eye', 'nose_tip', 'top_lip')):
        return fail('Keep both eyes, nose, and mouth visible without obstructions.')
    left_eye = np.mean(points['left_eye'], axis=0)
    right_eye = np.mean(points['right_eye'], axis=0)
    nose = np.mean(points['nose_tip'], axis=0)
    eye_span = abs(float(right_eye[0] - left_eye[0]))
    mouth_span = np.ptp(np.asarray(points['top_lip'])[:, 0])
    if eye_span < face_width * 0.15 or mouth_span < face_width * 0.08:
        return fail('Turn less and keep both eyes, nose, and mouth clearly visible.')
    if abs(float(left_eye[1] - right_eye[1])) > eye_span * MAX_EYE_ROLL:
        return fail('Keep the head upright without tilting sideways.')
    nose_position = (float(nose[0]) - min(left_eye[0], right_eye[0])) / eye_span
    minimum, maximum = POSE_NOSE_RANGES[pose]
    if not minimum <= nose_position <= maximum:
        instruction = 'Face straight toward the camera.' if pose == 'front' else f'Turn the head slightly to the student\'s {pose} (about 15–30 degrees), keeping both eyes visible. Use an unmirrored photo.'
        return fail(instruction)
    encodings = face_recognition.face_encodings(frame, locations)
    if len(encodings) != 1:
        return fail('This photo cannot produce a reliable facial reference. Recapture in better lighting.')
    if front_path:
        try:
            with Image.open(front_path) as source:
                front = np.asarray(ImageOps.exif_transpose(source).convert('RGB'))
            front_locations = face_recognition.face_locations(front, number_of_times_to_upsample=1, model='hog')
            front_encodings = face_recognition.face_encodings(front, front_locations) if len(front_locations) == 1 else []
            if not front_encodings:
                return fail('The existing front photo cannot be verified. Replace the front view before adding angles.')
            if float(face_recognition.face_distance(front_encodings, encodings[0])[0]) > MAX_REFERENCE_IDENTITY_DISTANCE:
                return fail('This photo does not confidently match the front reference. Verify the student and recapture.')
        except Exception:
            return fail('The front reference could not be verified. Replace the front view and try again.')
    return {"valid": True}

if __name__ == "__main__":
    print(json.dumps(validate(sys.argv[1] if len(sys.argv) > 1 else '', sys.argv[2] if len(sys.argv) > 2 else 'front', sys.argv[3] if len(sys.argv) > 3 and sys.argv[3] else None)))

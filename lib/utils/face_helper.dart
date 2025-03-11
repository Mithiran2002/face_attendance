import 'package:google_ml_kit/google_ml_kit.dart';

Future<List<double>> extractFaceFeatures(String imagePath) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final faceDetector = GoogleMlKit.vision.faceDetector(
    FaceDetectorOptions(
      enableClassification: true, // Enable probability features (smile, eye open)
    ),
  );

  try {
    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      final Face face = faces.first;

      return [
        face.smilingProbability ?? 0.0,
        face.leftEyeOpenProbability ?? 0.0,
        face.rightEyeOpenProbability ?? 0.0,
        face.headEulerAngleY ?? 0.0,
        face.headEulerAngleZ ?? 0.0,
      ];
    } else {
      throw Exception('No face detected');
    }
  } finally {
    await faceDetector.close();
  }
}

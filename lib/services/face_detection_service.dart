import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceDetectionService {
  final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector();

  Future<List<Face>> detectFaces(CameraImage image) async {
    // Convert CameraImage to InputImage
    final InputImage inputImage = _getInputImageFromCameraImage(image);

    // Detect faces
    return await _faceDetector.processImage(inputImage);
  }

  InputImage _getInputImageFromCameraImage(CameraImage image) {
    // Convert CameraImage to InputImage
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    // Define image metadata
    final InputImageData inputImageData = InputImageData(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      imageRotation: InputImageRotation.Rotation_0deg, // Correct rotation value
      inputImageFormat: InputImageFormat.NV21, // Use the correct format
      planeData: image.planes.map((plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      }).toList(),
    );

    // Create InputImage
    return InputImage.fromBytes(
      bytes: bytes,
      inputImageData: inputImageData,
    );
  }

  void dispose() {
    _faceDetector.close();
  }
}
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:face_recognition/face_registration/face_painter.dart';

// class FaceDetectionScreen extends StatefulWidget {
//   @override
//   _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
// }

// class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
//   late CameraController _cameraController;
//   late FaceDetector _faceDetector;
//   List<Face> _faces = [];
//   Size? _imageSize;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _faceDetector = GoogleMlKit.vision.faceDetector();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     _cameraController = CameraController(
//       cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front),
//       ResolutionPreset.medium,
//     );
//     await _cameraController.initialize();
//     if (!mounted) return;
//     setState(() {});
//   }

//   Future<void> _detectFaces() async {
//     if (!_cameraController.value.isInitialized) return;

//     final image = await _cameraController.takePicture();
//     final inputImage = InputImage.fromFilePath(image.path);
//     final faces = await _faceDetector.processImage(inputImage);

//     setState(() {
//       _faces = faces;
//     });
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     _faceDetector.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_cameraController.value.isInitialized) {
//       return Center(child: CircularProgressIndicator());
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('Face Detection')),
//       body: Stack(
//         children: [
//           CameraPreview(_cameraController),
//           if (_imageSize != null)
//             CustomPaint(
//               painter: FacePainter(
//                 faces: _faces,
//                 imageSize: _imageSize!,
//                 rotation: 0,
//               ),
//               size: Size.infinite,
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _detectFaces,
//         child: Icon(Icons.camera),
//       ),
//     );
//   }
// }

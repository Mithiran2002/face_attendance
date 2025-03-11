import 'package:tflite_flutter/tflite_flutter.dart';

class FaceRecognitionService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    final modelPath = 'asset/mobilefacenet.tflite';
    _interpreter = await Interpreter.fromAsset(modelPath);
  }

  Future<List<double>> getFaceEmbedding(List<double> faceImage) async {
    final input = [faceImage];
    final output = List<double>.filled(128, 0).reshape([1, 128]);
    _interpreter.run(input, output);
    return output[0];
  }

  void dispose() {
    _interpreter.close();
  }
}
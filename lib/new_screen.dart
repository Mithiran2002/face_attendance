import 'package:flutter/material.dart';
import 'package:face_recognition/screens/face_register.dart';
import 'package:face_recognition/screens/attendance_screen.dart';

class NewScreenFace extends StatefulWidget {
  const NewScreenFace({super.key});

  @override
  State<NewScreenFace> createState() => _NewScreenFaceState();
}

class _NewScreenFaceState extends State<NewScreenFace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterFaceSCreen()));
              },
              child: Text('Register')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AttendanceScreen()));
              },
              child: Text('Scan'))
        ],
      ),
    );
  }
}

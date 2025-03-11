import 'dart:math';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:face_recognition/const/index.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:face_recognition/utils/face_helper.dart';
import 'package:face_recognition/screens/face_register.dart';
import 'package:face_recognition/database/face_database_helper.dart';
import 'package:face_recognition/widgets/attendance_list/atendance_list.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  final FaceDatabaseHelper _dbHelper = FaceDatabaseHelper();
  List<Map<String, dynamic>> _registeredUsers = [];
  List<Map<String, dynamic>> _matchedUsers = [];
  bool _isBackCamera = false; // Track which camera is active
  bool _isFlashOn = false;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadRegisteredUsers();
  }

 Future<void> _initializeCamera() async {
  try {
    final cameras = await availableCameras();
    final CameraDescription selectedCamera = _isBackCamera
        ? cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back)
        : cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(selectedCamera, ResolutionPreset.medium);
    await _cameraController.initialize();

    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  } catch (e) {
    print('Failed to initialize camera: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize camera: $e')),
      );
    }
  }
}

  void _toggleCamera() async {
    setState(() {
      _isCameraInitialized = false;
      _isBackCamera = !_isBackCamera; // Toggle camera type
    });

    await _initializeCamera();
  }

  void _toggleFlash() async {
    if (!_cameraController.value.isInitialized ||
        _cameraController.description.lensDirection ==
            CameraLensDirection.front) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Flash is only available for the back camera')),
      );
      return;
    }

    setState(() {
      _isFlashOn = !_isFlashOn;
    });

    try {
      await _cameraController
          .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    } catch (e) {
      print('Error setting flash mode: $e');
    }
  }

  Future<void> _loadRegisteredUsers() async {
    try {
      final users = await _dbHelper.getUsers();
      if (mounted) {
        setState(() {
          _registeredUsers = users;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Failed to load registered users: $e');
    }
  }

  Future<void> _markAttendance() async {
    if (!_isCameraInitialized) {
      _showErrorSnackBar('Camera is not initialized');
      return;
    }

    try {
      final image = await _cameraController.takePicture();
      final String imagePath = image.path;
      final List<double> faceFeatures = await extractFaceFeatures(imagePath);

      if (_registeredUsers.isEmpty) {
        _showErrorSnackBar('No registered users found.');
        return;
      }

      List<Map<String, dynamic>> matchedUsers = [];

      for (var user in _registeredUsers) {
        final List<double> registeredFeatures =
            _parseFaceFeatures(user['faceData']);

        if (_compareFaceFeatures(faceFeatures, registeredFeatures)) {
          matchedUsers.add(user);
          await _dbHelper.markAttendance({
            'userId': user['id'],
            'date': DateTime.now().toString(),
          });
        }
      }

      if (matchedUsers.isNotEmpty) {
        if (mounted) {
          setState(() {
            _matchedUsers = matchedUsers;
          });
        }
        _showSuccessSnackBar(
            'Attendance marked for ${matchedUsers.length} user(s)');
        print('users ${matchedUsers.length}');
      } else {
        _showErrorSnackBar('Please Try Again!');
      }
    } catch (e) {
      _showErrorSnackBar('Failed to mark attendance');
    }
  }

  List<double> _parseFaceFeatures(String faceData) {
    try {
      return faceData
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((e) => double.tryParse(e.trim()) ?? 0.0)
          .toList();
    } catch (e) {
      return [];
    }
  }

  bool _compareFaceFeatures(List<double> features1, List<double> features2) {
    if (features1.length != features2.length) return false;
    double sum = 0.0;
    for (int i = 0; i < features1.length; i++) {
      sum += pow(features1[i] - features2[i], 2);
    }
    double distance = sqrt(sum);
    return distance < 1.0;
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Style.colors.error, content: Text(message)),
      );
    }
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Style.colors.success, content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Style.colors.primary,
        title: Text('Employee Attendance',
            style: Style.textStyles
                .primary(fontSize: 20.sp, color: Style.colors.primaryLight)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_alt_1,
              size: 19.sp,
              color: Style.colors.primaryLight,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterFaceSCreen())),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h),
            Expanded(
              child: Stack(
                children: [
                  _isCameraInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: CameraPreview(_cameraController),
                        )
                      : Center(child: CircularProgressIndicator()),

                  // Camera Toggle Button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(Icons.switch_camera, color: Colors.white, size: 30),
                      onPressed: _toggleCamera,
                    ),
                  ),

                  // Flash Toggle Button
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white, size: 30),
                      onPressed: _toggleFlash,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 2.h),
          Bounce(
            onPressed: _markAttendance,
            duration: Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 1.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Style.colors.primary),
              child: Text('Take Attendance',
                  style: Style.textStyles.primary(
                      fontSize: 13.sp, color: Style.colors.primaryLight)),
            ),
          ),
          SizedBox(height: 1.h),
          Expanded(
            child: _matchedUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _matchedUsers.length,
                    itemBuilder: (context, index) {
                      final user = _matchedUsers[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.7.h),
                        child: AttendanceWidget(
                          age: user['age'],
                          attendance: 'Present',
                          clockin: DateFormat('dd/MM/yy hh:mm a')
                              .format(DateTime.now()),
                          employeid: user['employeeId'],
                          name: user['name'],
                          worktype: user['workType'],
                        ),
                      );
                    },
                  )
                : const Center(child: Text('Take Attendance to Enroll')),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}

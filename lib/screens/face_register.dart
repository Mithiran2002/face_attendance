import 'package:sizer/sizer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:face_recognition/const/index.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:face_recognition/utils/face_helper.dart';
import 'package:face_recognition/widgets/custom_button.dart';
import 'package:face_recognition/widgets/ccustom_textfield.dart';
import 'package:face_recognition/database/face_database_helper.dart';

class RegisterFaceSCreen extends StatefulWidget {
  @override
  _RegisterFaceSCreenState createState() => _RegisterFaceSCreenState();
}

class _RegisterFaceSCreenState extends State<RegisterFaceSCreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  final FaceDatabaseHelper _dbHelper = FaceDatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _workTypeController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  int _currentMaxId = 0;
  bool _isBackCamera = false; // Track which camera is active
  bool _isFlashOn = false; // Track flash status

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _generateEmployeeID();
  }

  void _generateEmployeeID() {
    setState(() {
      _currentMaxId++; // Increment the ID
      String formattedId = _currentMaxId
          .toString()
          .padLeft(3, '0'); // Format with leading zeros.
      _employeeIdController.text =
          formattedId; // Set the formatted ID in the text controller.
    });
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
  if (!_cameraController.value.isInitialized || _cameraController.description.lensDirection == CameraLensDirection.front) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Flash is only available for the back camera')),
    );
    return;
  }

  setState(() {
    _isFlashOn = !_isFlashOn;
  });

  try {
    await _cameraController.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
  } catch (e) {
    print('Error setting flash mode: $e');
  }
}


  Future<void> _registerUser() async {
    final String name = _nameController.text.trim();
    final int age = int.tryParse(_ageController.text.trim()) ?? 0;
    final String workType = _workTypeController.text.trim();
    final String employeeId = _employeeIdController.text.trim();

    if (name.isEmpty || age <= 0 || workType.isEmpty || employeeId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Style.colors.error,
            content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      final image = await _cameraController.takePicture();
      final String imagePath = image.path;

   
      final List<double> faceFeatures = await extractFaceFeatures(imagePath);

      // Save user data to SQLite
      await _dbHelper.insertUser({
        'name': name,
        'age': age,
        'workType': workType,
        'employeeId': employeeId,
        'faceData': faceFeatures.toString(),
      });
  
      print('faceData >> ${faceFeatures}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Style.colors.success,
            content: Text('Employe registered successfully')),
      );

      // Clear fields
      _nameController.clear();
      _ageController.clear();
      _workTypeController.clear();
      _employeeIdController.clear();
    } catch (e) {
      print('Failed to register user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register user: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 17.sp,
                color: Style.colors.primaryLight,
              )),
          backgroundColor: Style.colors.primary,
          title: Text(
            'Register Employe',
            style: Style.textStyles.primary(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Style.colors.primaryLight),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
        child: Column(
          children: [
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
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              controller: _nameController,
              hintText: 'Enter Name',
              onTap: () {},
              label: Text(
                'Name',
                style: Style.textStyles.primary(color: Style.colors.black),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              controller: _ageController,
              hintText: 'Enter age',
              onTap: () {},
              label: Text(
                'Age',
                style: Style.textStyles.primary(color: Style.colors.black),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              controller: _workTypeController,
              hintText: 'Enter Work Type',
              onTap: () {},
              label: Text(
                'Work Type',
                style: Style.textStyles.primary(color: Style.colors.black),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              controller: _employeeIdController,
              hintText: 'Emp Id',
              onTap: () {},
              label: Text(
                'Emp Id',
                style: Style.textStyles.primary(color: Style.colors.black),
              ),
            ),
            SizedBox(height: 20),
            Bounce(
              onPressed: _registerUser,
              duration: Duration(milliseconds: 300),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 1.7.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: Style.colors.primary),
                child: Text(
                  'Submit',
                  style: Style.textStyles.primary(
                      fontSize: 16.sp, color: Style.colors.primaryLight),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _workTypeController.dispose();
    _employeeIdController.dispose();
    super.dispose();
  }
}
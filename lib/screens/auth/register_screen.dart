import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:face_recognition/const/index.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:face_recognition/database/database_helper.dart';
import 'package:face_recognition/screens/auth/login_screen.dart';
import 'package:face_recognition/widgets/ccustom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  void _register() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('All fields are required'),
          backgroundColor: Style.colors.error,
        ),
      );
      return;
    }

    try {
      int result =
          await DatabaseHelper.instance.registerUser(username, email, password);
      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Registration Successfully'),
            backgroundColor: Style.colors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 10.h,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 15.sp,
                color: Style.colors.primaryLight,
              )),
          backgroundColor: Colors.blue,
          title: Text(
            'Register',
            style: Style.textStyles.primary(color: Style.colors.primaryLight),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )),
              SizedBox(
                height: 1.h,
              ),
              CustomTextField(
                  controller: _usernameController,
                  hintText: 'Enter Name',
                  onTap: () {}),
              SizedBox(
                height: 1.h,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )),
              SizedBox(
                height: 1.h,
              ),
              CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter Email',
                  onTap: () {}),
              SizedBox(
                height: 1.h,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )),
              SizedBox(
                height: 1.h,
              ),
              CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter password',
                  onTap: () {}),
              SizedBox(height: 4.h),
              Bounce(
                onPressed: _register,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 12,
                          offset: Offset(1, 5),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.blue),
                  child: Text(
                    'Register',
                    style: Style.textStyles.primary(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You have already account?',
                    style: Style.textStyles
                        .primary(color: Style.colors.black, fontSize: 11.sp),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Login',
                      style: Style.textStyles
                          .primary(color: Style.colors.primary, fontSize: 11.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

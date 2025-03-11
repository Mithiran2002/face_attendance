import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:face_recognition/const/index.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:face_recognition/database/database_helper.dart';
import 'package:face_recognition/widgets/ccustom_textfield.dart';
import 'package:face_recognition/screens/auth/register_screen.dart';
import 'package:face_recognition/screens/auth/dashboard/dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required'),backgroundColor: Style.colors.error,),
      );
      return;
    }

    var user = await DatabaseHelper.instance.loginUser(email, password);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome ${user['username']}!'),backgroundColor: Style.colors.success,),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password'),backgroundColor: Style.colors.error,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 12.h,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          title: Text(
            'Login to Continue',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
              height: 2.h,
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
                hintText: 'Enter Password',
                onTap: () {},
                obscureText: true,),
            SizedBox(
              height: 3.h,
            ),
            Bounce(
              onPressed: _login,
              duration: Duration(milliseconds: 300),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                    boxShadow: [
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
                  'Login',
                  style: Style.textStyles.primary(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have not register?',
                  style: Style.textStyles.primary(color: Style.colors.black,fontSize: 11.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => RegistrationScreen()));
                    },
                    child: Text(
                    'Register',
                    style: Style.textStyles.primary(color: Style.colors.primary,fontSize: 11.sp),
                                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

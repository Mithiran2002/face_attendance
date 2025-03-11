import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:face_recognition/screens/auth/login_screen.dart';
import 'package:face_recognition/screens/auth/register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => __OnboardingScreenStateState();
}

class __OnboardingScreenStateState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/onboard.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3), // Top gradient color
                Colors.transparent, // Middle transparent part
                Colors.black.withOpacity(0.5), // Bottom gradient color
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bounce(
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 300), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    });
                  },
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.8.h),
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
                        color: Colors.blue.withOpacity(0.8)),
                    child: Text(
                      'Get Start',
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    ),
                  )),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

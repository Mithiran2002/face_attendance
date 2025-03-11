import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:face_recognition/screens/face_register.dart';
import 'package:face_recognition/widgets/attendance_list/atendance_list.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 10.h,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text(
          'Attendance',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterFaceSCreen()));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.sp),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 2.6.h,
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.sp),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://static.vecteezy.com/system/resources/thumbnails/013/052/452/small/silhouette-af-man-without-face-in-hood-on-red-background-anonymous-crime-photo.jpg'),
              radius: 2.6.h,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.8.h,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Attendance List',
                    style: TextStyle(fontSize: 15.sp),
                  )),
              SizedBox(
                height: 3.h,
              ),
              AttendanceWidget()
            ],
          ),
        ),
      ),
    );
  }
}

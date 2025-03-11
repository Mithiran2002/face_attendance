import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:face_recognition/const/index.dart';

class RegistersUsersWidget extends StatefulWidget {
  String? name;
  int? age;
  String? workType;
  String? employid;
  RegistersUsersWidget(
      {this.age, this.employid, this.name, this.workType, super.key});

  @override
  State<RegistersUsersWidget> createState() => _RegistersUsersWidgetState();
}

class _RegistersUsersWidgetState extends State<RegistersUsersWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 12,
              offset: Offset(1, 5),
              spreadRadius: 0,
            )
          ],
          color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                'Age',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                'Work Type',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                'EmployeId',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(width: 3.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                child: Text(
                  ':',
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                 '${widget.age ?? 0}'
                 ,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                widget.workType ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                widget.employid ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class AttendanceWidget extends StatefulWidget {
  String? name;
  bool ? data;
  int? age;
  String? employeid;
  String? attendance;
  String? clockin;
  String? worktype;
  AttendanceWidget(
      {this.age,
      this.data,
      this.attendance,
      this.clockin,
      this.employeid,
      this.name,
      this.worktype,
      super.key});

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
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
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
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
                widget.data == true ?
                'Clock In' : '',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                'EmployeId',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                'Attendance',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(width: 3.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
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
                '${widget.age}',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
               widget.worktype ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                widget.clockin ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                widget.employeid ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              SizedBox(height: 1.h),
              Text(
                widget.attendance ?? '',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

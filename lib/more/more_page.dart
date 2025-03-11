import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:face_recognition/const/index.dart';
import 'package:face_recognition/database/face_database_helper.dart';
import 'package:face_recognition/widgets/attendance_list/atendance_list.dart';
import 'package:face_recognition/widgets/register_user_widget/register_users.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final FaceDatabaseHelper _dbHelper = FaceDatabaseHelper();
  List<Map<String, dynamic>> _registeredUsers = [];

  Future<void> _loadRegisteredUsers() async {
    try {
      final users = await _dbHelper.getUsers();
      if (mounted) {
        setState(() {
          _registeredUsers = users;
        });
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRegisteredUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registered Users',
          style: TextStyle(color: Style.colors.primaryLight, fontSize: 18.sp),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Style.colors.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              'Users List',
              style: TextStyle(
                  color: Style.colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: _registeredUsers.isEmpty
                ? Center(
                    child: Text(
                      'No registered Users',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  )
                : ListView.builder(
                    itemCount: _registeredUsers.length,
                    itemBuilder: (context, index) {
                      final user = _registeredUsers[index];
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.7.h),
                        child: RegistersUsersWidget(
                          age: user['age'],
                          employid: user['employeeId'],
                          name:user['name'],
                          workType: user['workType'],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

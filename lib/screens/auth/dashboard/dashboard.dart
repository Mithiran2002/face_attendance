import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:face_recognition/more/more_page.dart';
import 'package:face_recognition/screens/attendance_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int? index;
  DashboardScreen({this.index, Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int pageIndex = 0;
  // final HomeController homeController = Get.put(HomeController());
  final pages = [
   AttendanceScreen(),
    MorePage()
  ];
  @override
  void initState() {
    pageIndex = widget.index ?? 0;
    // logger.i(pageIndex);
    super.initState();
  }

  int backButtonPressedCounter = 0;
  DateTime? backButtonPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backButtonPressTime == null ||
            DateTime.now().difference(backButtonPressTime!) >
                 Duration(seconds: 2)) {
          backButtonPressTime = DateTime.now();
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
      child:
          // upgrader: Upgrader(
          //   debugLogging: true,
          //   durationUntilAlertAgain: Duration(
          //     hours: 1,
          //   ),
          //   willDisplayUpgrade: (
          //       {required display,
          //       appStoreVersion,
          //       installedVersion,
          //       minAppVersion}) async {
          //     logger.e(
          //         '$display $appStoreVersion $installedVersion $minAppVersion');

          //     if (display &&
          //         appStoreVersion != null &&
          //         installedVersion != null) {
          //       await Future.delayed(
          //         Duration(seconds: 1),
          //         () {
          //           if (mounted) {
          //             setState(() {
          //               pageIndex = 0;
          //             });
          //           }
          //           // Get.to(() => UpdateAppPage(
          //           //       mCurrentVersion: installedVersion.toString(),
          //           //       mUpdateVersion: appStoreVersion.toString(),
          //           //     ));
          //         },
          //       );
          //     }
          //   },
          // ),
          Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(
        //     Icons.center_focus_weak_outlined,
        //     size: 25.sp,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        //   backgroundColor: Colors.blue.withOpacity(0.8),
        // ),
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 10.sp,
            color: Colors.black,
          ),
          iconSize: 20.sp,
          selectedItemColor: Colors.black,
          showUnselectedLabels: true,
          unselectedLabelStyle:
              GoogleFonts.poppins(color: Colors.grey[300], fontSize: 9.sp),
          showSelectedLabels: true,
          unselectedItemColor: Colors.grey[500],
          backgroundColor: Colors.white,
          currentIndex: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
            // logger.i(pageIndex);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
                  pageIndex == 0 ? const Icon(Icons.home_outlined) : const Icon(Icons.home),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: pageIndex == 1
            //       ? Icon(Icons.business_sharp,
            //           color:

            //                Colors.black)
            //       : const Icon(
            //           Icons.business_sharp,
            //           color: Color.fromARGB(255, 152, 152, 152),
            //         ),
            //   label:'More',
            // ),
            // BottomNavigationBarItem(
            //   icon: pageIndex == 2
            //       ? Icon(Icons.assignment_late_rounded,
            //           color: homeController.isDarkThme.value
            //               ? Colors.white
            //               : Colors.black)
            //       :  Icon(
            //           Icons.assignment_late_outlined,
            //           color: Color.fromARGB(255, 152, 152, 152),
            //         ),
            //   label: CALENDAR,
            // ),
            BottomNavigationBarItem(
              icon: pageIndex == 1
                  ? const Icon(Icons.widgets_rounded, color: Colors.black)
                  : const Icon(
                      Icons.widgets_outlined,
                      color: Color.fromARGB(255, 152, 152, 152),
                    ),
              label: 'more',
            ),
          ],
        ),
      ),
    );
  }
}

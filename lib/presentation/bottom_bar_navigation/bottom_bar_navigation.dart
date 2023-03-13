
import 'package:elssit/presentation/account_screen/account_screen.dart';
import 'package:elssit/presentation/request_screen/request_screen.dart';

import 'package:elssit/presentation/schedule_screen/schedule_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../splash_screen/splash_screen.dart';

// ignore: must_be_immutable
class BottomBarNavigation extends StatefulWidget {
  int selectedIndex = 0;

  bool isBottomNav = true;

  BottomBarNavigation(
      {super.key, required this.selectedIndex, required this.isBottomNav});

  @override
  // ignore: no_logic_in_create_state
  State<BottomBarNavigation> createState() => _BottomBarNavigationState(
      selectedIndex: selectedIndex, isBottomNav: isBottomNav);
}

class _BottomBarNavigationState extends State<BottomBarNavigation> {
  int selectedIndex = 0;
  bool isBottomNav = true;

  _BottomBarNavigationState(
      {required this.selectedIndex, required this.isBottomNav});

  Widget pageCaller(index) {
    switch (selectedIndex) {
      case 0:
        return const SplashScreen();
      case 1:
        return const RequestScreen();
      case 2:
        return const ScheduleScreen();
      case 3:
        return const AccountScreen();

      default:
        return const SplashScreen();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: pageCaller(selectedIndex),
      bottomNavigationBar: isBottomNav == true
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icHome),
                  ),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(

                  icon: ImageIcon(
                    AssetImage(ImageConstant.icRequest),
                  ),
                  label: 'Yêu cầu',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icSchedule),
                  ),
                  label: 'Lịch Trình',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icAccount),
                  ),
                  label: 'Tài khoản',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: ColorConstant.primaryColor,
              selectedLabelStyle: GoogleFonts.roboto(
                color: ColorConstant.primaryColor,
              ),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: GoogleFonts.roboto(
                color: Colors.black,
              ),
              showUnselectedLabels: true,
              elevation: 0,
              onTap: _onItemTapped,
            )
          : Container(
              height: 0,
            ),
    );
  }
}

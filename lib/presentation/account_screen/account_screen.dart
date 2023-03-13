import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../fire_base/provider/google_sign_in_provider.dart';
import '../../process/bloc/authen_bloc.dart';
import '../../process/event/authen_event.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _elsBox = Hive.box('elsBox');
  final _authenBloc = AuthenBloc();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: size.width * 0.05,
              //     right: size.width * 0.05,
              //   ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstant.appLogo,
                    width: size.width * 0.08,
                    height: size.width * 0.08,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    'Hồ Sơ Của Bạn',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: 1.0,
                      child: Icon(
                        Icons.settings_rounded,
                        size: size.height * 0.03,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              //),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.ic_profile,
                      height: size.height * 0.12,
                      width: size.height * 0.12,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Van Anh Nguyen',
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          '+84 375606034',
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.018,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.gray9E,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                height: 1,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteEE,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: size.height * 0.03,
              //     right: size.height * 0.03,
              //   ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/contactDetailScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_account,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Thông tin liên lạc',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: size.height * 0.03,
              //     right: size.height * 0.03,
              //   ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/indentificationInformationScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_account,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Thông tin định danh',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signUpScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_payment,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Phương thức thanh toán',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: size.height * 0.03,
              //     right: size.height * 0.03,
              //   ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/educationDetailScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_education,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Học vấn',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: size.height * 0.03,
              //     right: size.height * 0.03,
              //   ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/certificationDetailScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_certificate,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Chứng nhận & Giấy phép',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: size.height * 0.03,
              //     right: size.height * 0.03,
              //   ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/achievementDetailScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_prize,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Giải thưởng & Thành tích',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: size.height * 0.03,
              //     right: size.height * 0.03,
              //   ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/workExperienceDetailScreen');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_prize,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Kinh nghiệm làm việc',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.add,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),

              // Container(
              //   width: size.width,
              //   height: size.height * 0.09,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.all(Radius.circular(18.5)),
              //     border: Border.all(
              //       color: ColorConstant.whiteEE,
              //     ),
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pushNamed(context, '/signUpScreen');
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           ImageConstant.ic_payment,
              //           height: size.height * 0.1,
              //           width: size.height * 0.08,
              //         ),
              //         SizedBox(
              //           width: size.width * 0.005,
              //         ),
              //         Text(
              //           'Hội thảo & Tập huấn',
              //           style: GoogleFonts.roboto(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w500,
              //             fontSize: size.height * 0.022,
              //           ),
              //         ),
              //         Expanded(
              //           child: Align(
              //             alignment: Alignment.centerRight,
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                 right: size.width * 0.04,
              //               ),
              //               child: Icon(
              //                 Icons.add,
              //                 size: size.height * 0.03,
              //                 color: ColorConstant.primaryColor,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),

              // ),
              // SizedBox(
              //   height: size.height * 0.025,
              // ),

              // Container(
              //   width: size.width,
              //   height: size.height * 0.09,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.all(Radius.circular(18.5)),
              //     border: Border.all(
              //       color: ColorConstant.whiteEE,
              //     ),
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pushNamed(context, '/signUpScreen');
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           ImageConstant.ic_skill,
              //           height: size.height * 0.1,
              //           width: size.height * 0.08,
              //         ),
              //         SizedBox(
              //           width: size.width * 0.005,
              //         ),
              //         Text(
              //           'Kĩ năng',
              //           style: GoogleFonts.roboto(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w500,
              //             fontSize: size.height * 0.022,
              //           ),
              //         ),
              //         Expanded(
              //           child: Align(
              //             alignment: Alignment.centerRight,
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                 right: size.width * 0.04,
              //               ),
              //               child: Icon(
              //                 Icons.add,
              //                 size: size.height * 0.03,
              //                 color: ColorConstant.primaryColor,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // Container(
              //   width: size.width,
              //   height: size.height * 0.09,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.all(Radius.circular(18.5)),
              //     border: Border.all(
              //       color: ColorConstant.whiteEE,
              //     ),
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pushNamed(context, '/signUpScreen');
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           ImageConstant.ic_skill,
              //           height: size.height * 0.1,
              //           width: size.height * 0.08,
              //         ),
              //         SizedBox(
              //           width: size.width * 0.005,
              //         ),
              //         Text(
              //           'Kĩ năng',
              //           style: GoogleFonts.roboto(
              //             color: Colors.black,
              //             fontWeight: FontWeight.w500,
              //             fontSize: size.height * 0.022,
              //           ),
              //         ),
              //         Expanded(
              //           child: Align(
              //             alignment: Alignment.centerRight,
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                 right: size.width * 0.04,
              //               ),
              //               child: Icon(
              //                 Icons.add,
              //                 size: size.height * 0.03,
              //                 color: ColorConstant.primaryColor,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: size.height * 0.025,
              // ),
              Container(
                width: size.width,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18.5)),
                  border: Border.all(
                    color: ColorConstant.whiteEE,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logout();
                    _elsBox.delete('checkLogin');
                    _elsBox.delete('email');
                    _elsBox.delete('password');
                    _authenBloc.eventController.sink.add(LogoutEvent(context));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.ic_logout,
                        height: size.height * 0.1,
                        width: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.005,
                      ),
                      Text(
                        'Đăng Xuất',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: size.height * 0.03,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                height: 1,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteEE,
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:elssit/core/utils/color_constant.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({Key? key}) : super(key: key);

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: size.height * 0.03,
              color: Colors.black,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(left: size.width * 0.005),
            child: const Text(
              "Thông tin liên lạc",
            ),
          ),
          titleTextStyle: GoogleFonts.roboto(
            fontSize: size.height * 0.028,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        body: Container(
          color: Colors.white,
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
            left: size.width * 0.07,
            right: size.width * 0.07,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Địa chỉ',
                    style: GoogleFonts.roboto(
                      color: ColorConstant.gray43,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteF3,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme
                          .copyWith(primary: ColorConstant.primaryColor),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: ColorConstant.primaryColor,
                      controller: null,
                      // onChanged: (value) {
                      //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                      //       username: value.toString().trim()));
                      // },
                      decoration: InputDecoration(
                        hintText: "Địa chỉ hiện tại",
                        prefixIcon: SizedBox(
                          width: size.width * 0.05,
                          child: Icon(
                            Icons.location_on,
                            size: size.width * 0.05,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Số điện thoại',
                    style: GoogleFonts.roboto(
                      color: ColorConstant.gray43,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteF3,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme
                          .copyWith(primary: ColorConstant.primaryColor),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: ColorConstant.primaryColor,
                      controller: null,
                      // onChanged: (value) {
                      //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                      //       username: value.toString().trim()));
                      // },
                      decoration: InputDecoration(
                        hintText: "Số điện thoại",
                        prefixIcon: SizedBox(
                          width: size.width * 0.05,
                          child: Icon(
                            Icons.phone,
                            size: size.width * 0.05,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: GoogleFonts.roboto(
                      color: ColorConstant.gray43,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteF3,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme
                          .copyWith(primary: ColorConstant.primaryColor),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: ColorConstant.primaryColor,
                      controller: null,
                      // onChanged: (value) {
                      //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                      //       username: value.toString().trim()));
                      // },
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: SizedBox(
                          width: size.width * 0.05,
                          child: Icon(
                            Icons.email,
                            size: size.width * 0.05,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              //BorderSide(color: Color(0xffCED0D2), width: 1),
                              BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Giới thiệu bản thân (nhiều nhất 100 kí tự)',
                    style: GoogleFonts.roboto(
                      color: ColorConstant.gray43,
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteF3,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme
                          .copyWith(primary: ColorConstant.primaryColor),
                    ),
                    child: TextField(
                      maxLines: 11,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: ColorConstant.primaryColor,
                      controller: null,
                      // onChanged: (value) {
                      //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                      //       username: value.toString().trim()));
                      // },
                      decoration: InputDecoration(
                        hintText: "...",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
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
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      // _authenBloc.eventController.sink
                      //     .add(LoginEvent(context));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: ColorConstant.primaryColor),
                      ),
                      backgroundColor: ColorConstant.primaryColor,
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    child: const Text("Lưu"),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

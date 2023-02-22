import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:elssit/core/utils/color_constant.dart';

class EducationDetailScreen extends StatefulWidget {
  const EducationDetailScreen({Key? key}) : super(key: key);

  @override
  State<EducationDetailScreen> createState() => _EducationDetailScreenState();
}

class _EducationDetailScreenState extends State<EducationDetailScreen> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  bool status = false;
  final List<String> eliteracyItems = [
    'Hoàn thành bằng đại học',
    'Hoàn thành bằng thạc sĩ',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    // return StreamBuilder<ElderState>(
    //     stream: _elderBloc.stateController.stream,
    //     builder: (context, snapshot) {
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
              "Học Vấn",
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
                    'Trình độ học vấn',
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
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: size.height * 0.01,
                          left: size.width * 0.04,
                          right: size.width * 0.035,
                          bottom: size.height * 0.01,
                        ),
                        // errorText: (snapshot.hasError &&
                        //         (snapshot.error as Map<String, String>)
                        //             .containsKey("gender"))
                        //     ? (snapshot.error as Map<String, String>)["gender"]
                        //     : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
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
                      hint: const Text(
                        'Chọn trình độ học vấn',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      iconSize: size.width * 0.06,
                      buttonHeight: size.height * 0.07,
                      buttonPadding: const EdgeInsets.all(0),
                      dropdownWidth: 310,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: eliteracyItems
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.02,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      // onChanged: (value) {
                      //   _elderBloc.eventController.sink.add(
                      //       ChooseElderGenderEvent(gender: value.toString()));
                      // },
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Khóa học',
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
                        contentPadding: EdgeInsets.only(
                          left: size.width * 0.04,
                        ),
                        hintText: "Khóa học",
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
                    'Trường',
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
                        contentPadding: EdgeInsets.only(
                          left: size.width * 0.04,
                        ),
                        hintText: "Trường",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Từ',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.gray43,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.38,
                    ),
                    Text(
                      'Đến',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.gray43,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.only(
                        //   right: size.width * 0.6,
                        // ),
                        padding: EdgeInsets.only(
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteF3,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
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
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "GPA",
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
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.only(
                        //   right: size.width * 0.6,
                        // ),
                        padding: EdgeInsets.only(
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteF3,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
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
                              contentPadding: EdgeInsets.only(
                                left: size.width * 0.04,
                              ),
                              hintText: "GPA",
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
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Đã tốt nghiệp',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.02,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    FlutterSwitch(
                      activeColor: ColorConstant.primaryColor,
                      width: 45.0,
                      height: 25.0,
                      toggleSize: 20.0,
                      value: status,
                      borderRadius: 30.0,
                      // padding: 8.0,
                      showOnOff: false,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Miêu tả (không bắt buộc)',
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
                        contentPadding: EdgeInsets.only(
                          top: size.width * 0.1,
                          left: size.width * 0.04,
                        ),
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
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

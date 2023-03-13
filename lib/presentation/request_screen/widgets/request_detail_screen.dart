import 'package:elssit/core/utils/image_constant.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../../core/utils/color_constant.dart';
import 'job_description_panel.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({Key? key}) : super(key: key);

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        indicatorColor: ColorConstant.primaryColor,
        tabs: [
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              "Mô tả công việc",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              "Trình độ tối thiểu",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Kỹ năng yêu cầu",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              textAlign: TextAlign.center,
              "Tóm tắt công việc",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
        isScrollable: true,
      );
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * 0.08,
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: size.height * 0.03,
            ),
          ),
          backgroundColor: Colors.white,
          title: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.only(
                top: size.height * 0.01,
                bottom: size.height * 0.01,
              ),
              child: Text(
                "Xác nhận yêu cầu",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: size.height * 0.024,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_outlined,
                size: size.height * 0.03,
                color: Colors.black,
              ),
            ),
          ],
          // bottom: createTabBar(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          width: size.width,
          height: size.height * 0.12,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          ColorConstant.primaryColor.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.height * 0.03),
                      ),
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    child: Text(
                      "Từ chối",
                      style: GoogleFonts.roboto(
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                SizedBox(
                  width: size.width * 0.4,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.height * 0.03),
                      ),
                      textStyle: TextStyle(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    child: const Text("Chấp nhận"),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                margin: EdgeInsets.only(
                  top: size.height * 0.02,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: size.height * 0.02,
                ),
                padding: EdgeInsets.only(
                  top: size.height * 0.015,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: size.height * 0.015,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.height * 0.02),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.icAva,
                      height: size.height * 0.1,
                      width: size.height * 0.1,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      "Ngô Thị Thanh Ngân",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.022,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      "23 Tuổi",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.022,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 1,
                      margin: EdgeInsets.only(
                        top: size.height * 0.025,
                        bottom: size.height * 0.025,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      "FPT University, TP.HCM",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.022,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      "39,000/ ngày",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.022,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                            top: size.height * 0.005,
                            bottom: size.height * 0.005,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.005),
                            border: Border.all(
                              width: 1,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          child: Text(
                            "4 giờ",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.014,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.05,
                            top: size.height * 0.005,
                            bottom: size.height * 0.005,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.005),
                            border: Border.all(
                              width: 1,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          child: Text(
                            "20 - 02 - 2023  |  13:00 - 17:00 PM",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: size.height * 0.014,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      "Yêu cầu nhận từ ... phút trước.",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.02,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      "Bạn có 1 giờ để chấp nhận.",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * 0.02,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              createTabBar(),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: TabBarView(children: [
                    Material(
                      child: Container(
                        color: Colors.white,
                        width: size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.03,

                              ),
                              const JobDescriptionPanel(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        color: Colors.white,
                        width: size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        color: Colors.white,
                        width: size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        color: Colors.white,
                        width: size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

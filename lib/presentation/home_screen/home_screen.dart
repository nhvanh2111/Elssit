import 'package:elssit/presentation/home_screen/widgets/balance_panel.dart';
import 'package:elssit/presentation/home_screen/widgets/work_panel.dart';
import 'package:elssit/presentation/schedule_screen/widgets/booking_item_widget.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAccountBalance = false;
  int tabIndex = 0;
  int indexSchToday = 0;
  var items = [
    {"name": "Nguyen Thi Le", "time": "8:00-12:00", "address": "2B/HoChiMinh"},
    {"name": "Nguyen Van A", "time": "8:00-12:00", "address": "2B/HoChiMinh"},
    {"name": "Nguyen Van B", "time": "8:00-12:00", "address": "2B/HoChiMinh"}
  ];
  int lengthListDataTmp = 0;
  PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Getdata toDay
    lengthListDataTmp = items.length;
  }

  nextSchedu() {
    setState(() {
      indexSchToday++;
      _pageController.jumpToPage(indexSchToday);
    });
  }

  backSchedu() {
    setState(() {
      indexSchToday--;
      _pageController.jumpToPage(indexSchToday);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        indicatorColor: Colors.transparent,
        onTap: (value) {
          setState(() {
            tabIndex = value;
          });
        },
        tabs: [
          Container(
            width: size.width * 0.4,
            padding: EdgeInsets.only(
              left: size.width * 0.07,
              right: size.width * 0.07,
              bottom: size.height * 0.012,
              top: size.height * 0.015,
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: size.height * 0.002,
            ),
            decoration: BoxDecoration(
              color: (tabIndex == 0) ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(size.height * 0.01),
            ),
            child: Text(
              "Công việc",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: (tabIndex == 0) ? Colors.white : Colors.black,
                fontSize: 17,
                height: 1,
              ),
            ),
          ),
          Container(
            width: size.width * 0.4,
            padding: EdgeInsets.only(
              left: size.width * 0.07,
              right: size.width * 0.07,
              bottom: size.height * 0.012,
              top: size.height * 0.015,
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: size.height * 0.002,
            ),
            decoration: BoxDecoration(
              color: (tabIndex == 1) ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(size.height * 0.01),
            ),
            child: Text(
              "Thu nhập",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: (tabIndex == 1) ? Colors.white : Colors.black,
                fontSize: 17,
                height: 1,
              ),
            ),
          ),
        ],
        isScrollable: true,
      );
    }

    return DefaultTabController(
      length: 2,
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottomOpacity: 0,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "Tổng quan",
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    ImageConstant.icNotification,
                    width: size.width * 0.1,
                    height: size.width * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: size.width * 0.06,
                      left: size.width * 0.03,
                    ),
                    child: Container(
                      width: size.width * 0.03,
                      height: size.width * 0.03,
                      decoration: BoxDecoration(
                        color: ColorConstant.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              Image(
                image: AssetImage(ImageConstant.appLogo),
                width: size.height * 0.05,
                height: size.height * 0.05,
              ),
            ],
          ),
          body: Material(
            child: Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Text(
                        "Xin Chào",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.03,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Pé Vân Anh 👋🏻",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.03,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: size.height * 0.05,
                      ),
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                        top: size.height * 0.02,
                        bottom: size.height * 0.02,
                      ),
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height * 0.03),
                        color: ColorConstant.primaryColor.withOpacity(0.5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tổng số tiền",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.022,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                (_showAccountBalance)
                                    ? "21.112.000 đ"
                                    : "******** đ",
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.026,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    onToggleShowAccountBalance();
                                  });
                                },
                                child: Icon(
                                  _showAccountBalance
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye_outlined,
                                  color: _showAccountBalance
                                      ? ColorConstant.primaryColor
                                      : Colors.grey,
                                  size: size.height * 0.028,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Lịch trình hôm nay",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    _scheduleToday(size),
                    // ContainerD(size: size, indexSchToday: indexSchToday, lengthListDataTmp: lengthListDataTmp),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Phím tắt",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.024,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: size.width * 0.15,
                                        height: size.width * 0.15,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.yellow1
                                              .withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: ImageIcon(
                                          AssetImage(ImageConstant.icService),
                                          color: ColorConstant.yellow1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Yêu cầu",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/scheduleScreen');
                                      },
                                      child: Container(
                                        width: size.width * 0.15,
                                        height: size.width * 0.15,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.blueSky1
                                              .withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: ImageIcon(
                                          AssetImage(ImageConstant.icCalendar),
                                          color: ColorConstant.blueSky1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Lịch trình",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: size.width * 0.15,
                                        height: size.width * 0.15,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.purple1
                                              .withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: ImageIcon(
                                          AssetImage(ImageConstant.icHistory2),
                                          color: ColorConstant.purple1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Lịch sử",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.15,
                                      height: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color:
                                            ColorConstant.red1.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: ImageIcon(
                                        AssetImage(
                                            ImageConstant.icManageElder1),
                                        color: ColorConstant.red1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Người thân",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.15,
                                      height: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.blue1
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: ImageIcon(
                                        AssetImage(ImageConstant.icMore),
                                        color: ColorConstant.blue1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Dịch vụ",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.15,
                                      height: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.primaryColor
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: ImageIcon(
                                        AssetImage(ImageConstant.icMore),
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Thêm",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.15,
                                      height: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.primaryColor
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: ImageIcon(
                                        AssetImage(ImageConstant.icMore),
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Thêm",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.18,
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.15,
                                      height: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.primaryColor
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: ImageIcon(
                                        AssetImage(ImageConstant.icMore),
                                        color: ColorConstant.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      "Thêm",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        top: size.height * 0.03,
                      ),
                      child: Text(
                        "Thống kê",
                        style: GoogleFonts.roboto(
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        top: size.height * 0.03,
                      ),
                      child: Text(
                        "Chọn mục thống kê",
                        style: GoogleFonts.roboto(
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                        top: size.height * 0.02,
                      ),
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height * 0.01),
                        color: Colors.blueGrey.withOpacity(0.2),
                      ),
                      alignment: Alignment.center,
                      child: createTabBar(),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SizedBox(
                      height: size.height * 0.5,
                      child: TabBarView(
                        children: [
                          Material(
                            child: Container(
                              color: Colors.white,
                              width: size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const WorkPanel(),
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
                                    const BalancePanel(),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _scheduleToday(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.1, vertical: size.height * 0.02),
      height: size.height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          PageView.custom(
            controller: _pageController,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // return bookingItemWidget(context," value[index].title");

                return ListTile(
                  contentPadding: EdgeInsets.all(size.width*0.05),
                  leading: Image.asset(
                    ImageConstant.icScheduleItem,
                    width: size.height * 0.15,
                    height: size.height * 0.15,
                  ),
                  title: Text(
                    "${items[index]["name"]}",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height*0.01,),
                       Row(
                            
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: size.height * 0.03,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${items[index]["time"]}",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black87,
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),SizedBox(height: size.height*0.01,),
                       Text(
                        "${items[index]["address"]}",
                        style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                );
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstant.icScheduleItem,
                          width: size.height * 0.1,
                          height: size.height * 0.1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${items[index]["name"]}',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: size.height * 0.03,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${items[index]["time"]}",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black87,
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            // Text(''),
                            Text('${items[index]["address"]}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: items.length,
              // findChildIndexCallback: (Key key) {
              //   final ValueKey<String> valueKey =
              //       key as ValueKey<String>;
              //   final String data = valueKey.value;
              //   return items.indexOf(data);
              // }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              indexSchToday != 0
                  ? InkWell(
                      onTap: backSchedu,
                      child: SizedBox(
                        height: double.infinity,
                        width: 20,
                        child: Icon(Icons.arrow_back_ios_outlined),
                      ),
                    )
                  : SizedBox.shrink(),
              indexSchToday != lengthListDataTmp - 1
                  ? InkWell(
                      onTap: nextSchedu,
                      child: SizedBox(
                        height: double.infinity,
                        width: 20,
                        child: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }

  void onToggleShowAccountBalance() {
    setState(() {
      _showAccountBalance = !_showAccountBalance;
    });
  }
}

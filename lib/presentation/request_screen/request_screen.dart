import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/presentation/request_screen/widgets/waiting_for_confirm_panel.dart';
import 'package:elssit/presentation/splash_screen/splash_screen.dart';
import 'package:elssit/process/event/booking_event.dart';
import 'package:elssit/process/state/booking_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../../process/bloc/booking_bloc.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _bookingBloc = BookingBloc();
  @override
  void initState() {
    // _bookingBloc.stateController.add(LoadingDataState());
    _bookingBloc.eventController.sink.add(GetAllBookingWattingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabBar createTabBar() {
      return TabBar(
        indicatorColor: ColorConstant.primaryColor,
        labelPadding: const EdgeInsets.all(10),
        tabs: [
          SizedBox(
            width: size.width * 0.5,
            child: const Text(
              "Chờ xác nhận",
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
              "Đã xác nhận",
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
      length: 2,
      child: Scaffold(
        appBar: _appBar(size, createTabBar),
        // backgroundColor: ColorConstant.whiteA700,
        body: Container(
          color: Colors.white,
          child: TabBarView(children: [
            StreamBuilder<BookingState>(
             initialData: LoadingDataState(),
              stream: _bookingBloc.stateController.stream,
              builder: (context, snapshot) {
              if(snapshot.data is LoadingDataState){
                return Center(child: CircularProgressIndicator(color: ColorConstant.primaryColor,));
              }else if(snapshot.data is HaveBookingWattingState){
              
                return Material(
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
                          WaitingForConfirmPanel(
                              lisWaitingBooking:
                                  (snapshot.data as HaveBookingWattingState)
                                      .listBookingWatting),
                        ],
                      ),
                    ),
                  ),
                );
                }
                return SizedBox();
              }
            ),
            // Material(
            //   child: Container(
            //     color: Colors.white,
            //     width: size.width,
            //     child: SingleChildScrollView(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           SizedBox(
            //             height: size.height * 0.03,
            //           ),
            //           // const WaitingForConfirmPanel(),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }

  AppBar _appBar(Size size, TabBar createTabBar()) {
    return AppBar(
      toolbarHeight: size.height * 0.08,
      // bottomOpacity: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: ImageIcon(
        AssetImage(ImageConstant.appLogo),
        size: size.height * 0.03,
        color: ColorConstant.primaryColor,
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
            "Yêu cầu của bạn",
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
      bottom: createTabBar(),
    );
  }
}

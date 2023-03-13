import 'package:elssit/process/bloc/certification_bloc.dart';
import 'package:elssit/process/event/certification_event.dart';
import 'package:elssit/process/state/certification_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../splash_screen/splash_screen.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({Key? key}) : super(key: key);

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  final _certificationBloc = CertificationBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _certificationBloc.eventController.sink.add(GetAllCertCertificationEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<CertificationState>(
      stream: _certificationBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: size.height * 0.03,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chứng Nhận & Giấy Phép",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addNewCertificationScreen');
              },
              elevation: 0.0,
              backgroundColor: ColorConstant.primaryColor,
              child: const Icon(Icons.add),
            ),
            body: Material(
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ((snapshot.data as GetAllCertCertificationEvent)
                      //         .elderList
                      //         .data
                      //         .isEmpty)
                      //     ? const Text("chưa có data")
                      //     : ListView.separated(
                      //         scrollDirection: Axis.vertical,
                      //         padding: EdgeInsets.only(
                      //           left: size.width * 0.05,
                      //           right: size.width * 0.05,
                      //           top: size.height * 0.03,
                      //         ),
                      //         physics: const BouncingScrollPhysics(),
                      //         shrinkWrap: true,
                      //         itemBuilder: (context, index) => GestureDetector(
                      //           onTap: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => ElderDetailScreen(
                      //                       elderID: (snapshot.data
                      //                               as GetAllElderState)
                      //                           .elderList
                      //                           .data[index]
                      //                           .id),
                      //                 ));
                      //           },
                      //           child: elderItem(
                      //               context,
                      //               (snapshot.data as GetAllElderState)
                      //                   .elderList
                      //                   .data[index]),
                      //         ),
                      //         separatorBuilder: (context, index) => SizedBox(
                      //           height: size.height * 0.02,
                      //         ),
                      //         itemCount: (snapshot.data as GetAllElderState)
                      //             .elderList
                      //             .data
                      //             .length,
                      //       ),
                      Container(
                        padding: EdgeInsets.all(size.width * 0.05),
                        width: size.width,
                        margin: EdgeInsets.only(
                            left: size.width * 0.05, right: size.width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(size.height * 0.015),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // (package.img != null && package.img != "")
                            //     ? Container(
                            //   width: size.width * 0.3,
                            //   height: size.width * 0.3,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20),
                            //     image: DecorationImage(
                            //       image: NetworkImage(package.img!),
                            //       fit: BoxFit.fill,
                            //     ),
                            //   ),
                            // )
                            //     : Container(
                            //   width: size.width * 0.3,
                            //   height: size.width * 0.3,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20),
                            //   ),
                            // ),
                            Container(
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tên chứng chỉ",
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.02,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                Text(
                                  "Thời gian hiệu lực",
                                  style: GoogleFonts.roboto(
                                    fontSize: size.height * 0.016,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}

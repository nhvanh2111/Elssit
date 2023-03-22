import 'package:elssit/presentation/education_screen/widgets/education_detail_screen.dart';
import 'package:elssit/presentation/education_screen/widgets/education_item.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';

import 'package:elssit/process/bloc/education_bloc.dart';
import 'package:elssit/process/event/education_event.dart';
import 'package:elssit/process/state/education_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _educationBloc = EducationBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _educationBloc.eventController.sink.add(GetAllEducationEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<EducationState>(
      stream: _educationBloc.stateController.stream,
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
                  Navigator.pushNamed(context, '/accountScreen');
                },
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Học vấn",
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
                Navigator.pushNamed(context, '/addNewEducationScreen');
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
                      ((snapshot.data as GetAllEducationState)
                              .educationList
                              .data
                              .isEmpty)
                          ? const Text("chưa có data")
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                right: size.width * 0.05,
                                top: size.height * 0.03,
                              ),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EducationDetailScreen(
                                                educationID: (snapshot.data
                                                        as GetAllEducationState)
                                                    .educationList
                                                    .data[index]
                                                    .id),
                                      ));
                                },
                                child: educationItem(
                                    context,
                                    (snapshot.data as GetAllEducationState)
                                        .educationList
                                        .data[index]),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount: (snapshot.data as GetAllEducationState)
                                  .educationList
                                  .data
                                  .length,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}

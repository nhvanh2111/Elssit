import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/color_constant.dart';

import 'package:elssit/process/bloc/work_experience_bloc.dart';
import 'package:elssit/process/event/work_experience_event.dart';
import 'package:elssit/process/state/work_experience_state.dart';

import 'package:elssit/presentation/work_experience_screen/widgets/work_experience_detail_screen.dart';
import 'package:elssit/presentation/work_experience_screen/widgets/work_experience_item.dart';

class WorkExperienceSreen extends StatefulWidget {
  const WorkExperienceSreen({Key? key}) : super(key: key);

  @override
  State<WorkExperienceSreen> createState() => _WorkExperienceSreenState();
}

class _WorkExperienceSreenState extends State<WorkExperienceSreen> {
  final _workExperienceBloc = WorkExperienceBloc();

  @override
  void initState() {
    super.initState();
    _workExperienceBloc.eventController.sink.add(GetAllWorkExperienceEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<WorkExperienceState>(
      stream: _workExperienceBloc.stateController.stream,
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
                  "Danh sách kinh nghiệm làm việc",
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
                Navigator.pushNamed(context, '/addNewWorkExperienceScreen');
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
                      ((snapshot.data as GetAllWorkExperienceState)
                              .workExperienceList
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
                                            WorkExperienceDetailScreen(
                                                workExperienceID: (snapshot.data
                                                        as GetAllWorkExperienceState)
                                                    .workExperienceList
                                                    .data[index]
                                                    .id),
                                      ));
                                },
                                child: workExperienceItem(
                                    context,
                                    (snapshot.data as GetAllWorkExperienceState)
                                        .workExperienceList
                                        .data[index]),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount:
                                  (snapshot.data as GetAllWorkExperienceState)
                                      .workExperienceList
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

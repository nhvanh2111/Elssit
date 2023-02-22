import 'dart:collection';

import 'package:elssit/core/utils/image_constant.dart';
import 'package:elssit/presentation/schedule_screen/util/utils.dart';
import 'package:elssit/presentation/schedule_screen/widgets/booking_item_widget.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/models/test_models/test_schedule_data_model.dart';
import '../../core/utils/color_constant.dart';
import '../../process/bloc/booking_bloc.dart';
import '../../process/event/booking_event.dart';
import '../../process/state/booking_state.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final _bookingBloc = BookingBloc();
  final scheduleEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _bookingBloc.eventController.sink.add(TestGetAllBookingEvent());
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    // return kEvents[day] ?? [];
    return scheduleEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<Object>(
        stream: _bookingBloc.stateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is TestGetAllBookingState) {
              for (TestScheduleDataModel data
                  in (snapshot.data as TestGetAllBookingState).testModel.data) {
                if (scheduleEvents.containsKey(data.date)) {
                  scheduleEvents[data.date]!.add(Event(data.name));
                } else {
                  scheduleEvents.addAll({
                    data.date: [Event(data.name)]
                  });
                }
              }
              _bookingBloc.eventController.sink.add(OtherBookingEvent());
            }
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottomOpacity: 0.0,
              elevation: 0.0,
              backgroundColor: Colors.white,
              toolbarHeight: size.height * 0.03,
            ),
            body: Material(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.04,
                            right: size.width * 0.015,
                          ),
                          child: ImageIcon(
                            AssetImage(ImageConstant.appLogo),
                            size: size.height * 0.05,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                        Text(
                          "Lịch trình của tôi",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: size.height * 0.022,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.more_vert_outlined,
                          color: Colors.black,
                          size: size.height * 0.04,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width,
                      child: TableCalendar<Event>(
                        locale: 'vi-VN',
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        eventLoader: _getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: CalendarStyle(
                          // Use `CalendarStyle` to customize the UI
                          outsideDaysVisible: false,
                          selectedDecoration: BoxDecoration(
                              color: ColorConstant.primaryColor,
                              shape: BoxShape.circle),
                          todayDecoration: BoxDecoration(
                              color:
                                  ColorConstant.primaryColor.withOpacity(0.6),
                              shape: BoxShape.circle),
                        ),
                        onDaySelected: _onDaySelected,
                        onRangeSelected: _onRangeSelected,
                        onFormatChanged: (format) {},
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          if (value.isEmpty) {
                            return SizedBox(
                              width: size.width,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.04,
                                        ),
                                        Text(
                                          "Lịch trình(0)",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: size.height * 0.022,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Tất cả",
                                          style: GoogleFonts.roboto(
                                            color: ColorConstant.primaryColor,
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.04,
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      ImageConstant.icNoneBooking,
                                      width: size.width,
                                      height: size.height * 0.25,
                                    ),
                                    Text(
                                      "Bạn không có lịch trình nào vào ngày này",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              width: size.width,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.04,
                                        ),
                                        Text(
                                          "Lịch trình(${value.length})",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: size.height * 0.022,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Tất cả",
                                          style: GoogleFonts.roboto(
                                            color: ColorConstant.primaryColor,
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.04,
                                        ),
                                      ],
                                    ),
                                    ListView.separated(
                                      padding: EdgeInsets.only(
                                        top: size.height*0.02,
                                        left: size.width*0.02,
                                        right: size.width*0.02,
                                      ),
                                      itemCount: value.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      separatorBuilder: (context, index) => SizedBox(height: size.height*0.01,),
                                      itemBuilder: (context, index) {
                                        return bookingItemWidget(context, value[index].title);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );

                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

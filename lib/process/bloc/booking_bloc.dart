import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/models/test_models/test_schedule_model.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';
import '../event/booking_event.dart';
import '../state/booking_state.dart';

class BookingBloc {
  final eventController = StreamController<BookingEvent>();

  final stateController = StreamController<BookingState>();

  BookingBloc() {
    eventController.stream.listen((event) {
      if (event is TestGetAllBookingEvent) {
        testGetAll();
      }
      if (event is OtherBookingEvent) {
        stateController.sink.add(OtherBookingState()); //Test schedule event
      }
    });
  }
  Future<void> testGetAll() async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api-chi-de-test/testCalender");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(TestGetAllBookingState(
            testModel: TestScheduleModel.fromJson(json.decode(response.body))));
      } else {
        throw Exception('Unable to fetch test from the REST API');
      }
    } finally {}
  }
}

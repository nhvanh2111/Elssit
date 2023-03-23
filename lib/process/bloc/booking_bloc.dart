import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elssit/core/data/api/booking_api.dart';
import 'package:elssit/core/data/datasource/remote/booking_api_data_source.dart';
import 'package:elssit/core/data/respositories/booking_api_impl.dart';
import 'package:elssit/core/domain/respositories/booking_api_respo.dart';
import 'package:elssit/core/models/booking_models/booking.dart';
import 'package:elssit/core/models/booking_models/booking_detail.dart';
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
  BookingApiRespository respository= BookingApiImpl(ApiBookingRemoteDataSourceImpl(http.Client()));
  BookingBloc() {
    eventController.stream.listen((event) async {
      if (event is TestGetAllBookingEvent) {
        testGetAll();
      }
      if (event is OtherBookingEvent) {
        stateController.sink.add(OtherBookingState()); //Test schedule event
      }
      if (event is GetAllBookingWattingEvent) {
        List<Booking> rs = await BookingApi.getAllWaittingBooking();
        print(rs.length);
        if (rs.isNotEmpty) {
          stateController
              .add(HaveBookingWattingState(listBookingWatting: rs));
        }else{
          stateController.add(NotHaveDataState());
        }
      }
      if(event is GetBookingDetailEvent){
        BookingDetail? bookingDetail = await respository.getBookingDetail(event.idBooking);
        if(bookingDetail!=null){
          stateController.add(HaveBookingDetailState(bookingDetail: bookingDetail));
        }
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

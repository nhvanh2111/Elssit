import 'dart:convert';
import 'dart:io';
import 'package:elssit/core/models/booking_models/booking_detail.dart';
import 'package:elssit/core/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:elssit/core/models/booking_models/booking.dart';

abstract class ApiBookingRemoteDataSource {
  Future<List<Booking>> getAllWaittingBooking();
  Future<BookingDetail?> getBookingDetail(String bookingId);
}

class ApiBookingRemoteDataSourceImpl extends ApiBookingRemoteDataSource {
  ApiBookingRemoteDataSourceImpl(this.httpClient);
  final http.Client httpClient;
 
  @override
  Future<List<Booking>> getAllWaittingBooking() async{
    List<Booking> listRs = [];
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/booking/mobile/get-all-booking-by-status-and-sitter_id/WAITING/97733cb3-106e-4173-b519-b9c68e2acd4c");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        var dataResponse = jsonDecode(response.body);
        Iterable listData = dataResponse["data"];

        final mapData = listData.cast<Map<String, dynamic>>();
        listRs = mapData.map<Booking>((json) {
          return Booking.fromJson(json);
        }).toList();
      } else {
        listRs = [];
      }
    } catch (e) {
      listRs = [];
    }
    return listRs;
  }
  
  @override
  Future<BookingDetail?> getBookingDetail(String boookingId)async {
   late BookingDetail bookingDetail;
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/booking/common/get-full-detail-booking/${boookingId}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      print(response.body.toString());

      if (response.statusCode == 200) {
        var dataResponse = jsonDecode(response.body);
        print("ok");
        bookingDetail=BookingDetail.fromJson(dataResponse['data']);
        return bookingDetail;
      }
    } catch (e) {
     print(e.toString());
    }
    return Future<BookingDetail>.value(null);
  }
}

import 'dart:convert';

import 'package:elssit/core/constants/app_link.dart';
import 'package:elssit/core/models/booking_models/booking.dart';
import 'package:elssit/core/models/booking_models/booking_detail.dart';
import 'package:elssit/core/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;

class BookingApi{
  static Future<List<Booking>> getAllWaittingBooking() async{
    List<Booking> listRs = [];
    try {
      var url = Uri.parse(
          "${AppLink.BOOKING_GET_ALL_WAITING}${globals.sitterID}");
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
 static Future<BookingDetail?> getBookingDetail(String boookingId)async {
   late BookingDetail bookingDetail;
    try {
      var url = Uri.parse(
          AppLink.BOOKING_GET_DETAIL + boookingId);
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
    return null;
  }
}
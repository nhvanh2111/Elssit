import 'dart:convert';

import 'package:elssit/core/models/booking_models/booking.dart';
import 'package:elssit/core/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;

class BookingApi{
  static Future<List<Booking>> getAllWaittingBooking() async{
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
      print("exce" +e.toString());
      listRs = [];
    }
    return listRs;
  } 
}
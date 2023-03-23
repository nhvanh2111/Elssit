import 'package:elssit/core/models/booking_models/booking.dart';
import 'package:elssit/core/models/booking_models/booking_detail.dart';

abstract class BookingApiRespository{
  Future<List<Booking>> getAllWaittingBooking();
  Future<BookingDetail?> getBookingDetail(String bookingId);
}
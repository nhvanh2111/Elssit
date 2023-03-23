import 'package:elssit/core/data/datasource/remote/booking_api_data_source.dart';
import 'package:elssit/core/domain/respositories/booking_api_respo.dart';
import 'package:elssit/core/models/booking_models/booking.dart';
import 'package:elssit/core/models/booking_models/booking_detail.dart';

class BookingApiImpl implements BookingApiRespository{
  final ApiBookingRemoteDataSource apiBookingDataSource;
  BookingApiImpl(this.apiBookingDataSource);
  @override
  Future<List<Booking>> getAllWaittingBooking() {
    final listWattingBooking = apiBookingDataSource.getAllWaittingBooking();
    return listWattingBooking;
  }

  @override
  Future<BookingDetail?> getBookingDetail(String bookingId) {
    final bookingDetail = apiBookingDataSource.getBookingDetail(bookingId);
    return bookingDetail;
  }

}
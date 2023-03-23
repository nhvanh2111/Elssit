import 'package:elssit/core/models/booking_models/booking_detail.dart';

import '../../core/models/test_models/test_schedule_model.dart';
import '../../core/models/booking_models/booking.dart';
abstract class BookingState{}

class TestGetAllBookingState extends BookingState{
  TestGetAllBookingState({required this.testModel});
  final TestScheduleModel testModel;
}

class OtherBookingState extends BookingState{}
class LoadingDataState extends BookingState{
}
class NotHaveDataState extends BookingState{
}
class HaveBookingWattingState extends BookingState {
  HaveBookingWattingState({required this.listBookingWatting});
  final List<Booking> listBookingWatting;
}
class HaveBookingDetailState extends BookingState {
  HaveBookingDetailState({required this.bookingDetail});
  final BookingDetail bookingDetail;
}
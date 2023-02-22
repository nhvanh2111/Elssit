import '../../core/models/test_models/test_schedule_model.dart';

abstract class BookingState{}

class TestGetAllBookingState extends BookingState{
  TestGetAllBookingState({required this.testModel});
  final TestScheduleModel testModel;
}

class OtherBookingState extends BookingState{}
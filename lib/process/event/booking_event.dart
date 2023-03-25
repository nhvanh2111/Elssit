
abstract class BookingEvent{}

class TestGetAllBookingEvent extends BookingEvent{

}

class GetAllBookingWattingEvent extends BookingEvent{}
class GetBookingDetailEvent extends BookingEvent{
  GetBookingDetailEvent(this.idBooking);
  final idBooking;
}
class OtherBookingEvent extends BookingEvent{}
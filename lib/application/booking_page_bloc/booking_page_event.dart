abstract class BookingPageEvent{}
class OnShufleRoomBooking extends BookingPageEvent{
  final List<dynamic> listOfRooms;

  OnShufleRoomBooking({required this.listOfRooms});
}
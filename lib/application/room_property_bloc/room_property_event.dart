
abstract class RoomPropertyEvent {}

class OnSettingHotelIdEvent extends RoomPropertyEvent{
  final String hotelId;

  OnSettingHotelIdEvent({required this.hotelId});
}

class OnFeatureAddingEvent extends RoomPropertyEvent{
  final String text;

  OnFeatureAddingEvent({required this.text});
}
class OnFeatureDeletedEvent extends RoomPropertyEvent{
  final String text;

  OnFeatureDeletedEvent({required this.text});
}
class OnClickToAddMultipleImageEvent extends RoomPropertyEvent{}
class OnBedSelectEvent extends RoomPropertyEvent{
  final int numberOfBed;

  OnBedSelectEvent({required this.numberOfBed});
  
}
class OnAddRoomDeatailsEvent extends RoomPropertyEvent{
  final String roomNumber;
  final int price;

  OnAddRoomDeatailsEvent({required this.roomNumber, required this.price});

}
class RoomNumberTypingEvent extends RoomPropertyEvent{
  final String roomNumber;
  final String hotelId;

  RoomNumberTypingEvent({required this.roomNumber, required this.hotelId});
}
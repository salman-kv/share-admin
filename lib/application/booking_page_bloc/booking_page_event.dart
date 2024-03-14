import 'package:flutter/material.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';

abstract class BookingPageEvent{}
class OnShufleRoomBooking extends BookingPageEvent{
  final List<dynamic> listOfRooms;

  OnShufleRoomBooking({required this.listOfRooms});
}
class OnCheckoutButtonClicked extends BookingPageEvent{
  final BuildContext context;
  final RoomBookingModel roomBookingModel;

  OnCheckoutButtonClicked({required this.context, required this.roomBookingModel});
}
class OnCheckInButtonClicked extends BookingPageEvent{
  final BuildContext context;
  final RoomBookingModel roomBookingModel;

  OnCheckInButtonClicked({required this.context, required this.roomBookingModel});
}
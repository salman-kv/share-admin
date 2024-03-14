import 'package:share_sub_admin/domain/model/room_booking_model.dart';

abstract class BookingPageState{}
class InitialBookingPageState extends BookingPageState{}
class BookingShufleLoadingState extends BookingPageState{}
class BookingShufleSuccessState extends BookingPageState{
}
class CheckoutLoadingState extends BookingPageState{}
class CheckoutSuccessState extends BookingPageState{}
class CheckInLoadingState extends BookingPageState{}
class CheckInSuccessState extends BookingPageState{}
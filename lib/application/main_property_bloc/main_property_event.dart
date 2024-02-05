import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';

abstract class MainPropertyEvent{}

class OnCurrentLocationClickEvent extends MainPropertyEvent{

}
class OnClickOtherLocationEvent extends MainPropertyEvent{
  final LatLng latLng;

  OnClickOtherLocationEvent({required this.latLng});
}

class OnSubmitLocationEvent extends MainPropertyEvent{}
class OnClickToAddMultipleImage extends MainPropertyEvent{}
class OnCatogorySelect extends MainPropertyEvent{
  final HotelType hotelType;

  OnCatogorySelect({required this.hotelType});
}

class OnSubmittingDeatailsEvent extends MainPropertyEvent{
  final String name;
  final String place;

  OnSubmittingDeatailsEvent({required this.name, required this.place});
}
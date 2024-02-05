import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_event.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_state.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';

class MainPropertyBloc extends Bloc<MainPropertyEvent, MainPropertyState> {
  LatLng? latLng;
  List<XFile> image = [];
  HotelType? hotelType;
  MainPropertyBloc() : super(MainPropertyInitialState()) {
    on<OnCurrentLocationClickEvent>((event, emit) async {
      emit(MainPropertyCurrentLocationPickingLoadingState());
      Position position = await SubAdminFunction().getCurrentPosition();
      latLng = LatLng(position.latitude, position.longitude);
      emit(MainPropertyCurrentLocationPickedState());
    });
    on<OnClickOtherLocationEvent>((event, emit) {
      latLng = event.latLng;
      emit(MainPropertyCurrentLocationPickedState());
    });
    on<OnSubmitLocationEvent>((event, emit) {
      emit(MainPropertyInitialState());
    });
    on<OnClickToAddMultipleImage>((event, emit) async {
      var nweImage = await SubAdminFunction().subAdminPickMultipleImage();
      image.addAll(nweImage);
      emit(MainPropertyInitialState());
    });
    on<OnCatogorySelect>((event, emit) {
      hotelType = event.hotelType;
      emit(MainPropertyInitialState());
    });
    on<OnSubmittingDeatailsEvent>((event, emit) async {
      emit(MainPropertyLoadingState());
      List<String> imageList =
          await SubAdminFunction().uploadListImageToFirebase(image);
      MainPropertyModel model = MainPropertyModel(
          propertyNmae: event.name,
          place: event.place,
          hotelType: hotelType!,
          latLng: latLng!,
          image: imageList,
          rooms: []
          );
      var hotelId = await SubAdminFunction().addSubAdminHotelDeatails(model);
      log(hotelId);
      String userId = await SharedPreferencesClass.getUserId();
      await SubAdminFunction().addHotelIdToSubAdminDocument(userId, hotelId);
      emit(MainPropertyUpdatedState());
    });
  }
}

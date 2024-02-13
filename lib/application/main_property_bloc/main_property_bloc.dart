import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_event.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';

class MainPropertyBloc extends Bloc<MainPropertyEvent, MainPropertyState> {
  LatLng? latLng;
  List<dynamic> image = [];
  List<dynamic> editImage = [];
  HotelType? hotelType;
  Set<Marker> marker = {};
  bool editing = false;
  String? hotelId;
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
      if (nweImage.isNotEmpty) {
        emit(ImageAddingState());
        List<dynamic> returnUrl =
            await SubAdminFunction().uploadListImageToFirebase(nweImage);
        image.addAll(returnUrl);
        emit(ImageAddedState());
      }
    });
    on<OnDeleteImageEvent>((event, emit) {
      bool val = image.remove(event.image);
      log('deleted');
      log('$val');
      emit(ImageDeletedState());
    });
    on<OnCatogorySelect>((event, emit) {
      hotelType = event.hotelType;
      emit(CatagoryAddedState());
    });
    on<OnSubmittingDeatailsEvent>((event, emit) async {
      emit(MainPropertyLoadingState());
      MainPropertyModel model = MainPropertyModel(
          propertyNmae: event.name,
          place: event.place,
          hotelType: hotelType!,
          latLng: latLng!,
          image: image,
          rooms: []);
      log('${model.latLng}');
      if (editing) {
        SubAdminFunction().addEditedSubAdminHotelDeatails(model, hotelId!);
      } else {
        var hotelId = await SubAdminFunction().addSubAdminHotelDeatails(model);
        String userId = await SharedPreferencesClass.getUserId();
        await SubAdminFunction().addHotelIdToSubAdminDocument(userId, hotelId);
      }
      emit(MainPropertyUpdatedState());
    });
    on<DataLoadingToBlocEvent>((event, emit) {
      hotelId = hotelId;
      editing = true;
      hotelType = event.propertyModel.hotelType;
      latLng = event.propertyModel.latLng;
      image = event.propertyModel.image;
      marker.add(
        Marker(
          markerId: const MarkerId('current position'),
          position: LatLng(event.propertyModel.latLng.latitude,
              event.propertyModel.latLng.longitude),
        ),
      );
    });
  }
}

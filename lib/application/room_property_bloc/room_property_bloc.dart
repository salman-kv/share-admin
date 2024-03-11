import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_event.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';

class RoomPropertyBloc extends Bloc<RoomPropertyEvent, RoomPropertyState> {
  MainPropertyModel? propertyModel;
  String? hotelId;
  List<dynamic> features = [];
  List<String> image = [];
  List<dynamic> editImage = [];
  int? numberOfBed;
  String? roomNumber;
  String? staticEditRoomNumber;
  int? price;
  RoomPropertyBloc() : super(RoomPropertyBlocInitial()) {
    on<OnSettingHotelIdEvent>((event, emit) {
      hotelId = event.hotelId;
    });
    on<OnFeatureAddingEvent>((event, emit) {
      if (features.contains(event.text)) {
        emit(FeatureAlreadyExistState());
      } else {
        features.add(event.text);
        emit(FeatureAddedState());
      }
    });
    on<OnFeatureDeletedEvent>((event, emit) {
      features.remove(event.text);
      emit(FeatureDeletedState());
    });
    on<FeatureAddingByCheckedBoxEvent>((event, emit) {
      if (features.contains(event.text)) {
        features.remove(event.text);
        emit(FeatureDeletedState());
      } else {
        features.add(event.text);
        emit(FeatureAddedState());
      }
    });
    on<OnClickToAddMultipleImageEvent>((event, emit) async {
      var nweImage = await SubAdminFunction().subAdminPickMultipleImage();
      image.addAll(nweImage);
      emit(MultipleImageAddedState());
    });
    on<OnClickEditToAddMultipleImageEvent>((event, emit) async {
      var nweImage = await SubAdminFunction().subAdminPickMultipleImage();
      if (nweImage.isNotEmpty) {
        emit(ImageLoadingState());

        List<String> listOfImage =
            await SubAdminFunction().uploadListImageToFirebase(nweImage);
        editImage.addAll(listOfImage);
        emit(MultipleImageAddedState());
      }
    });
    on<OnBedSelectEvent>((event, emit) {
      numberOfBed = event.numberOfBed;
      emit(NumberOfBedSelectedState());
    });
    on<OnAddRoomDeatailsEvent>((event, emit) async {
      emit(RoomDeatailsSubmittingLoadingState());
      final returnimage =
          await SubAdminFunction().uploadListImageToFirebase(image);
          log('befor model');
      final RoomModel roomModel = RoomModel(
          hotelId: hotelId!,
          hotelName: propertyModel!.propertyNmae,
          roomNumber: event.roomNumber,
          price: event.price,
          numberOfBed: numberOfBed!,
          features: features,
          images: returnimage,
          availability: true,
          roomType: propertyModel!.hotelType,
          latlng: propertyModel!.latLng,
          place: propertyModel!.place,
          roomId: ''
          );
          log('after model');
      String roomId =
          await SubAdminFunction().addSubAdminRoomDeatails(roomModel);
      SubAdminFunction().addRoomlIdToHotelDocument(hotelId!, roomId);
      emit(RoomDeatailsSubmittedState());
    });
    on<OnAddEditedRoomDeatailsEvent>((event, emit) async {
      emit(RoomDeatailsSubmittingLoadingState());
      final RoomModel roomModel = RoomModel(
          hotelId: hotelId!,
          hotelName: propertyModel!.propertyNmae,
          roomNumber: event.roomNumber,
          price: event.price,
          numberOfBed: numberOfBed!,
          features: features,
          images: editImage,
          availability: true,
          roomType: propertyModel!.hotelType,
          latlng: propertyModel!.latLng,
          place: propertyModel!.place,
          roomId: ''
          );
      await SubAdminFunction()
          .addSubAdminEditedRoomDeatails(roomModel, event.roomId);
      emit(RoomDeatailsSubmittedState());
    });
    on<RoomNumberTypingEvent>((event, emit) async {
      emit(RoomNumberTypingState());
      final instant = await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .where(FirebaseFirestoreConst.firebaseFireStoreHotelId,
              isEqualTo: event.hotelId)
          .where(FirebaseFirestoreConst.firebaseFireStoreRoomNumber,
              isEqualTo: event.roomNumber)
          .get();
      if (instant.docs.isEmpty) {
        roomNumber = event.roomNumber;
        emit(RoomNumberSuccessState());
      } else {
        roomNumber = null;
        emit(RoomNumberFailedState());
      }
    });
    on<EditingRoomNumberTypingEvent>((event, emit) async {
      emit(RoomNumberTypingState());
      if (event.roomNumber != event.staticRoomId) {
        final instant = await FirebaseFirestore.instance
            .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
            .where(FirebaseFirestoreConst.firebaseFireStoreHotelId,
                isEqualTo: event.hotelId)
            .where(FirebaseFirestoreConst.firebaseFireStoreRoomNumber,
                isEqualTo: event.roomNumber)
            .get();
        if (instant.docs.isEmpty) {
          roomNumber = event.roomNumber;
          emit(RoomNumberSuccessState());
        } else {
          roomNumber = null;
          emit(RoomNumberFailedState());
        }
      } else {
        log('same room number');
        emit(RoomNumberSuccessState());
      }
    });
    on<CleanExistingDataFromRommBlocEvent>((event, emit) {
      features = [];
      numberOfBed = null;
      image = [];
    });
    on<OnDeleteImageEvent>((event, emit) {
      image.remove(event.image);
      emit(ImageDeletedState());
    });
    on<OnDeleteEditImageEvent>((event, emit) {
      editImage.remove(event.image);
      emit(ImageDeletedState());
    });
  }
}

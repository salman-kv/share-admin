import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';

class Streams {

static Stream<List<RoomModel>> roomModelStreming(String hotelId) async* {
  List<RoomModel> roomModel = [];
  final instant = FirebaseFirestore.instance
      .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
      .doc(hotelId)
      .snapshots();

  await for (final element in instant) {
    Map<String, dynamic> e = element.data() as Map<String, dynamic>;
    List<dynamic> listRoomId = e[FirebaseFirestoreConst.firebaseFireStoreRooms];
    for (String roomId in listRoomId) {
      final returnRoomDetails = await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .doc(roomId)
          .get();
      Map<String, dynamic> mapReturnRoom = returnRoomDetails.data() as Map<String, dynamic>;
      RoomModel roomDeataiRoomModel = RoomModel(
        availability: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomAvailability],
        hotelId: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreHotelId],
        hotelName: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreHotelName],
        roomNumber: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
        price: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
        numberOfBed: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreNumberOfBed],
        features: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomFeatures],
        images: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomImages],
      );
      roomModel.add(roomDeataiRoomModel);
    }
    yield roomModel; 
  }
}

  // Stream<List<RoomModel>> roomModelStreming(String hotelId) async* {
  //     List<RoomModel> roomModel = [];
  //   final instant = FirebaseFirestore.instance
  //       .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
  //       .doc(hotelId)
  //       .snapshots();

  //   instant.forEach((element) async {
  //     Map<String, dynamic> e = element.data() as Map<String, dynamic>;
  //     List<dynamic> listRoomId =
  //         e[FirebaseFirestoreConst.firebaseFireStoreRooms];
  //     for (String roomId in listRoomId) {
  //       final returnRoomDetails = await FirebaseFirestore.instance
  //           .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
  //           .doc(roomId)
  //           .get();
  //       Map<String, dynamic> mapReturnRoom =
  //           returnRoomDetails.data() as Map<String, dynamic>;
  //       RoomModel roomDeataiRoomModel = RoomModel(
  //           availability: mapReturnRoom[
  //               FirebaseFirestoreConst.firebaseFireStoreRoomAvailability],
  //           hotelId:
  //               mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreHotelId],
  //           hotelName: mapReturnRoom[
  //               FirebaseFirestoreConst.firebaseFireStoreHotelName],
  //           roomNumber: mapReturnRoom[
  //               FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
  //           price: mapReturnRoom[
  //               FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
  //           numberOfBed: mapReturnRoom[
  //               FirebaseFirestoreConst.firebaseFireStoreNumberOfBed],
  //           features: mapReturnRoom[
  //               FirebaseFirestoreConst.firebaseFireStoreRoomFeatures],
  //           images: mapReturnRoom[
  //               FirebaseFirestoreConst.firebaseFireStoreRoomImages]);
  //               print(roomDeataiRoomModel.hotelId);
  //       roomModel.add(roomDeataiRoomModel);
  //     }
  //   });
  //   yield roomModel;
  // }
}

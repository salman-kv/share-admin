import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';

class Streams {

static Stream<RoomModel> roomModelStreming(String hotelId) async* {
    final hotelDocument = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
        .doc(hotelId);

    final roomsStream = hotelDocument
        .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
        .snapshots();

    // Listen to changes in the rooms collection and yield each RoomModel
    await for (final QuerySnapshot roomSnapshot in roomsStream) {
      for (final roomDoc in roomSnapshot.docs) {
        final roomData = roomDoc.data() as Map<String, dynamic>;

        // Create RoomModel object from room data
        final roomModel = RoomModel(
          availability: roomData[FirebaseFirestoreConst.firebaseFireStoreRoomAvailability],
          hotelId: roomData[FirebaseFirestoreConst.firebaseFireStoreHotelId],
          hotelName: roomData[FirebaseFirestoreConst.firebaseFireStoreHotelName],
          roomNumber: roomData[FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
          price: roomData[FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
          numberOfBed: roomData[FirebaseFirestoreConst.firebaseFireStoreNumberOfBed],
          features: roomData[FirebaseFirestoreConst.firebaseFireStoreRoomFeatures],
          images: roomData[FirebaseFirestoreConst.firebaseFireStoreRoomImages],
        );

        // Yield the RoomModel
        yield roomModel;
      }
    }
  }
}

  // final instant = FirebaseFirestore.instance
  //     .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
  //     .doc(hotelId)
  //     .snapshots();

  // await for (final element in instant) {
  //   Map<String, dynamic> e = element.data() as Map<String, dynamic>;
  //   List<dynamic> listRoomId = e[FirebaseFirestoreConst.firebaseFireStoreRooms];
  //   for (String roomId in listRoomId) {
  //     final returnRoomDetails = await FirebaseFirestore.instance
  //         .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
  //         .doc(roomId)
  //         .get();
  //     Map<String, dynamic> mapReturnRoom = returnRoomDetails.data() as Map<String, dynamic>;
  //     RoomModel roomDeataiRoomModel = RoomModel(
  //       availability: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomAvailability],
  //       hotelId: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreHotelId],
  //       hotelName: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreHotelName],
  //       roomNumber: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
  //       price: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
  //       numberOfBed: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreNumberOfBed],
  //       features: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomFeatures],
  //       images: mapReturnRoom[FirebaseFirestoreConst.firebaseFireStoreRoomImages],
  //     );
  //   yield roomDeataiRoomModel;
  //   }
  //   // yield roomModel; 
  // }

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

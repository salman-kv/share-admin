import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';

class RoomModel {
  final String hotelId;
  final String hotelName;
  final String roomNumber;
  final int price;
  final int numberOfBed;
  final List<dynamic> features;
  final List<dynamic> images;
  final bool? availability;

  RoomModel(
      {required this.availability,
      required this.hotelId,
      required this.hotelName,
      required this.roomNumber,
      required this.price,
      required this.numberOfBed,
      required this.features,
      required this.images});

  static Map<String, dynamic> toMap(RoomModel roomModel) {
    return {
      FirebaseFirestoreConst.firebaseFireStoreHotelId: roomModel.hotelId,
      FirebaseFirestoreConst.firebaseFireStoreHotelName: roomModel.hotelName,
      FirebaseFirestoreConst.firebaseFireStoreRoomNumber: roomModel.roomNumber,
      FirebaseFirestoreConst.firebaseFireStoreRoomPrice: roomModel.price,
      FirebaseFirestoreConst.firebaseFireStoreNumberOfBed:
          roomModel.numberOfBed,
      FirebaseFirestoreConst.firebaseFireStoreRoomFeatures: roomModel.features,
      FirebaseFirestoreConst.firebaseFireStoreRoomImages: roomModel.images,
      FirebaseFirestoreConst.firebaseFireStoreRoomAvailability:
          roomModel.availability
    };
  }

  static RoomModel fromMap(Map<String, dynamic> map) {
    return RoomModel(
        availability:
            map[FirebaseFirestoreConst.firebaseFireStoreRoomAvailability],
        hotelId: map[FirebaseFirestoreConst.firebaseFireStoreHotelId],
        hotelName: map[FirebaseFirestoreConst.firebaseFireStoreHotelName],
        roomNumber: map[FirebaseFirestoreConst.firebaseFireStoreRoomNumber],
        price: map[FirebaseFirestoreConst.firebaseFireStoreRoomPrice],
        numberOfBed: map[FirebaseFirestoreConst.firebaseFireStoreNumberOfBed],
        features: map[FirebaseFirestoreConst.firebaseFireStoreRoomFeatures],
        images: map[FirebaseFirestoreConst.firebaseFireStoreRoomImages]);
  }
}


//  FirebaseFirestoreConst.firebaseFireStoreHotelId:roomModel.hotelId,
//       FirebaseFirestoreConst.firebaseFireStoreHotelName: roomModel.hotelName,
//       FirebaseFirestoreConst.firebaseFireStoreRoomNumber: roomModel.roomNumber,
//       FirebaseFirestoreConst.firebaseFireStoreRoomPrice: roomModel.price,
//       FirebaseFirestoreConst.firebaseFireStoreNumberOfBed: roomModel.numberOfBed,
//       FirebaseFirestoreConst.firebaseFireStoreRoomFeatures: roomModel.features,
//       FirebaseFirestoreConst.firebaseFireStoreRoomImages: roomModel.images,
//       FirebaseFirestoreConst.firebaseFireStoreRoomAvailability: roomModel.availability
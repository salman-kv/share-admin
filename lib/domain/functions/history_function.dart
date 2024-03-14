import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';

class HistoryFunction {
  historyFunction({required RoomBookingModel roomBookingModel}) async {
    await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
        .get()
        .then((value) async {
      for (var i in value.docs) {
        if (i.data().containsKey('hotel')) {
          if (i.data()['hotel'].contains(roomBookingModel.hotelId)) {
            // add to notification
            await FirebaseFirestore.instance
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
                .doc(i.id)
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreBookingHistory)
                .add(roomBookingModel.toMap());
          }
        }
      }
    });
  }
}

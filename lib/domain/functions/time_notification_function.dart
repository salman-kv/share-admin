import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/notification_model.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';

class NotificationFunction {
  notificationFunction(
      {required RoomBookingModel roomBookingModel,
      required String notificationPurpose,
      required String notificationData}) async {
    // add to notification
    NotificationModel notificationModel = NotificationModel(
        opened: false,
        notificationTime: DateTime.now(),
        notificationPurpose: notificationPurpose,
        notificationData: notificationData,
        roomBookingModel: roomBookingModel);
    await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection)
        .doc(roomBookingModel.userId)
        .collection(FirebaseFirestoreConst.firebaseFireStoreNotification)
        .add(notificationModel.toMap());
  }

  toDateOnly({required DateTime dateTime}) {
    return '${dateTime.day} / ${dateTime.month} / ${dateTime.year}';
  }

  toTimeOnly({required DateTime dateTime}) {
    return '${dateTime.hour == 0 ? 1 : dateTime.hour <= 12 ? dateTime.hour : dateTime.hour - 12} : ${dateTime.minute}  ${dateTime.hour < 12 ? 'AM' : 'PM'} ';
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/notification_bloc/notification_event.dart';
import 'package:share_sub_admin/application/notification_bloc/notification_state.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  int? notificationCount;
  NotificationBloc() : super(InitialNotificationState()) {
    on<OnNotificationDataSnapshotEvent>((event, emit) {
      notificationCount = null;
      for (var i in event.snapshot.data!.docs) {
        if (i[FirebaseFirestoreConst.firebaseFireStoreNotificationOpened] ==
            false) {
          notificationCount = (notificationCount ?? 0) + 1;
        }
      }
      log('${notificationCount} =======================================');
      emit(NotificationCountSuccessState());
    });
    on<OnTapNotificationButtonEvent>((event, emit) async {
      for (var i in event.snapshot.data!.docs) {
        log('ppppppppppppppppp');
        if (i[FirebaseFirestoreConst.firebaseFireStoreNotificationOpened] ==
            false) {
              log('lllllllllllllllllll');
          await FirebaseFirestore.instance
              .collection(
                  FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
              .doc(BlocProvider.of<SubAdminLoginBloc>(event.context).userId)
              .collection(FirebaseFirestoreConst.firebaseFireStoreNotification)
              .doc(i.id)
              .update({
            FirebaseFirestoreConst.firebaseFireStoreNotificationOpened: true
          });
        }
      }
      emit(NotificationCountSuccessState());
    });
  }
}

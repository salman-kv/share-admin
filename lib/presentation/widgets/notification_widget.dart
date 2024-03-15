import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/notification_bloc/notification_bloc.dart';
import 'package:share_sub_admin/application/notification_bloc/notification_event.dart';
import 'package:share_sub_admin/application/notification_bloc/notification_state.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/functions/time_notification_function.dart';
import 'package:share_sub_admin/domain/model/notification_model.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_pages/notification/notification.dart';

class NotificationWidget {
  notificationButton({required BuildContext context}) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
            .doc(BlocProvider.of<SubAdminLoginBloc>(context).userId)
            .collection(FirebaseFirestoreConst.firebaseFireStoreNotification)
            .orderBy(FirebaseFirestoreConst.firebaseFireStoreNotificationTime,
                descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              BlocProvider.of<NotificationBloc>(context)
                  .add(OnNotificationDataSnapshotEvent(snapshot: snapshot));
              return BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            size: 28,
                          ),
                          onPressed: () {
                            BlocProvider.of<NotificationBloc>(context).add(
                                OnTapNotificationButtonEvent(
                                    snapshot: snapshot, context: context));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return NotificationScreen(
                                  data: snapshot,
                                );
                              },
                            ));
                          },
                        ),
                        context.watch<NotificationBloc>().notificationCount !=
                                null
                            ? Positioned(
                                right: 5,
                                top: 5,
                                child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.045,
                                    width: MediaQuery.of(context).size.width *
                                        0.045,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 236, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Text(
                                      '${BlocProvider.of<NotificationBloc>(context).notificationCount}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return NotificationScreen(
                            data: snapshot,
                          );
                        },
                      ));
                    },
                    icon: const Icon(Icons.notifications_active_outlined),
                  ));
            }
          } else {
            log('no dataaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
            return Icon(Icons.abc);
          }
        });
  }

  notificationContainer(
      {required NotificationModel notification,
      required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ConstColors().mainColorpurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.notificationPurpose,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(notification.notificationData,
              style: Theme.of(context).textTheme.displaySmall),
          Text(
              'Date : ${NotificationFunction().toDateOnly(dateTime: notification.notificationTime)} ',
              style: Theme.of(context).textTheme.displaySmall),
          Text(
              'Time : ${NotificationFunction().toTimeOnly(dateTime: notification.notificationTime)} ',
              style: Theme.of(context).textTheme.displaySmall)
        ],
      ),
    );
  }
}

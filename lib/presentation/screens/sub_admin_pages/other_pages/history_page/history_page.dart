import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'History',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(FirebaseFirestoreConst
                      .firebaseFireStoreSubAdminCollection)
                  .doc(BlocProvider.of<SubAdminLoginBloc>(context).userId)
                  .collection(
                      FirebaseFirestoreConst.firebaseFireStoreBookingHistory)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        return CommonWidget().historyContainer(
                            roomBookingModel: RoomBookingModel.fromMap(
                                snapshot.data!.docs[index].data()),
                            context: context);
                      }),
                    );
                  } else {
                    return CommonWidget()
                        .noDataWidget(text: 'No History now', context: context);
                  }
                } else {
                  return const SizedBox();
                }
              },
            )));
  }
}

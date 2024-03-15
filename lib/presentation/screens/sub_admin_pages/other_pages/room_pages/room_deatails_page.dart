import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';

class RoomDeatailsShowingPage extends StatelessWidget {
  final String roomId;
  const RoomDeatailsShowingPage({required this.roomId, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Room Deatails',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
              .doc(roomId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.exists) {
                List<Widget> imageWidget = [];
                for (var element in snapshot.data!.data()![
                    FirebaseFirestoreConst.firebaseFireStoreRoomImages]) {
                  imageWidget.add(Image.network('$element'));
                }
                return ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: ConstColors().mainColorpurple.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: CarouselSlider(
                          items: imageWidget, options: CarouselOptions()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.data()![FirebaseFirestoreConst
                                .firebaseFireStoreRoomNumber],
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                              'Hotel Name : ${snapshot.data!.data()![FirebaseFirestoreConst.firebaseFireStoreHotelName]}',
                              style: Theme.of(context).textTheme.displayMedium),
                          Text('Features',
                              style: Theme.of(context).textTheme.titleMedium),
                          Column(
                            children: List.generate(
                                snapshot.data!
                                    .data()![FirebaseFirestoreConst
                                        .firebaseFireStoreRoomFeatures]
                                    .length, (index) {
                              return Text(snapshot.data!.data()![
                                  FirebaseFirestoreConst
                                      .firebaseFireStoreRoomFeatures][index]);
                            }),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreRoomCollection)
                          .doc(roomId)
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreCurrentUserCheckInRoom)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Current Enrolled Room',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                CommonWidget().historyContainer(
                                    roomBookingModel: RoomBookingModel.fromMap(
                                        snapshot.data!.docs[0].data()),
                                    context: context)
                              ],
                            );
                          } else {
                            return Text('noooooooo');
                          }
                        } else {
                          return Text('no data');
                        }
                      },
                    ),
                    snapshot.data!.data()![FirebaseFirestoreConst
                                .firebaseFireStoreBookingDeatails] !=
                            null
                        ? snapshot.data!
                                .data()![FirebaseFirestoreConst
                                    .firebaseFireStoreBookingDeatails]
                                .isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      'Current booking',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                        snapshot.data!
                                            .data()![FirebaseFirestoreConst
                                                .firebaseFireStoreBookingDeatails]
                                            .length, (index) {
                                      return CommonWidget().historyContainer(
                                          roomBookingModel:
                                              RoomBookingModel.fromMap(snapshot
                                                          .data!
                                                          .data()![
                                                      FirebaseFirestoreConst
                                                          .firebaseFireStoreBookingDeatails]
                                                  [index]),
                                          context: context);
                                    }),
                                  ),
                                ],
                              )
                            : const SizedBox()
                        : const SizedBox(),
                  ],
                );
              } else {
                return Text('no data');
              }
            } else {
              return Text('no data');
            }
          }),
    ));
  }
}

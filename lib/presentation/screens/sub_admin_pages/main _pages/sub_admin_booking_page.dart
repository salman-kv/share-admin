import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/booking_page_bloc/booking_page_bloc.dart';
import 'package:share_sub_admin/application/booking_page_bloc/booking_page_event.dart';
import 'package:share_sub_admin/application/booking_page_bloc/booking_page_state.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';

class SubAdminBookinPage extends StatelessWidget {
  const SubAdminBookinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingPageBloc(),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                FirebaseFirestoreConst.firebaseFireStoreSubAdminCollection)
            .doc(BlocProvider.of<SubAdminLoginBloc>(context).userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> listHotelId = snapshot
                .data![FirebaseFirestoreConst.firebaseFireStoreHotelCollection];
            return listHotelId.isEmpty
                ? const Text('no hotelid list')
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseFirestoreConst
                            .firebaseFireStoreRoomCollection)
                        .where(FirebaseFirestoreConst.firebaseFireStoreHotelId,
                            whereIn: listHotelId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          List<Map<String, dynamic>> val =
                              snapshot.data!.docs.map((e) => e.data()).toList();
                          List<dynamic> roomIdList =
                              snapshot.data!.docs.map((e) => e.id).toList();
                          BlocProvider.of<BookingPageBloc>(context)
                              .add(OnShufleRoomBooking(listOfRooms: val));

                          return BlocBuilder<BookingPageBloc, BookingPageState>(
                              builder: (context, state) {
                            if (state is BookingShufleSuccessState) {
                              return ListView(
                                children: [
                                  const Text('checkout pending'),
                                  Column(
                                    children: List.generate(roomIdList.length,
                                        (index) {
                                      return StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection(FirebaseFirestoreConst
                                                  .firebaseFireStoreRoomCollection)
                                              .doc(roomIdList[index])
                                              .collection(FirebaseFirestoreConst
                                                  .firebaseFireStoreCurrentUserCheckInRoom)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              if (snapshot
                                                  .data!.docs.isNotEmpty) {
                                                if (snapshot.data!.docs[0]
                                                                .data()[
                                                            FirebaseFirestoreConst
                                                                .firebaseFireStoreCheckInORcheckOutDeatails]
                                                        [FirebaseFirestoreConst
                                                            .firebaseFireStoreCheckInORcheckOutRequest] ==
                                                    FirebaseFirestoreConst
                                                        .firebaseFireStoreCheckInORcheckOutRequestForCheckOutWaiting) {
                                                  return CommonWidget()
                                                      .pendingVerificationRoomContainer(
                                                          roomBookingModel:
                                                              RoomBookingModel
                                                                  .fromMap(snapshot
                                                                      .data!
                                                                      .docs[0]
                                                                      .data()),
                                                          context: context);
                                                } else {
                                                  return Text(
                                                      'this room is not goinh to checkout');
                                                }
                                              } else {
                                                return Text('no data');
                                              }
                                            } else {
                                              return Text('no data');
                                            }
                                          });
                                    }),
                                  ),
                                  const Text('verification pending'),
                                  Column(
                                    children: List.generate(
                                        BlocProvider.of<BookingPageBloc>(
                                                context)
                                            .verificationPendingRooms
                                            .length, (index) {
                                      return CommonWidget()
                                          .pendingVerificationRoomContainer(
                                              roomBookingModel: BlocProvider
                                                          .of<BookingPageBloc>(
                                                              context)
                                                      .verificationPendingRooms[
                                                  index],
                                              context: context);
                                    }),
                                  ),
                                  Text('payment pending'),
                                  Column(
                                    children: List.generate(
                                        BlocProvider.of<BookingPageBloc>(
                                                context)
                                            .paymentPendingRooms
                                            .length, (index) {
                                      return CommonWidget()
                                          .paymentPendingRoomContainer(
                                              roomBookingModel: BlocProvider.of<
                                                      BookingPageBloc>(context)
                                                  .paymentPendingRooms[index],
                                              context: context);
                                    }),
                                  ),
                                  Text('booked rooms'),
                                  Column(
                                    children: List.generate(
                                        BlocProvider.of<BookingPageBloc>(
                                                context)
                                            .bookedRooms
                                            .length, (index) {
                                      return CommonWidget().bookedRoomContainer(
                                          roomBookingModel:
                                              BlocProvider.of<BookingPageBloc>(
                                                      context)
                                                  .bookedRooms[index],
                                          context: context);
                                    }),
                                  )
                                ],
                              );
                            } else {
                              return Text('no data');
                            }
                          });
                        }
                      }
                      return Text('teturn');
                    },
                  );
          } else {
            return Text('sdf');
          }
        },
      ),
    );
  }
}

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
            if (snapshot.data!.data()!.containsKey("hotel")) {
              List<dynamic> listHotelId = snapshot.data![
                  FirebaseFirestoreConst.firebaseFireStoreHotelCollection];
              return listHotelId.isEmpty
                  ? const Text('no hotelid list')
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreRoomCollection)
                          .where(
                              FirebaseFirestoreConst.firebaseFireStoreHotelId,
                              whereIn: listHotelId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            List<Map<String, dynamic>> val = snapshot.data!.docs
                                .map((e) => e.data())
                                .toList();
                            List<dynamic> roomIdList =
                                snapshot.data!.docs.map((e) => e.id).toList();
                            BlocProvider.of<BookingPageBloc>(context).add(
                                OnShufleRoomBooking(
                                    listOfRooms: val,
                                    listOfRoomId: roomIdList));

                            return BlocBuilder<BookingPageBloc,
                                BookingPageState>(builder: (_, state) {
                              return BlocProvider.of<BookingPageBloc>(context)
                                          .checkOutVerificationPendingRooms
                                          .isEmpty &&
                                      BlocProvider.of<BookingPageBloc>(context)
                                          .paymentPendingRooms
                                          .isEmpty &&
                                      BlocProvider.of<BookingPageBloc>(context)
                                          .bookedRooms
                                          .isEmpty &&
                                      BlocProvider.of<BookingPageBloc>(context)
                                          .verificationPendingRooms
                                          .isEmpty
                                  ? CommonWidget().noDataWidget(
                                      text: 'No Booking related data found',
                                      context: context)
                                  : ListView(
                                      children: [
                                        BlocProvider.of<BookingPageBloc>(
                                                    context)
                                                .checkOutVerificationPendingRooms
                                                .isEmpty
                                            ? const SizedBox()
                                            : CommonWidget().bookingTitleText(
                                                text: 'Check Out Pending',
                                                context: context),
                                        Column(
                                          children: List.generate(
                                              BlocProvider.of<BookingPageBloc>(
                                                      context)
                                                  .checkOutVerificationPendingRooms
                                                  .length, (index) {
                                            return CommonWidget()
                                                .pendingVerificationRoomContainer(
                                                    roomBookingModel: BlocProvider
                                                            .of<BookingPageBloc>(
                                                                context)
                                                        .checkOutVerificationPendingRooms[index],
                                                    context: context);
                                          }),
                                        ),
                                        BlocProvider.of<BookingPageBloc>(
                                                    context)
                                                .verificationPendingRooms
                                                .isEmpty
                                            ? const SizedBox()
                                            : CommonWidget().bookingTitleText(
                                                text: 'Check In Pending',
                                                context: context),
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
                                                        .verificationPendingRooms[index],
                                                    context: context);
                                          }),
                                        ),
                                        BlocProvider.of<BookingPageBloc>(
                                                    context)
                                                .paymentPendingRooms
                                                .isEmpty
                                            ? const SizedBox()
                                            : CommonWidget().bookingTitleText(
                                                text: 'Payment Pending',
                                                context: context),
                                        Column(
                                          children: List.generate(
                                              BlocProvider.of<BookingPageBloc>(
                                                      context)
                                                  .paymentPendingRooms
                                                  .length, (index) {
                                            return CommonWidget()
                                                .paymentPendingRoomContainer(
                                                    roomBookingModel: BlocProvider
                                                            .of<BookingPageBloc>(
                                                                context)
                                                        .paymentPendingRooms[index],
                                                    context: context);
                                          }),
                                        ),
                                        BlocProvider.of<BookingPageBloc>(
                                                    context)
                                                .bookedRooms
                                                .isEmpty
                                            ? const SizedBox()
                                            : CommonWidget().bookingTitleText(
                                                text: 'Booked Rooms',
                                                context: context),
                                        Column(
                                          children: List.generate(
                                              BlocProvider.of<BookingPageBloc>(
                                                      context)
                                                  .bookedRooms
                                                  .length, (index) {
                                            return CommonWidget()
                                                .bookedRoomContainer(
                                                    roomBookingModel: BlocProvider
                                                            .of<BookingPageBloc>(
                                                                context)
                                                        .bookedRooms[index],
                                                    context: context);
                                          }),
                                        )
                                      ],
                                    );
                            });
                          }
                        }
                        return CommonWidget().noDataWidget(
                            text: 'No bookings ', context: context);
                      },
                    );
            } else {
              return CommonWidget()
                  .noDataWidget(text: 'No bookings ', context: context);
            }
          } else {
            return const Text('no nmo no');
          }
        },
      ),
    );
  }
}

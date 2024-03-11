import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_event.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_adding_page.dart';
import 'package:share_sub_admin/presentation/widgets/common_widget.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class RoomShowingPage extends StatelessWidget {
  final String hotelId;
  final MainPropertyModel propertyModel;
  const RoomShowingPage(
      {required this.propertyModel, required this.hotelId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomPropertyBloc(),
      child: BlocConsumer<RoomPropertyBloc, RoomPropertyState>(
        listener: (context, state) {},
        builder: (context, state) {
          BlocProvider.of<RoomPropertyBloc>(context).hotelId = hotelId;
          BlocProvider.of<RoomPropertyBloc>(context).propertyModel =
              propertyModel;
          return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Your Rooms',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    centerTitle: true,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseFirestoreConst
                                  .firebaseFireStoreHotelCollection)
                              .doc(hotelId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            log('${snapshot.data}');
                            if (snapshot.hasData) {
                              Map<String, dynamic> hotelDeatails =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return hotelDeatails[FirebaseFirestoreConst
                                              .firebaseFireStoreRooms] ==
                                          null ||
                                      hotelDeatails[FirebaseFirestoreConst
                                              .firebaseFireStoreRooms].isEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset('assets/images/room.json'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'No Room found',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(color: Colors.grey),
                                        )
                                      ],
                                    )
                                  : ListView(
                                      children: List.generate(
                                          hotelDeatails[FirebaseFirestoreConst
                                                  .firebaseFireStoreRooms]
                                              .length, (index) {
                                        return StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection(FirebaseFirestoreConst
                                                  .firebaseFireStoreRoomCollection)
                                              .doc(hotelDeatails[
                                                      FirebaseFirestoreConst
                                                          .firebaseFireStoreRooms]
                                                  [index])
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              Map<String, dynamic>
                                                  roomDeatails =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>;
                                              return CommonWidget()
                                                  .roomShowingOnPropertyContainer(
                                                      context,
                                                      roomDeatails,
                                                      hotelDeatails[
                                                              FirebaseFirestoreConst
                                                                  .firebaseFireStoreRooms]
                                                          [index]);
                                            }
                                            return const CircularProgressIndicator();
                                          },
                                        );
                                      }),
                                    );
                            } else {
                              return const Text('No data');
                            }
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.width * 0.1,
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                        ),
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            style:
                                Styles().elevatedButtonBorderOnlyStyle(context),
                            onPressed: () {
                              BlocProvider.of<RoomPropertyBloc>(context)
                                  .add(CleanExistingDataFromRommBlocEvent());
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return BlocProvider.value(
                                    value: BlocProvider.of<RoomPropertyBloc>(
                                        context),
                                    child: RoomAddingPage());
                              }));
                            },
                            child: Text(
                              'Add Rooms',
                              style: Styles()
                                  .elevatedButtonBorderOnlyTextStyle(context),
                            )),
                      ),
                    ],
                  )));
        },
      ),
    );
  }
}

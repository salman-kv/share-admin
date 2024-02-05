import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_state.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/domain/streams/room_showing_stream.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_adding_page.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';
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
                  appBar: AppBar(),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Your Rooms',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
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
                                            .firebaseFireStoreRooms]!=null? ListView(
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
                                                .firebaseFireStoreRooms][index])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map<String, dynamic> roomDeatails =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;
                                        return CommonWidget()
                                            .roomShowingOnPropertyContainer(
                                                context, roomDeatails);
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  );
                                }),
                              ) : const SizedBox();
                            } else {
                              return const Text('No data');
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return BlocProvider.value(
                                  value: BlocProvider.of<RoomPropertyBloc>(
                                      context),
                                  child: RoomAddingPage());
                            }));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 60,
                            width: 60,
                            decoration: Styles().customNextButtonDecoration(),
                            child: Styles().roundedAddButtonChild(),
                          ),
                        ),
                      ),
                    ],
                  )));
        },
      ),
    );
  }
}

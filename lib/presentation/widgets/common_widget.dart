import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_bloc.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/domain/model/room_booking_model.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';
import 'package:share_sub_admin/domain/model/user_model.dart';
import 'package:share_sub_admin/presentation/alerts/alert.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/hotel_property/property_adding_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_edit_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/single_room_showing_page.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class CommonWidget {
// room status details showing on subadmins home

  roomStatusShowingContainer(
      {required BuildContext context,
      required String hotelId,
      required Map<String, dynamic> hotelDeatails}) {
    MainPropertyModel propertyModel =
        MainPropertyModel.fromMap(hotelDeatails, hotelId);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ConstColors().mainColorpurple.withOpacity(0.3)),
      constraints: const BoxConstraints(minHeight: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(propertyModel.image[0]),
                    fit: BoxFit.fill)),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    propertyModel.propertyNmae,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.location_on, size: 18),
                  Text(
                    propertyModel.place,
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                  const Icon(
                    Icons.home_work_rounded,
                    size: 18,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Text(
                    propertyModel.hotelType == HotelType.dormitory
                        ? 'Dormitory'
                        : 'Hotel',
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.bed, size: 18),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Text(
                    '${propertyModel.rooms.length} Rooms',
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              )),
          Text('current enroled room'),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
                  .doc(hotelId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.data()!.containsKey(
                      FirebaseFirestoreConst.firebaseFireStoreRooms)) {
                    List<dynamic> list = snapshot
                        .data![FirebaseFirestoreConst.firebaseFireStoreRooms];
                    return Column(
                      children: [
                        Column(
                          children: List.generate(list.length, (index) {
                            return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(FirebaseFirestoreConst
                                      .firebaseFireStoreRoomCollection)
                                  .doc(list[index])
                                  .collection(FirebaseFirestoreConst
                                      .firebaseFireStoreCurrentUserCheckInRoom)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.docs.isNotEmpty) {
                                    log('${snapshot.data!.docs[0].data()}');
                                    // return Text('data');
                                    return CommonWidget()
                                        .roomShowinginHomepageHotelContainer(
                                      context: context,
                                      roomDeatails: RoomBookingModel.fromMap(
                                          snapshot.data!.docs[0].data()),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else {
                                  return Text('no rooms');
                                }
                              },
                            );
                          }),
                        ),
                        Column(
                          children: [
                            Text('all booked rooms'),
                            Column(
                              children: List.generate(list.length, (index) {
                                return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection(FirebaseFirestoreConst
                                          .firebaseFireStoreRoomCollection)
                                      .doc(list[index])
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.exists) {
                                        if (snapshot.data!.data()!.containsKey(
                                            FirebaseFirestoreConst
                                                .firebaseFireStoreBookingDeatails)) {
                                          if (snapshot.data!
                                              .data()![FirebaseFirestoreConst
                                                  .firebaseFireStoreBookingDeatails]
                                              .isNotEmpty) {
                                            return CommonWidget()
                                                .roomShowinginHomepageHotelContainer(
                                              context: context,
                                              roomDeatails: RoomBookingModel
                                                  .fromMap(snapshot.data!
                                                              .data()![
                                                          FirebaseFirestoreConst
                                                              .firebaseFireStoreBookingDeatails]
                                                      [0]),
                                            );
                                          } else {
                                            return Text('empty booking');
                                          }
                                        } else {
                                          return Text(
                                              'this room have no booking');
                                        }
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      return Text('no rooms');
                                    }
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Text('no rooms yet');
                  }
                } else {
                  return Text('no data');
                }
              }),
        ],
      ),
    );
  }

  // sub admin hotel only container

  hotelShowingContainer(
      BuildContext context, MainPropertyModel propertyModel, String hotelId) {
    List<dynamic> tempImages = [];
    tempImages.addAll(propertyModel.image);
    log('hotel showing pimnem rebuild aaayi');
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return RoomShowingPage(hotelId: hotelId, propertyModel: propertyModel);
      })),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ConstColors().mainColorpurple.withOpacity(0.3),
            ),
            constraints: const BoxConstraints(minHeight: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(propertyModel.image[0]),
                          fit: BoxFit.fill)),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          propertyModel.propertyNmae,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, size: 18),
                        Text(
                          propertyModel.place,
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ],
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.home_work_rounded,
                          size: 18,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          propertyModel.hotelType == HotelType.dormitory
                              ? 'Dormitory'
                              : 'Hotel',
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ],
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.bed, size: 18),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          '${propertyModel.rooms.length} Rooms',
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    iconSize: 30,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            onTap: () async {
                              propertyModel.image.clear();
                              propertyModel.image.addAll(tempImages);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return PropertyAddingPage(
                                  hotelId: hotelId,
                                  propertyModel: propertyModel,
                                );
                              }));
                            },
                            child: Text(
                              'Edit',
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                        PopupMenuItem(
                            onTap: () {
                              Alerts().dialgForDelete(
                                  context: context,
                                  type: 'hotelDelete',
                                  hotelId: hotelId,
                                  propertyModel: propertyModel);
                            },
                            child: Text(
                              'Delete',
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                      ];
                    },
                  )))
        ],
      ),
    );
  }

  // // room details container inside hotel container

  roomShowingOnPropertyContainer(
      BuildContext context, Map<String, dynamic> data, String roomId) {
    RoomModel roomModel = RoomModel.fromMap(data);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return BlocProvider.value(
            value: BlocProvider.of<RoomPropertyBloc>(context),
            child: SingleRoomShowingPage(
              roomId: roomId,
              roomModel: roomModel,
            ),
          );
        }));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ConstColors().mainColorpurple.withOpacity(0.4),
              ConstColors().main2Colorpur.withOpacity(0.2),
            ]),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: NetworkImage(roomModel.images[0]),
                        fit: BoxFit.fill)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomModel.roomNumber,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '₹ ${roomModel.price}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Availability : ${roomModel.availability}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: Styles().editElevatedButtonStyle(),
                            onPressed: () {
                              BlocProvider.of<RoomPropertyBloc>(context)
                                  .features = roomModel.features;
                              BlocProvider.of<RoomPropertyBloc>(context)
                                  .numberOfBed = roomModel.numberOfBed;
                              BlocProvider.of<RoomPropertyBloc>(context)
                                  .roomNumber = roomModel.roomNumber;
                              BlocProvider.of<RoomPropertyBloc>(context).price =
                                  roomModel.price;
                              BlocProvider.of<RoomPropertyBloc>(context)
                                  .editImage = roomModel.images;
                              BlocProvider.of<RoomPropertyBloc>(context)
                                  .staticEditRoomNumber = roomModel.roomNumber;

                              // BlocProvider.of<RoomPropertyBloc>(context).image=roomModel.images as List<XFile>;
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return BlocProvider.value(
                                    value: BlocProvider.of<RoomPropertyBloc>(
                                        context),
                                    child: RoomEditPage(
                                      roomId: roomId,
                                    ));
                              }));
                            },
                            child: Text(
                              'Edit',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.black),
                            )),
                        ElevatedButton(
                            style: Styles().deleteElevatedButtonStyle(),
                            onPressed: () async {
                              Alerts().dialgForDelete(
                                  context: context,
                                  hotelId:
                                      BlocProvider.of<RoomPropertyBloc>(context)
                                          .hotelId!,
                                  roomId: roomId,
                                  type: 'roomDelete',
                                  roomModel: roomModel);
                            },
                            child: Text(
                              'Delete',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.white),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // user showing rounder condainer

  roomShowinginHomepageHotelContainer(
      {required BuildContext context, required RoomBookingModel roomDeatails}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Colors.black),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                    image: NetworkImage(roomDeatails.image),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                roomDeatails.roomNumber,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }

// user deatails showing container

  userShowingContainer(
      {required BuildContext context, required UserModel userModel}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Colors.black),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                  image: NetworkImage(userModel.imagePath), fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                userModel.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }

  // drawer

  drawerReturnFunction(BuildContext context) {
    return Drawer(
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? const Color.fromARGB(150, 255, 255, 255)
              : const Color.fromARGB(150, 0, 0, 0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.width * 0.45,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(150),
              ),
              image: DecorationImage(
                  image: NetworkImage(
                      BlocProvider.of<SubAdminLoginBloc>(context)
                          .subAdminModel!
                          .imagePath),
                  fit: BoxFit.cover),
            ),
          ),
          Text(
            BlocProvider.of<SubAdminLoginBloc>(context).subAdminModel!.name,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_2_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'Profile',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.security_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'Privacy policy',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.privacy_tip_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'Terms & Condition',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Alerts().dialgForDelete(context: context, type: 'logOut');
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout_outlined,
                          size: 30,
                          color: Color.fromARGB(255, 214, 6, 6),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          'Log Out',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  pendingVerificationRoomContainer(
      {required RoomBookingModel roomBookingModel,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ConstColors().mainColorpurple.withOpacity(0.4),
              ConstColors().main2Colorpur.withOpacity(0.2),
            ]),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
              .doc(roomBookingModel.roomId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: NetworkImage(roomBookingModel.image),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.data()![FirebaseFirestoreConst
                                    .firebaseFireStoreHotelName],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                snapshot.data!
                                    .data()![FirebaseFirestoreConst
                                        .firebaseFireStoreRoomNumber]
                                    .toString(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                '₹ ${roomBookingModel.price}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${SubAdminFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['start']!)}  1:00 PM',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'To',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    '${SubAdminFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['end']!)}  11:30 AM',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  roomBookingModel
                                              .checkInCheckOutModel?.request ==
                                          FirebaseFirestoreConst
                                              .firebaseFireStoreCheckInORcheckOutRequestForCheckOutWaiting
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          decoration: Styles()
                                              .elevatedButtonDecoration(),
                                          child: ElevatedButton(
                                              style: Styles()
                                                  .elevatedButtonStyle(),
                                              onPressed: () {
                                                SubAdminFunction()
                                                    .roomCheckOutButonClicked(
                                                        roomBookingModel:
                                                            roomBookingModel);
                                              },
                                              child: Text(
                                                'Accept CheckOut',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              )),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          decoration: Styles()
                                              .elevatedButtonDecoration(),
                                          child: ElevatedButton(
                                              style: Styles()
                                                  .elevatedButtonStyle(),
                                              onPressed: () {
                                                SubAdminFunction()
                                                    .roomAcceptButtonClick(
                                                        roomBookingModel:
                                                            roomBookingModel);
                                              },
                                              child: Text(
                                                'Accept CheckIn',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                              )),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseFirestoreConst
                            .firebaseFireStoreUserCollection)
                        .doc(roomBookingModel.userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      log('pending building');
                      if (snapshot.hasData) {
                        if (snapshot.data!.exists) {
                          return CommonWidget().userShowingContainer(
                              context: context,
                              userModel: UserModel.fromMap(
                                  snapshot.data!.data()!,
                                  roomBookingModel.userId));
                        } else {
                          return Text('no data');
                        }
                      } else {
                        return Text('no data');
                      }
                    },
                  )
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  paymentPendingRoomContainer(
      {required RoomBookingModel roomBookingModel,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ConstColors().mainColorpurple.withOpacity(0.4),
              ConstColors().main2Colorpur.withOpacity(0.2),
            ]),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
              .doc(roomBookingModel.roomId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: NetworkImage(roomBookingModel.image),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.data()![FirebaseFirestoreConst
                                    .firebaseFireStoreHotelName],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                snapshot.data!
                                    .data()![FirebaseFirestoreConst
                                        .firebaseFireStoreRoomNumber]
                                    .toString(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                '₹ ${roomBookingModel.price}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${SubAdminFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['start']!)}  1:00 PM',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'To',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    '${SubAdminFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['end']!)}  11:30 AM',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: Styles().editElevatedButtonStyle(),
                          onPressed: () {},
                          child: Text(
                            'Pay with Cash',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                          )),
                      ElevatedButton(
                          style: Styles().deleteElevatedButtonStyle(),
                          onPressed: () async {
                            SubAdminFunction().roomBookingCancel(
                                roomBookingModel: roomBookingModel);
                          },
                          child: Text(
                            'Cancel Booking',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.white),
                          )),
                    ],
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseFirestoreConst
                            .firebaseFireStoreUserCollection)
                        .doc(roomBookingModel.userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      log('building pending paymetn');
                      if (snapshot.hasData) {
                        if (snapshot.data!.exists) {
                          return CommonWidget().userShowingContainer(
                              context: context,
                              userModel: UserModel.fromMap(
                                  snapshot.data!.data()!,
                                  roomBookingModel.userId));
                        } else {
                          return Text('no data');
                        }
                      } else {
                        return Text('no data');
                      }
                    },
                  )
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  bookedRoomContainer(
      {required RoomBookingModel roomBookingModel,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ConstColors().mainColorpurple.withOpacity(0.4),
              ConstColors().main2Colorpur.withOpacity(0.2),
            ]),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
              .doc(roomBookingModel.roomId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: NetworkImage(roomBookingModel.image),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.data()![FirebaseFirestoreConst
                                      .firebaseFireStoreHotelName],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  snapshot.data!
                                      .data()![FirebaseFirestoreConst
                                          .firebaseFireStoreRoomNumber]
                                      .toString(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  '₹ ${roomBookingModel.price}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${SubAdminFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['start']!)}  1:00 PM',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                      'To',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                      '${SubAdminFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['end']!)}  11:30 AM',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                                DateTime.now().isAfter(roomBookingModel
                                            .bookedDate['start']!
                                            .add(const Duration(hours: 1))) &&
                                        DateTime.now().isBefore(roomBookingModel
                                            .bookedDate['end']!
                                            .add(const Duration(hours: 11)))
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        decoration:
                                            Styles().elevatedButtonDecoration(),
                                        child: Center(
                                            child: Text(
                                          'Check In Today',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.white),
                                        )))
                                    : Text(
                                        '( CheckIn on ${SubAdminFunction().dateTimeToDateOnly(dateTime: roomBookingModel.bookedDate['start']!)} )',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 123, 123, 123)),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseFirestoreConst
                              .firebaseFireStoreUserCollection)
                          .doc(roomBookingModel.userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        log('biuliding booked');
                        if (snapshot.hasData) {
                          if (snapshot.data!.exists) {
                            return CommonWidget().userShowingContainer(
                                context: context,
                                userModel: UserModel.fromMap(
                                    snapshot.data!.data()!,
                                    roomBookingModel.userId));
                          } else {
                            return Text('no data');
                          }
                        } else {
                          return Text('no data');
                        }
                      },
                    )
                  ],
                );
              } else {
                return Text('no data');
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

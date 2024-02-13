import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_event.dart';
import 'package:share_sub_admin/application/sub_admin_login_bloc/sub_admin_login_bloc.dart';
import 'package:share_sub_admin/domain/const/firebasefirestore_constvalue.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';
import 'package:share_sub_admin/domain/functions/shared_prefrence.dart';
import 'package:share_sub_admin/domain/functions/sub_admin_function.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';
import 'package:share_sub_admin/presentation/alerts/alert.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_login/sub_admin_login_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/hotel_property/property_adding_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_adding_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_edit_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_page.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/single_room_showing_page.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class CommonWidget {
// room status details showing on subadmins home

  roomStatusShowingContainer(BuildContext context) {
    return Container(
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
                image: const DecorationImage(
                    image: AssetImage('assets/images/room.jpg'),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Room NO : 12',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Alocated user',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          userShowingComntainer(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 12),
            child: Text(
              'Checkin : 10-03-2020 10:30 Am',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }

  // sub admin hotel only container

  hotelShowingContainer(
      BuildContext context, MainPropertyModel propertyModel, String hotelId) {
        List<dynamic> tempImages=[];
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
                            onTap: () async{
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
            // color: ConstColors().mainColorpurple.withOpacity(0.2),
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
                              if (roomModel.features.contains('AC')) {
                                BlocProvider.of<RoomPropertyBloc>(context).ac =
                                    true;
                              }
                              if (roomModel.features.contains('Wifi')) {
                                BlocProvider.of<RoomPropertyBloc>(context)
                                    .wifi = true;
                              }

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

  userShowingComntainer(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Colors.black),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(4),
            child: Image.asset('assets/images/profile.png'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'User name',
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

  // checked box

  checkedBoxForRoomAdding(BuildContext context, String data) {
    var blocVal;
    if (data == 'AC') {
      blocVal = BlocProvider.of<RoomPropertyBloc>(context).ac;
    } else {
      blocVal = BlocProvider.of<RoomPropertyBloc>(context).wifi;
    }
    return Checkbox(
      value: blocVal,
      onChanged: (value) {
        if (value == true) {
          BlocProvider.of<RoomPropertyBloc>(context)
              .add(OnFeatureAddingEvent(text: data));
          blocVal = true;
        } else {
          BlocProvider.of<RoomPropertyBloc>(context)
              .add(OnFeatureDeletedEvent(text: data));
          blocVal = false;
        }
      },
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
}

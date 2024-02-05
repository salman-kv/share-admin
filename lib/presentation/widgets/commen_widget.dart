import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_page.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class CommonWidget {
  toastWidget(String toastMessage) {
    return Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  errorSnackBar(String errorSnackBarMessage, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(
          errorSnackBarMessage,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

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
                color: ConstColors().mainColorpurple.withOpacity(0.3)),
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          propertyModel.propertyNmae,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: DropdownButton(items: [
                    //       DropdownMenuItem(
                    //         child: Text('haai'),
                    //       ),
                    //       DropdownMenuItem(child: Text('asdf'),)
                    //     ], onChanged: (value) {
                          
                    //     },))
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
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded,size: 30,),),
            ))
        ],
      ),
    );
  }

  // // room details container inside hotel container

  roomShowingOnPropertyContainer(
      BuildContext context, Map<String, dynamic> data) {
    RoomModel roomModel = RoomModel.fromMap(data);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ConstColors().mainColorpurple.withOpacity(0.3),
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
                          onPressed: () {},
                          child: Text(
                            'Edit',
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      ElevatedButton(
                          style: Styles().deleteElevatedButtonStyle(),
                          onPressed: () {},
                          child: Text(
                            'Delete',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
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
}

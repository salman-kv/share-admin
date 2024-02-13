import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_bloc.dart';
import 'package:share_sub_admin/domain/model/room_model.dart';
import 'package:share_sub_admin/presentation/alerts/alert.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/room_pages/room_edit_page.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class SingleRoomShowingPage extends StatelessWidget {
  final String roomId;
  final RoomModel roomModel;
  const SingleRoomShowingPage(
      {required this.roomId, required this.roomModel, super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> imageWidget = [];
    for (var element in roomModel.images) {
      imageWidget.add(Image.network('$element'));
    }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: ConstColors().mainColorpurple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
            child:
                CarouselSlider(items: imageWidget, options: CarouselOptions()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(roomModel.roomNumber,style: Theme.of(context).textTheme.titleLarge,),
                Text('Hotel Name : ${roomModel.hotelName}',style: Theme.of(context).textTheme.titleSmall),
                Text('Availability : ${roomModel.availability.toString()}',style: Theme.of(context).textTheme.titleSmall),
                Text('Number of bed : ${roomModel.numberOfBed.toString()}',style: Theme.of(context).textTheme.titleSmall),
                Text('Features',style: Theme.of(context).textTheme.titleSmall),
                Column(
                  children: List.generate(roomModel.features.length, (index) {
                    return Text(roomModel.features[index]);
                  }),
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
                              // if (roomModel.features.contains('AC')) {
                              //   BlocProvider.of<RoomPropertyBloc>(context).ac =
                              //       true;
                              // }
                              // if (roomModel.features.contains('Wifi')) {
                              //   BlocProvider.of<RoomPropertyBloc>(context).wifi =
                              //       true;
                              // }
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
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black),
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
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),
                            )),
                      ],
                    )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

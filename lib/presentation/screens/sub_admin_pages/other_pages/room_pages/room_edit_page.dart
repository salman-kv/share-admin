import 'dart:async';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:share_sub_admin/application/room_property_bloc/room_property_bloc.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_event.dart';
import 'package:share_sub_admin/application/room_property_bloc/room_property_state.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';
import 'package:share_sub_admin/presentation/alerts/snack_bars.dart';
import 'package:share_sub_admin/presentation/cosnt/const_colors.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';

class RoomEditPage extends StatelessWidget {
  final String roomId;
  RoomEditPage({required this.roomId, super.key});

  final formKey = GlobalKey<FormState>();
  final roomIdKey = GlobalKey<FormFieldState>();
  final pricedKey = GlobalKey<FormFieldState>();
  final bedKey = GlobalKey<FormFieldState>();

  final roomIdController = TextEditingController();
  final priceController = TextEditingController();
  final bedNumberController = TextEditingController();
  final featuresController = TextEditingController();
  final Set<String> commenFeatures = {
    'AC',
    'Wifi',
    'TV',
    'Attached Bathroom',
    'Commen Bathroom',
    'Swimming pool',
    'Parking',
    'Balcony'
  };

  Timer? _debouncer;

  @override
  Widget build(BuildContext context) {
    roomIdController.text =
        BlocProvider.of<RoomPropertyBloc>(context).roomNumber!;
    priceController.text =
        BlocProvider.of<RoomPropertyBloc>(context).price!.toString();
    bedNumberController.text =
        BlocProvider.of<RoomPropertyBloc>(context).numberOfBed.toString();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: BlocConsumer<RoomPropertyBloc, RoomPropertyState>(
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Edit Room details",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: TextFormField(
                          key: roomIdKey,
                          validator: (value) {
                            if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!)) ||
                                BlocProvider.of<RoomPropertyBloc>(context)
                                        .roomNumber ==
                                    null) {
                              return 'enter valid Room Number';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            if (_debouncer != null) {
                              _debouncer!.cancel();
                            }
                            _debouncer = Timer(
                                const Duration(milliseconds: 500), () async {
                              BlocProvider.of<RoomPropertyBloc>(context).add(
                                  EditingRoomNumberTypingEvent(
                                      roomNumber: value,
                                      hotelId:
                                          BlocProvider.of<RoomPropertyBloc>(
                                                  context)
                                              .hotelId!,
                                      staticRoomId:
                                          BlocProvider.of<RoomPropertyBloc>(
                                                  context)
                                              .staticEditRoomNumber!));
                            });
                            // roomIdKey.currentState!.validate();
                          },
                          controller: roomIdController,
                          decoration: Styles().formDecorationStyleWithSufix(
                              sufix: state is RoomNumberTypingState
                                  ? const CircularProgressIndicator()
                                  : state is RoomNumberFailedState
                                      ? const Icon(Icons.cancel)
                                      : roomIdController.text.isEmpty
                                          ? const SizedBox()
                                          : const Icon(Icons.done),
                              icon: const Icon(Icons.roofing_rounded),
                              labelText: 'Room Number'),
                          style: Styles().formTextStyle(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          key: pricedKey,
                          validator: (value) {
                            if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
                              return 'enter valid price';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            pricedKey.currentState!.validate();
                          },
                          controller: priceController,
                          decoration: Styles().formDecorationStyle(
                              icon: const Icon(Icons.attach_money_rounded),
                              labelText: 'Price'),
                          style: Styles().formTextStyle(context),
                        ),
                      ),
                    ),
                    context.read<RoomPropertyBloc>().propertyModel!.hotelType ==
                            HotelType.hotel
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 300,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color.fromARGB(
                                        255, 242, 242, 242),
                                  ),
                                ),
                                value:
                                    BlocProvider.of<RoomPropertyBloc>(context)
                                        .numberOfBed,
                                onChanged: (value) {
                                  BlocProvider.of<RoomPropertyBloc>(context)
                                      .add(OnBedSelectEvent(
                                          numberOfBed: value!));
                                },
                                hint: const Row(
                                  children: [
                                    Icon(Icons.bed),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Bed'),
                                  ],
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('Single Bed'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('double bed'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                key: bedKey,
                                validator: (value) {
                                  if ((!RegExp(r'^\S+(?!\d+$)')
                                      .hasMatch(value!))) {
                                    return 'enter valid bed';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  BlocProvider.of<RoomPropertyBloc>(context)
                                      .add(OnBedSelectEvent(
                                          numberOfBed: int.parse(
                                              bedNumberController.text)));
                                  bedKey.currentState!.validate();
                                },
                                controller: bedNumberController,
                                decoration: Styles().formDecorationStyle(
                                    icon: const Icon(Icons.bed),
                                    labelText: 'Number Of Bed'),
                                style: Styles().formTextStyle(context),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Features',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                    ),
                    Wrap(
                      children: List.generate(commenFeatures.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SizedBox(
                            width: 150,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: context
                                      .read<RoomPropertyBloc>()
                                      .features
                                      .contains(
                                          commenFeatures.elementAt(index)),
                                  onChanged: (value) {
                                    BlocProvider.of<RoomPropertyBloc>(context)
                                        .add(FeatureAddingByCheckedBoxEvent(
                                            text: commenFeatures.elementAt(index)));
                                  },
                                ),
                                Expanded(
                                    child: Text(
                                  commenFeatures.elementAt(index),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ))
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextFormField(
                                // readOnly:featuresController true,
                                controller: featuresController,
                                decoration: Styles().formDecorationStyle(
                                    icon: const Icon(
                                        Icons.featured_video_rounded),
                                    labelText: 'Features'),
                                style: Styles().formTextStyle(context),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              if (featuresController.text.isNotEmpty) {
                                BlocProvider.of<RoomPropertyBloc>(context).add(
                                    OnFeatureAddingEvent(
                                        text: featuresController.text));
                                featuresController.text = '';
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 60,
                              width: 60,
                              decoration: Styles().customNextButtonDecoration(),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocProvider.of<RoomPropertyBloc>(context).features.isEmpty
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(minHeight: 100),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ConstColors()
                                    .mainColorpurple
                                    .withOpacity(0.3)),
                            child: Wrap(
                              children: List.generate(
                                  BlocProvider.of<RoomPropertyBloc>(context)
                                      .features
                                      .length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ChoiceChip(
                                    showCheckmark: false,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    color:
                                        const MaterialStatePropertyAll<Color>(
                                            Color.fromARGB(0, 255, 193, 7)),
                                    label: TextButton.icon(
                                        onPressed: () {
                                          BlocProvider.of<RoomPropertyBloc>(
                                                  context)
                                              .add(OnFeatureDeletedEvent(
                                            text: BlocProvider.of<
                                                    RoomPropertyBloc>(context)
                                                .features[index],
                                          ));
                                        },
                                        icon: const Icon(Icons.cancel),
                                        label: Text(
                                          BlocProvider.of<RoomPropertyBloc>(
                                                  context)
                                              .features[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    selected: true,
                                  ),
                                );
                              }),
                            ),
                          ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            context.watch<RoomPropertyBloc>().editImage.isEmpty
                                ? 1
                                : context
                                    .read<RoomPropertyBloc>()
                                    .editImage
                                    .length, (index) {
                          return Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: Styles()
                                    .imageContainerDecrationWithOutImage(),
                                child: context
                                        .watch<RoomPropertyBloc>()
                                        .editImage
                                        .isEmpty
                                    ? Center(
                                        child: Text(
                                          'pls add some editImage of this property',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      )
                                    : Image.network(context
                                        .watch<RoomPropertyBloc>()
                                        .editImage[index]),
                              ),
                              state is ImageLoadingState ||
                                      context
                                          .read<RoomPropertyBloc>()
                                          .editImage
                                          .isEmpty
                                  ? const SizedBox()
                                  : Positioned(
                                      right: 15,
                                      top: 15,
                                      child: InkWell(
                                        onTap: () {
                                          BlocProvider.of<RoomPropertyBloc>(
                                                  context)
                                              .add(OnDeleteEditImageEvent(
                                                  image: context
                                                      .read<RoomPropertyBloc>()
                                                      .editImage[index]));
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color:
                                                  ConstColors().mainColorpurple,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: const Icon(
                                            Icons.cancel_rounded,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        }),
                      ),
                    ),
                    Container(
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
                                .add(OnClickEditToAddMultipleImageEvent());
                          },
                          child: Text(
                            'Add Image',
                            style: Styles()
                                .elevatedButtonBorderOnlyTextStyle(context),
                          )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: Styles().elevatedButtonDecoration(),
                      child: ElevatedButton(
                          style: Styles().elevatedButtonStyle(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (BlocProvider.of<RoomPropertyBloc>(context)
                                      .numberOfBed ==
                                  null) {
                                SnackBars().errorSnackBar(
                                    'Pleas enter valid Deatailes about bed',
                                    context);
                                return;
                              } else if (BlocProvider.of<RoomPropertyBloc>(
                                      context)
                                  .features
                                  .isEmpty) {
                                SnackBars().errorSnackBar(
                                    'Pleas enter atleast one feature about this room',
                                    context);
                                return;
                              } else if (BlocProvider.of<RoomPropertyBloc>(
                                      context)
                                  .editImage
                                  .isEmpty) {
                                SnackBars().errorSnackBar(
                                    'Pleas enter atleast one image o this room',
                                    context);
                                return;
                              }

                              BlocProvider.of<RoomPropertyBloc>(context).add(
                                OnAddEditedRoomDeatailsEvent(
                                  roomId: roomId,
                                  roomNumber: roomIdController.text,
                                  price: int.parse(priceController.text),
                                ),
                              );
                            } else {
                              SnackBars().errorSnackBar(
                                  'Please fill all fielda', context);
                            }
                          },
                          child: state is RoomDeatailsSubmittingLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Submit',
                                  style:
                                      Styles().elevatedButtonTextStyle(context),
                                )),
                    ),
                  ],
                ),
              );
            },
            listener: (context, state) {
              if (state is RoomNumberFailedState ||
                  state is RoomNumberSuccessState) {
                roomIdKey.currentState!.validate();
              } else if (state is RoomDeatailsSubmittedState) {
                Navigator.of(context).pop();
              } else if (state is ImageLoadingState) {
                SnackBars().notifyingSnackBar('Image is loading', context);
              } else if (state is MultipleImageAddedState) {
                SnackBars()
                    .successSnackBar('Image added successfully', context);
              }
            },
          ),
        ),
      ),
    );
  }
}

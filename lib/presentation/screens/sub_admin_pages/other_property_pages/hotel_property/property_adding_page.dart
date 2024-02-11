
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:share_sub_admin/application/main_property_bloc/main_property_bloc.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_event.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_state.dart';
import 'package:share_sub_admin/domain/enum/hotel_type.dart';
import 'package:share_sub_admin/domain/model/main_property_model.dart';
import 'package:share_sub_admin/presentation/alerts/snack_bars.dart';
import 'package:share_sub_admin/presentation/screens/sub_admin_pages/other_property_pages/location/location_picking_page.dart';
import 'package:share_sub_admin/presentation/widgets/commen_widget.dart';
import 'package:share_sub_admin/presentation/widgets/styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PropertyAddingPage extends StatelessWidget {
  MainPropertyModel? propertyModel;
  String? hotelId;
  PropertyAddingPage(
      {MainPropertyModel? this.propertyModel, String? this.hotelId});

  var formKey = GlobalKey<FormState>();
  var nameKey = GlobalKey<FormFieldState>();
  var placeKey = GlobalKey<FormFieldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController placController = TextEditingController();
  TextEditingController mapLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => MainPropertyBloc(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: BlocConsumer<MainPropertyBloc, MainPropertyState>(
                builder: (context, state) {
                  if (propertyModel != null &&
                      state is MainPropertyInitialState) {
                    BlocProvider.of<MainPropertyBloc>(context).hotelId =
                        hotelId;
                    BlocProvider.of<MainPropertyBloc>(context).editing = true;
                    nameController.text = propertyModel!.propertyNmae;
                    placController.text = propertyModel!.place;
                    BlocProvider.of<MainPropertyBloc>(context).hotelType =
                        propertyModel!.hotelType;
                    BlocProvider.of<MainPropertyBloc>(context).latLng =
                        propertyModel!.latLng;
                    BlocProvider.of<MainPropertyBloc>(context).image =
                        propertyModel!.image;
                    BlocProvider.of<MainPropertyBloc>(context).marker.add(
                          Marker(
                            markerId: const MarkerId('current position'),
                            position: LatLng(propertyModel!.latLng.latitude,
                                propertyModel!.latLng.longitude),
                          ),
                        );
                  }
                  mapLocationController.text =
                      context.watch<MainPropertyBloc>().latLng == null
                          ? ''
                          : 'Location selected';
                  return Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Let's Add details",
                              style: Theme.of(context).textTheme.bodyLarge,
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
                              key: nameKey,
                              validator: (value) {
                                if ((!RegExp(r'^\S+(?!\d+$)')
                                    .hasMatch(value!))) {
                                  return 'enter valid name';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                nameKey.currentState!.validate();
                              },
                              controller: nameController,
                              decoration: Styles().formDecorationStyle(
                                  icon: const Icon(Icons.roofing_rounded),
                                  labelText: 'Property Name'),
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
                              key: placeKey,
                              validator: (value) {
                                if ((!RegExp(r'^\S+(?!\d+$)')
                                    .hasMatch(value!))) {
                                  return 'enter valid place';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                placeKey.currentState!.validate();
                              },
                              controller: placController,
                              decoration: Styles().formDecorationStyle(
                                  icon: const Icon(Icons.location_on_rounded),
                                  labelText: 'place'),
                              style: Styles().formTextStyle(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 300,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              buttonStyleData: ButtonStyleData(
                                height: 55,
                                width: MediaQuery.of(context).size.width * 0.92,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                ),
                              ),
                              onChanged: (value) {
                                BlocProvider.of<MainPropertyBloc>(context)
                                    .add(OnCatogorySelect(hotelType: value!));
                              },
                              value:
                                  context.watch<MainPropertyBloc>().hotelType,
                              hint: const Row(
                                children: [
                                  Icon(Icons.male_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Catogory'),
                                ],
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: HotelType.hotel,
                                  child: Text('Hotel'),
                                ),
                                DropdownMenuItem(
                                  value: HotelType.dormitory,
                                  child: Text('Dormitory'),
                                ),
                              ],
                            ),
                          ),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: mapLocationController,
                                    decoration: Styles().formDecorationStyle(
                                        icon: const Icon(Icons.map_outlined),
                                        labelText: 'Location'),
                                    style: Styles().formTextStyle(context),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return BlocProvider.value(
                                      value: BlocProvider.of<MainPropertyBloc>(
                                          context),
                                      child: LocationPicking());
                                }));
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 60,
                                  width: 60,
                                  decoration:
                                      Styles().customNextButtonDecoration(),
                                  child: const Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                context.watch<MainPropertyBloc>().image.isEmpty
                                    ? 1
                                    : context
                                        .read<MainPropertyBloc>()
                                        .image
                                        .length, (index) {
                              return Container(
                                margin: const EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: Styles().imageContainerDecration(),
                                child:state is ImageAddingState? lottie.Lottie.asset('assets/images/imageLoading.json') : context
                                        .watch<MainPropertyBloc>()
                                        .image
                                        .isEmpty
                                    ? Center(
                                        child: Text(
                                          'pls add some image of this property',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      )
                                    : Image.network(context
                                        .watch<MainPropertyBloc>()
                                        .image[index]),
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
                              style: Styles().elevatedButtonBorderOnlyStyle(context),
                              onPressed: () {
                                BlocProvider.of<MainPropertyBloc>(context)
                                    .add(OnClickToAddMultipleImage());
                              },
                              child: Text(
                                'Add Image',
                                style: Styles()
                                    .elevatedButtonBorderOnlyTextStyle(context),
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: Styles().elevatedButtonDecoration(),
                          child: ElevatedButton(
                              style: Styles().elevatedButtonStyle(),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (context
                                          .read<MainPropertyBloc>()
                                          .hotelType ==
                                      null) {
                                    SnackBars().errorSnackBar(
                                        'select catogory', context);
                                    return;
                                  } else if (context
                                          .read<MainPropertyBloc>()
                                          .latLng ==
                                      null) {
                                    SnackBars().errorSnackBar(
                                        'select location from map', context);
                                    return;
                                  } else if (context
                                      .read<MainPropertyBloc>()
                                      .image
                                      .isEmpty) {
                                    SnackBars()
                                        .errorSnackBar('select image', context);
                                    return;
                                  } else if (formKey.currentState!.validate()) {
                                    BlocProvider.of<MainPropertyBloc>(context)
                                        .add(
                                      OnSubmittingDeatailsEvent(
                                          name: nameController.text,
                                          place: placController.text),
                                    );
                                  } else {
                                    SnackBars().errorSnackBar(
                                        'pleas fill all fields', context);
                                  }
                                } else {
                                  SnackBars().errorSnackBar(
                                      'pleas fill all fields', context);
                                }
                              },
                              child: state is MainPropertyLoadingState
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Submit',
                                      style: Styles()
                                          .elevatedButtonTextStyle(context),
                                    )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is MainPropertyUpdatedState) {
                    SnackBars().successSnackBar('Property Added Successfully', context);
                    Navigator.of(context).pop();
                  } else if (state is ImageAddingState) {
                    SnackBars().notifyingSnackBar('image is loading', context);
                  } else if (state is ImageAddedState) {
                    SnackBars().successSnackBar('image added', context);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

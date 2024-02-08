import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_bloc.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_event.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_state.dart';

class LocationPicking extends StatelessWidget {
  var initialCameraPosition =
      const CameraPosition(target: LatLng(12.44, 20.445), zoom: 14);
  GoogleMapController? _controller;
  

  LocationPicking({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPropertyBloc, MainPropertyState>(
      builder: (context, state) {
        log('${context.watch<MainPropertyBloc>().latLng}');
        LatLng? position = context.watch<MainPropertyBloc>().latLng;
        if (position != null && _controller != null) {
          log('2 oke');
          BlocProvider.of<MainPropertyBloc>(context).marker.clear();
          BlocProvider.of<MainPropertyBloc>(context).marker.add(
                Marker(
                  markerId: const MarkerId('current position'),
                  position: LatLng(position.latitude, position.longitude),
                ),
              );
          _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (argument) {
                    BlocProvider.of<MainPropertyBloc>(context)
                        .add(OnClickOtherLocationEvent(latLng: argument));
                  },
                  initialCameraPosition:
                      BlocProvider.of<MainPropertyBloc>(context).latLng != null
                          ? CameraPosition(
                              target: LatLng(
                                  context
                                      .watch<MainPropertyBloc>()
                                      .latLng!
                                      .latitude,
                                  context
                                      .watch<MainPropertyBloc>()
                                      .latLng!
                                      .longitude))
                          : initialCameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    log('on map create');
                    _controller = controller;
                    if (position != null) {
                      _controller!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14),
                        ),
                      );
                      BlocProvider.of<MainPropertyBloc>(context).marker.clear();
                      BlocProvider.of<MainPropertyBloc>(context).marker.add(
                            Marker(
                              markerId: const MarkerId('current position'),
                              position:
                                  LatLng(position.latitude, position.longitude),
                            ),
                          );
                    }
                  },
                  markers: context.watch<MainPropertyBloc>().marker,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<MainPropertyBloc>(context)
                          .add(OnCurrentLocationClickEvent());
                    },
                    child:
                        state is MainPropertyCurrentLocationPickingLoadingState
                            ? const CircularProgressIndicator()
                            : const Text('Current Location'),
                  ),
                  ElevatedButton(
                      autofocus: false,
                      onPressed: state is MainPropertyCurrentLocationPickedState
                          ? () {
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: const Text('Submit'))
                ],
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is MainPropertylocationFixedState) {
          Navigator.of(context).pop();
        }
        // } else if (state is MainPropertyCurrentLocationPickedState) {
        //   LatLng? position = context.watch<MainPropertyBloc>().latLng;
        //   if (position != null) {
        //     _controller.animateCamera(
        //       CameraUpdate.newCameraPosition(
        //         CameraPosition(
        //             target: LatLng(position.latitude, position.longitude),
        //             zoom: 14),
        //       ),
        //     );
        //   }
        // }
      },
    );
  }
}

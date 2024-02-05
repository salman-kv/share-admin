import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_bloc.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_event.dart';
import 'package:share_sub_admin/application/main_property_bloc/main_property_state.dart';

class LocationPicking extends StatelessWidget {
  var initialCameraPosition =CameraPosition(target: LatLng(12.44, 20.445),zoom: 14);
  late GoogleMapController _controller;
  Set<Marker> marker = {};

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MainPropertyBloc>(context).add(OnCurrentLocationClickEvent());
    return BlocConsumer<MainPropertyBloc, MainPropertyState>(
      builder: (context, state) {
        LatLng? position = context.watch<MainPropertyBloc>().latLng;
        if (position != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14),
            ),
          );
          marker.clear();
          marker.add(
            Marker(
              markerId: const MarkerId('current position'),
              position: LatLng(position.latitude, position.longitude),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body:  Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (argument) {
                    BlocProvider.of<MainPropertyBloc>(context).add(OnClickOtherLocationEvent(latLng: argument));
                  },
                  initialCameraPosition: initialCameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    _controller = controller;
                  },
                  markers: marker,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<MainPropertyBloc>(context).add(OnCurrentLocationClickEvent());
                    },
                    child: state is MainPropertyCurrentLocationPickingLoadingState ? const CircularProgressIndicator() : const Text('Current Location'),
                  ),
                    ElevatedButton(
                    autofocus: false,
                    onPressed:state is MainPropertyCurrentLocationPickedState? (){ 
                      Navigator.of(context).pop();  
                    }:  null, child: const Text('Submit'))
                ],
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if(state is MainPropertylocationFixedState){
          Navigator.of(context).pop();
        }
      },
    );
  }


}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TakeFromMap extends StatefulWidget {
  TakeFromMap({super.key});

  static const CameraPosition initialCamaraPosition =
      CameraPosition(target: LatLng(50.9994, -124444), zoom: 10);

  @override
  State<TakeFromMap> createState() => _TakeFromMapState();
}

class _TakeFromMapState extends State<TakeFromMap> {
  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }
  late GoogleMapController _controller;
  Set<Marker> marker = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onTap: (argument) {
                getOtherPostition(argument);
                setState(() {
                });
              },

              initialCameraPosition: TakeFromMap.initialCamaraPosition,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                _controller = controller;
              },
              markers: marker,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Position position = await getCurrentPosition();
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
              marker.add(
                Marker(
                  markerId: MarkerId('second position'),
                  position: LatLng(position.latitude,-12.8678),
                ),
              );
              setState(() {
                
              });
            },
            child: Text('click position'),
          ),
        ],
      ),
    );
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service is disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied permenently');
    }
    var currentPostion = await Geolocator.getCurrentPosition();
    return currentPostion;
  }

  Future<void> getOtherPostition(LatLng latLng)async{
    marker.add(Marker(markerId: MarkerId('$latLng}'),position: latLng),);


  }
}

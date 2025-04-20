import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/map_bloc/map_bloc.dart';
import 'package:google_map/map_bloc/map_states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  StreamSubscription<Position>? positionStream;
  bool isPermissionGranted = false;
  LatLng? currentLocation;

  @override
  void initState() {
    
    super.initState();
    checkPremissionRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapBloc, MapStates>(
        builder: (context, state) {
          if (state is MapInitial || state is MapLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MapLoadedState) {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(31.214654548662452, 29.97939924196198),
                zoom: 10,
              ),
              style: state.mapStyle,
              onMapCreated: (GoogleMapController controller) {
                state.controller.complete(controller);
              },
            );
          }
          return SizedBox();
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     context.read<MapBloc>().add(ChangeMapLocation(newLocation:LatLng(30.60550944485475, 32.25804371066298) ));
      //   },
      // ),
    );
  }

  //--------------------------------------------- check primission ----------
  checkPremissionRequest() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        isPermissionGranted = true;
      });
    } else {
      //show dialog
    }
  }

  //--------------------------------------------- get user location  ----------

  getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }
}

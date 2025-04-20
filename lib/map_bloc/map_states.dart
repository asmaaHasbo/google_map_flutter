import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStates {}

class MapInitial extends MapStates {}

class MapLoadingState extends MapStates {}

class MapLoadedState extends MapStates {
  MapLoadedState({required this.controller, required this.mapStyle});

  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  String mapStyle;
}

class ChangeLoactionState extends MapStates {
  ChangeLoactionState();
}

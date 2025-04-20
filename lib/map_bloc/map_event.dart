import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEvent {}

class MapLoadEvent extends MapEvent {}

class ChangeMapLocation extends MapEvent {
  ChangeMapLocation({required this.newLocation});
  final LatLng newLocation;
}

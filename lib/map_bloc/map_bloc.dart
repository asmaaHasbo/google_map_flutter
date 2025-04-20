import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/map_bloc/map_event.dart';
import 'package:google_map/map_bloc/map_states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBloc extends Bloc<MapEvent, MapStates> {
  MapBloc() : super(MapInitial()) {
    on<MapLoadEvent>(onMapLoad);
    on<ChangeMapLocation>(onMapChangeLocation);
  }

  final mapController = Completer<GoogleMapController>();

  Future<void> onMapLoad(MapEvent event, Emitter<MapStates> emit) async {
    emit(MapLoadingState());
    try {
      final mapStyle = await rootBundle.loadString(
        "assets/custom_google_map_style.json",
      );

      emit(MapLoadedState(controller: mapController, mapStyle: mapStyle));
    } catch (e) {
      print(e.toString());
    }
  }

  Future onMapChangeLocation(
    ChangeMapLocation event,
    Emitter<MapStates> emit,
  ) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: event.newLocation, zoom: 14),
      ),
    );
  }
}

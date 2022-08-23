import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gtfs_db/gtfs_db.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart' as rt;
import 'package:latlong2/latlong.dart';

class VehiclePositionMarkersLayer {
  final List<rt.VehiclePosition> vehiclePositions;
  final List<Trip> trips;
  final List<TransitRoute> routes;

  late Map<String, Trip> tripLookup;
  late Map<String, TransitRoute> routeLookup;

  VehiclePositionMarkersLayer({
    required this.vehiclePositions,
    required this.trips,
    required this.routes,
  }) {
    tripLookup = Map.fromIterables(
      trips.map((t) => t.trip_id),
      trips,
    );
    routeLookup = Map.fromIterables(
      routes.map((t) => t.route_id),
      routes,
    );
  }

  MarkerLayerOptions buildLayer() {
    return MarkerLayerOptions(
      markers: [
        for (final vehiclePosition in vehiclePositions)
          Marker(
            point: LatLng(
              vehiclePosition.position.latitude,
              vehiclePosition.position.longitude,
            ),
            anchorPos: AnchorPos.align(AnchorAlign.center),
            width: 20,
            height: 20,
            builder: (context) {
              final trip = tripLookup[vehiclePosition.trip.tripId];
              final route = routeLookup[route.route_id];
              final routeNumber = trip?.route_id
              final routeColor = route.route_short_name ?? ''
              // TODO: Exercise 7


              return CircleAvatar(
                backgroundColor: routeColor,
                child: Text(routeNumber),
              );
            },
          ),
      ],
    );
  }
}

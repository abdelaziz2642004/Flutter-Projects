import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:store_app/Models/store.dart';

class DistanceService {
  Future<Position> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<double> getDistanceToStore(
    Store store, {
    String unit = "meters",
  }) async {
    final user = await getUserLocation();
    return FlutterMapMath().distanceBetween(
      user.latitude,
      user.longitude,
      store.latitude,
      store.longitude,
      unit,
    );
  }


  Future<String?> getAddressFromCoordinates(Store store) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        store.latitude,
        store.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return [
          if (place.street != null && place.street!.isNotEmpty) place.street,
          if (place.locality != null && place.locality!.isNotEmpty) place.locality,
          if (place.postalCode != null && place.postalCode!.isNotEmpty) place.postalCode,
          if (place.country != null && place.country!.isNotEmpty) place.country,
        ].join(', ');
      }
    } catch (_) {}
    return null;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_coupoun_admin/services/map_services/location_provider.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepo {
  Future<Position?> initPosition() async {
    final hasPermission = await _handlePermission();
    if (hasPermission is String) {
      return null;
    }
    if (hasPermission is bool && hasPermission == false) {
      return null;
    }
    Position? position = await LocationProvider().getLastLocation();
    if (position != null) {
      return position;
    } else {
      position = await LocationProvider().getCurrentLocation();
    }
    return position;
  }

  Future getCurrentLocation() async {
    final hasPermission = await _handlePermission();
    if (hasPermission is String) {
      return hasPermission;
    }
    if (!hasPermission) {
      return null;
    }
    return await LocationProvider().getLastLocation();
  }

  double calculateDistance(GeoPoint geoPoint1, GeoPoint geoPoint2) {
    return LocationProvider().calculateDistanceInKm(geoPoint1.latitude,
        geoPoint1.longitude, geoPoint2.latitude, geoPoint2.longitude);
  }

  double calculateDeliveryCharge(GeoPoint geoPoint1, GeoPoint geoPoint2) {
    double charge =
        10 + calculateDistance(geoPoint1, geoPoint2).roundToDouble();
    return charge;
  }

  Future<dynamic> _handlePermission() async {
    bool serviceEnabled = await LocationProvider().locationServiceStatus();
    if (!serviceEnabled) {
      return "Please enable your location";
    }

    LocationPermission permission = await LocationProvider().checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await LocationProvider().requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return "Please give access to location permission";
      } else {
        return true;
      }
    }

    return true;
  }
}

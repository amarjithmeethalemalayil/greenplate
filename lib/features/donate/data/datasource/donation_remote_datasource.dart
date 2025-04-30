import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/features/donate/data/model/location_model.dart';
import 'package:location/location.dart';

abstract interface class DonationRemoteDatasource {
  Future<LocationModel> getCurrentLocation();
}

class DonationRemoteDatasourceImpl implements DonationRemoteDatasource {
  final Location location;

  DonationRemoteDatasourceImpl(this.location);

  @override
  Future<LocationModel> getCurrentLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw const ServerException(
            'Location services are disabled',
          );
        }
      }
      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
      }
      switch (permission) {
        case PermissionStatus.denied:
          throw const ServerException(
            'Location permission denied',
          );
        case PermissionStatus.deniedForever:
          throw const ServerException(
            'Location permission permanently denied. Please enable it in app settings',
          );
        case PermissionStatus.granted:
        case PermissionStatus.grantedLimited:
          break;
      }
      final locationData = await location.getLocation();
      if (locationData.latitude == null || locationData.longitude == null) {
        throw const ServerException(
          'Invalid location data received',
        );
      }
      return LocationModel(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      throw ServerException(
        'Failed to get location: ${e.toString()}',
        stackTrace,
      );
    }
  }
}

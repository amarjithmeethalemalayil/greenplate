import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_plate/core/constants/keys/keys.dart';
import 'package:green_plate/core/error/app_exception.dart';
import 'package:green_plate/features/donate/data/model/donation_model.dart';
import 'package:green_plate/features/donate/data/model/location_model.dart';
import 'package:location/location.dart';

abstract interface class DonationRemoteDatasource {
  Future<LocationModel> getCurrentLocation();
  Future<bool> createDonation(DonationModel donation);
  Future<List<DonationModel>> getDonation(
    LocationModel location,
    String userId,
  );
  Future<String> fetchDonatorName(String uid);
}

class DonationRemoteDatasourceImpl implements DonationRemoteDatasource {
  final Location location;
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  DonationRemoteDatasourceImpl({
    required this.location,
    required this.auth,
    required this.db,
  });

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

  @override
  Future<bool> createDonation(DonationModel donation) async {
    try {
      final userId = donation.donatorId;
      final userDocId = userId == 'unknown' ? auth.currentUser?.uid : userId;
      if (userDocId == null || userDocId.isEmpty) {
        return false;
      }
      await db.collection(Keys.donationCollection).doc().set(donation.toMap());
      return true;
    } on FirebaseException catch (e) {
      throw ServerException('Failed to save recipe to Firestore: ${e.message}');
    } catch (e, st) {
      throw ServerException(
        'An error occurred while saving the recipe: ${e.toString()}',
        st,
      );
    }
  }

  @override
  Future<List<DonationModel>> getDonation(
    LocationModel userLocation,
    String userId,
  ) async {
    final collection = db.collection(Keys.donationCollection);
    final snapshot = await collection.get();
    final List<DonationModel> nearbyDonations = [];
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final donatorId = data['donatorId'];
      final lat = data['latitude'];
      final lng = data['longitude'];
      if (donatorId != userId) {
        final distance = _calculateDistance(
          userLocation.latitude,
          userLocation.longitude,
          lat,
          lng,
        );

        if (distance <= 5.0) {
          nearbyDonations.add(DonationModel.fromFirestore(doc));
        }
      }
    }

    return nearbyDonations;
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371;
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degToRad(double deg) => deg * (pi / 180);

  @override
  Future<String> fetchDonatorName(String uid) async {
    try {
      final userDocId = uid == 'unknown' ? auth.currentUser?.uid : uid;
      if (userDocId == null || userDocId.isEmpty) {
        return '';
      } else {
        final collection = db.collection(Keys.accountsCollection);
        final snapshot = await collection.doc(userDocId).get();
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>?;
          final userName = data?['name'] ?? '';
          return userName;
        } else {
          return '';
        }
      }
    } on FirebaseException catch (e) {
      throw ServerException(
          'Failed to fetch donator name from Firestore: ${e.message}');
    } catch (e, st) {
      throw ServerException(
        'An error occurred while fetching the donator name: ${e.toString()}',
        st,
      );
    }
  }
}

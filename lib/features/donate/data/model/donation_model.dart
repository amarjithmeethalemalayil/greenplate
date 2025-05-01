import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_plate/features/donate/domain/entity/donation_entity.dart';

class DonationModel extends DonationEntity {
  DonationModel({
    required super.donatorId,
    required super.donatorName,
    required super.mealType,
    required super.foodName,
    required super.pickupAddress,
    required super.contactNumber,
    required super.longitude,
    required super.latitude,
    required super.isSomeOneIntrested,
  });

  factory DonationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DonationModel(
      donatorId: data['donatorId'] ?? '',
      donatorName: data['donatorName'] ?? '',
      mealType: data['mealType'] ?? '',
      foodName: data['foodName'] ?? '',
      pickupAddress: data['pickupAddress'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      longitude: data['longitude']?.toDouble() ?? 0.0,
      latitude: data['latitude']?.toDouble() ?? 0.0,
      isSomeOneIntrested: data['isSomeOneIntrested'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'donatorId': donatorId,
      'donatorName': donatorName,
      'mealType': mealType,
      'foodName': foodName,
      'pickupAddress': pickupAddress,
      'contactNumber': contactNumber,
      'longitude': longitude,
      'latitude': latitude,
      'isSomeOneIntrested': isSomeOneIntrested,
    };
  }

  factory DonationModel.fromEntity(DonationEntity entity) {
    return DonationModel(
      donatorId: entity.donatorId,
      donatorName: entity.donatorName,
      mealType: entity.mealType,
      foodName: entity.foodName,
      pickupAddress: entity.pickupAddress,
      contactNumber: entity.contactNumber,
      longitude: entity.longitude,
      latitude: entity.latitude,
      isSomeOneIntrested: entity.isSomeOneIntrested,
    );
  }
}

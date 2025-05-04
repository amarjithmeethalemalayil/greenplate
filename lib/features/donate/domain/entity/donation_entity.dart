class DonationEntity {
  String? donationDocId;
  final String donatorId;
  final String donatorName;
  final String mealType;
  final String foodName;
  final String pickupAddress;
  final int contactNumber;
  final double longitude;
  final double latitude;
  final bool donationCompleted;

  DonationEntity({
    required this.donatorId,
    required this.donatorName,
    required this.mealType,
    required this.foodName,
    required this.pickupAddress,
    required this.contactNumber,
    required this.longitude,
    required this.latitude,
    required this.donationCompleted,
    this.donationDocId,
  });
}

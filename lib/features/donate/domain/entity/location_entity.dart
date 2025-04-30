class LocationEntity {
  final double latitude;
  final double longitude;

  const LocationEntity({required this.latitude, required this.longitude});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationEntity &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }
}
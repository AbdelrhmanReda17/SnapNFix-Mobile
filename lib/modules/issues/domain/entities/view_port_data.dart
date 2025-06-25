class ViewportData {
  final double centerLat;
  final double centerLng;
  final double radiusInKm;
  final int recommendedMaxResults;

  ViewportData({
    required this.centerLat,
    required this.centerLng,
    required this.radiusInKm,
    required this.recommendedMaxResults,
  });
}

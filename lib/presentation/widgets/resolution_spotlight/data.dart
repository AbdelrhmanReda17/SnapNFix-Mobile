// lib/features/home/domain/entities/heat_spot.dart
class HeatSpot {
  final String areaName;
  final int issueCount;
  final double intensity; // 0.0 to 1.0
  final String mostCommonIssue;

  const HeatSpot({
    required this.areaName,
    required this.issueCount,
    required this.intensity,
    required this.mostCommonIssue,
  });
}

// lib/features/home/domain/entities/resolution_story.dart
class ResolutionStory {
  final String id;
  final String title;
  final String beforeImageUrl;
  final String afterImageUrl;
  final String location;
  final DateTime reportedDate;
  final DateTime resolvedDate;
  final String issueType;

  const ResolutionStory({
    required this.id,
    required this.title,
    required this.beforeImageUrl,
    required this.afterImageUrl,
    required this.location,
    required this.reportedDate,
    required this.resolvedDate,
    required this.issueType,
  });

  String get resolutionTimeText {
    final duration = resolvedDate.difference(reportedDate);
    if (duration.inDays > 0) {
      return 'Resolved in ${duration.inDays} days';
    } else {
      return 'Resolved in ${duration.inHours} hours';
    }
  }
}


class StaticHomeData {
  static List<HeatSpot> getHeatSpots() {
    return [
      const HeatSpot(
        areaName: 'Downtown',
        issueCount: 23,
        intensity: 0.9,
        mostCommonIssue: 'Potholes',
      ),
      const HeatSpot(
        areaName: 'El Maadi',
        issueCount: 15,
        intensity: 0.6,
        mostCommonIssue: 'Garbage',
      ),
      const HeatSpot(
        areaName: 'Zamalek',
        issueCount: 8,
        intensity: 0.3,
        mostCommonIssue: 'Defective Manholes',
      ),
      const HeatSpot(
        areaName: 'Heliopolis',
        issueCount: 19,
        intensity: 0.75,
        mostCommonIssue: 'Potholes',
      ),
      const HeatSpot(
        areaName: 'New Cairo',
        issueCount: 5,
        intensity: 0.2,
        mostCommonIssue: 'Garbage',
      ),
    ];
  }

  static List<ResolutionStory> getResolutionStories() {
    return [
      ResolutionStory(
        id: '1',
        title: 'Major Pothole Fixed on Tahrir Square',
        beforeImageUrl: 'https://example.com/before1.jpg',
        afterImageUrl: 'https://example.com/after1.jpg',
        location: 'Tahrir Square, Downtown',
        reportedDate: DateTime.now().subtract(const Duration(days: 7)),
        resolvedDate: DateTime.now().subtract(const Duration(days: 2)),
        issueType: 'Pothole',
      ),
      ResolutionStory(
        id: '2',
        title: 'Garbage Collection Improved in Maadi',
        beforeImageUrl: 'https://example.com/before2.jpg',
        afterImageUrl: 'https://example.com/after2.jpg',
        location: 'Street 9, Maadi',
        reportedDate: DateTime.now().subtract(const Duration(days: 10)),
        resolvedDate: DateTime.now().subtract(const Duration(days: 1)),
        issueType: 'Garbage',
      ),
      ResolutionStory(
        id: '3',
        title: 'Broken Manhole Cover Replaced',
        beforeImageUrl: 'https://example.com/before3.jpg',
        afterImageUrl: 'https://example.com/after3.jpg',
        location: 'Korba, Heliopolis',
        reportedDate: DateTime.now().subtract(const Duration(days: 5)),
        resolvedDate: DateTime.now().subtract(const Duration(hours: 8)),
        issueType: 'Defective Manhole',
      ),
    ];
  }
}
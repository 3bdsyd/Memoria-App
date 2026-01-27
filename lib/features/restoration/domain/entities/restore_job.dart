import 'restore_metrics.dart';

class RestoreJob {
  final String id; // image_id from backend
  final DateTime createdAt;

  /// Local original image path (picked from device and copied into app folder)
  final String originalPath;

  /// Local enhanced image path (saved for offline), optional until downloaded
  final String? enhancedPath;

  /// Local compare image path (saved for offline), optional until downloaded
  final String? comparePath;

  final RestoreMetrics? metrics;

  const RestoreJob({
    required this.id,
    required this.createdAt,
    required this.originalPath,
    this.enhancedPath,
    this.comparePath,
    this.metrics,
  });

  RestoreJob copyWith({
    String? enhancedPath,
    String? comparePath,
    RestoreMetrics? metrics,
  }) {
    return RestoreJob(
      id: id,
      createdAt: createdAt,
      originalPath: originalPath,
      enhancedPath: enhancedPath ?? this.enhancedPath,
      comparePath: comparePath ?? this.comparePath,
      metrics: metrics ?? this.metrics,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'originalPath': originalPath,
        'enhancedPath': enhancedPath,
        'comparePath': comparePath,
        'metrics': metrics?.toJson(),
      };

  factory RestoreJob.fromMap(Map<String, dynamic> map) {
    return RestoreJob(
      id: (map['id'] ?? '').toString(),
      createdAt: DateTime.tryParse((map['createdAt'] ?? '').toString()) ?? DateTime.now(),
      originalPath: (map['originalPath'] ?? '').toString(),
      enhancedPath: map['enhancedPath']?.toString(),
      comparePath: map['comparePath']?.toString(),
      metrics: map['metrics'] == null
          ? null
          : RestoreMetrics.fromJson(Map<String, dynamic>.from(map['metrics'] as Map)),
    );
  }
}

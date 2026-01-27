import '../../domain/entities/restore_metrics.dart';

class UploadResponseModel {
  final bool success;
  final String message;
  final String imageId;
  final RestoreMetrics? metrics;

  UploadResponseModel({
    required this.success,
    required this.message,
    required this.imageId,
    required this.metrics,
  });

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadResponseModel(
      success: (json['success'] ?? false) as bool,
      message: (json['message'] ?? '').toString(),
      imageId: (json['image_id'] ?? '').toString(),
      metrics: json['metrics'] == null
          ? null
          : RestoreMetrics.fromJson(Map<String, dynamic>.from(json['metrics'] as Map)),
    );
  }
}

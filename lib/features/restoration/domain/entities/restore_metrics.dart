class RestoreMetrics {
  final String dimensions;
  final int channels;
  final String dpiEstimate;
  final num qualityScore;
  final num sharpnessScore;
  final num noiseLevel;
  final bool needsRestoration;
  final bool isBlackWhite;
  final num colorVariance;
  final num processingTime;
  final String finalDimensions;
  final num upscaleFactor;
  final bool colorized;
  final String methodUsed;
  final bool detailEnhancement;

  const RestoreMetrics({
    required this.dimensions,
    required this.channels,
    required this.dpiEstimate,
    required this.qualityScore,
    required this.sharpnessScore,
    required this.noiseLevel,
    required this.needsRestoration,
    required this.isBlackWhite,
    required this.colorVariance,
    required this.processingTime,
    required this.finalDimensions,
    required this.upscaleFactor,
    required this.colorized,
    required this.methodUsed,
    required this.detailEnhancement,
  });

  factory RestoreMetrics.fromJson(Map<String, dynamic> json) {
    return RestoreMetrics(
      dimensions: (json['dimensions'] ?? '').toString(),
      channels: (json['channels'] ?? 0) as int,
      dpiEstimate: (json['dpi_estimate'] ?? '').toString(),
      qualityScore: (json['quality_score'] ?? 0) as num,
      sharpnessScore: (json['sharpness_score'] ?? 0) as num,
      noiseLevel: (json['noise_level'] ?? 0) as num,
      needsRestoration: (json['needs_restoration'] ?? false) as bool,
      isBlackWhite: (json['is_black_white'] ?? false) as bool,
      colorVariance: (json['color_variance'] ?? 0) as num,
      processingTime: (json['processing_time'] ?? 0) as num,
      finalDimensions: (json['final_dimensions'] ?? '').toString(),
      upscaleFactor: (json['upscale_factor'] ?? 0) as num,
      colorized: (json['colorized'] ?? false) as bool,
      methodUsed: (json['method_used'] ?? '').toString(),
      detailEnhancement: (json['detail_enhancement'] ?? false) as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'dimensions': dimensions,
        'channels': channels,
        'dpi_estimate': dpiEstimate,
        'quality_score': qualityScore,
        'sharpness_score': sharpnessScore,
        'noise_level': noiseLevel,
        'needs_restoration': needsRestoration,
        'is_black_white': isBlackWhite,
        'color_variance': colorVariance,
        'processing_time': processingTime,
        'final_dimensions': finalDimensions,
        'upscale_factor': upscaleFactor,
        'colorized': colorized,
        'method_used': methodUsed,
        'detail_enhancement': detailEnhancement,
      };
}

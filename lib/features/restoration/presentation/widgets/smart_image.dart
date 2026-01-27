import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Use local file if exists; otherwise fall back to network with caching.
class SmartImage extends StatelessWidget {
  final String? localPath;
  final String? networkUrl;
  final BoxFit fit;
  final BorderRadius? radius;

  const SmartImage({
    super.key,
    required this.localPath,
    required this.networkUrl,
    this.fit = BoxFit.cover,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final r = radius ?? BorderRadius.circular(16);

    if (localPath != null && localPath!.isNotEmpty && File(localPath!).existsSync()) {
      return ClipRRect(
        borderRadius: r,
        child: Image.file(File(localPath!), fit: fit),
      );
    }

    if (networkUrl != null && networkUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: r,
        child: CachedNetworkImage(
          imageUrl: networkUrl!,
          fit: fit,
          httpHeaders: const {'Accept': 'image/*'},
          placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
          errorWidget: (_, __, ___) => const Center(child: Icon(Icons.broken_image_outlined)),
        ),
      );
    }

    return const Center(child: Icon(Icons.image_not_supported_outlined));
  }
}

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/restoration/domain/entities/restore_job.dart';

class HistoryStore {
  static const _boxName = 'restore_jobs';
  Box<Map>? _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<Map>(_boxName);
  }

  Future<List<RestoreJob>> getAll() async {
    final box = _box;
    if (box == null) return [];
    final items = box.values
        .map((m) => RestoreJob.fromMap(Map<String, dynamic>.from(m)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  Future<void> put(RestoreJob job) async {
    final box = _box;
    if (box == null) return;
    await box.put(job.id, job.toMap());
  }

  Future<void> delete(String id) async {
    final box = _box;
    if (box == null) return;
    await box.delete(id);
  }

  Future<String> saveBytesToFile({
    required List<int> bytes,
    required String fileName,
    required String folder,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final targetDir = Directory('${dir.path}/$folder');
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }
    final file = File('${targetDir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  Future<String> copyOriginalToAppFolder({
    required String sourcePath,
    required String folder,
  }) async {
    final bytes = await File(sourcePath).readAsBytes();
    final name = sourcePath.split(Platform.pathSeparator).last;
    return saveBytesToFile(bytes: bytes, fileName: name, folder: folder);
  }
}

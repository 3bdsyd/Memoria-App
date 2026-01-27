import 'dart:io';
import 'dart:typed_data';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveImageResult {
  const SaveImageResult({required this.success, required this.message});
  final bool success;
  final String message;
}

class AppFileStore {
  Future<SaveImageResult> saveBytesToGallery(Uint8List bytes, {required String fileName}) async {
    final granted = await _ensurePermission();
    if (!granted) return const SaveImageResult(success: false, message: 'تم رفض الصلاحية');

    try {
      // حفظ مؤقت ثم حفظ للمعرض
      final temp = await File('${Directory.systemTemp.path}/$fileName').writeAsBytes(bytes, flush: true);
      await Gal.putImage(temp.path);
      return const SaveImageResult(success: true, message: 'تم حفظ الصورة في المعرض ✅');
    } catch (_) {
      return const SaveImageResult(success: false, message: 'فشل حفظ الصورة');
    }
  }

  Future<SaveImageResult> saveFileToGallery(String filePath) async {
    final granted = await _ensurePermission();
    if (!granted) return const SaveImageResult(success: false, message: 'تم رفض الصلاحية');

    try {
      await Gal.putImage(filePath);
      return const SaveImageResult(success: true, message: 'تم حفظ الصورة في المعرض ✅');
    } catch (_) {
      return const SaveImageResult(success: false, message: 'فشل حفظ الصورة');
    }
  }

  Future<bool> _ensurePermission() async {
    if (Platform.isAndroid) {
      // Android 13+: READ_MEDIA_IMAGES
      final p = await Permission.photos.request();
      if (p.isGranted) return true;
      final s = await Permission.storage.request();
      return s.isGranted;
    }
    final p = await Permission.photosAddOnly.request();
    return p.isGranted;
  }
}

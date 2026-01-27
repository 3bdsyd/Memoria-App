import '../../domain/entities/restore_job.dart';
import '../../domain/repositories/restoration_repository.dart';
import '../../../../core/storage/history_store.dart';
import '../datasources/restoration_remote_data_source.dart';
import '../models/upload_response_model.dart';

class RestorationRepositoryImpl implements RestorationRepository {
  final RestorationRemoteDataSource remote;
  final HistoryStore historyStore;

  RestorationRepositoryImpl({required this.remote, required this.historyStore});

  @override
  Future<UploadResponseModel> upload(String filePath) {
    return remote.uploadImage(filePath: filePath);
  }

  @override
  Future<String> downloadEnhancedToFile(String imageId) async {
    final bytes = await remote.getEnhancedImageBytes(imageId: imageId);
    return historyStore.saveBytesToFile(
      bytes: bytes,
      fileName: 'enhanced_$imageId.jpg',
      folder: 'enhanced',
    );
  }

  @override
  Future<String> downloadCompareToFile(String imageId) async {
    final bytes = await remote.getCompareImageBytes(imageId: imageId);
    return historyStore.saveBytesToFile(
      bytes: bytes,
      fileName: 'compare_$imageId.jpg',
      folder: 'compare',
    );
  }

  @override
  Future<String> persistOriginal(String sourcePath) {
    return historyStore.copyOriginalToAppFolder(sourcePath: sourcePath, folder: 'originals');
  }

  @override
  Future<void> saveJob(RestoreJob job) => historyStore.put(job);

  @override
  Future<List<RestoreJob>> loadHistory() => historyStore.getAll();

  @override
  Future<void> deleteJob(String id) => historyStore.delete(id);
}

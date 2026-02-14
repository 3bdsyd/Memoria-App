import '../../data/models/upload_response_model.dart';
import '../entities/restore_job.dart';

abstract class RestorationRepository {
  Future<UploadResponseModel> upload(String filePath);

  Future<String> downloadEnhancedToFile(String imageId);
  Future<String> downloadCompareToFile(String imageId);
  Future<String> persistOriginal(String sourcePath);

  Future<void> saveJob(RestoreJob job);
  Future<List<RestoreJob>> loadHistory();
  Future<void> deleteJob(String id);
}

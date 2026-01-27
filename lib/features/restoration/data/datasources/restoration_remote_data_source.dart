import 'package:dio/dio.dart';
import '../../../../core/errors/app_error.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/upload_response_model.dart';

abstract class RestorationRemoteDataSource {
  Future<UploadResponseModel> uploadImage({required String filePath});
  Future<List<int>> getEnhancedImageBytes({required String imageId});
  Future<List<int>> getCompareImageBytes({required String imageId});
}

class RestorationRemoteDataSourceImpl implements RestorationRemoteDataSource {
  final Dio dio;
  RestorationRemoteDataSourceImpl({required this.dio});

  @override
  Future<UploadResponseModel> uploadImage({required String filePath}) async {
    try {
      final form = FormData.fromMap({'file': await MultipartFile.fromFile(filePath)});
      final res = await dio.post(
        ApiEndpoints.upload, // POST /upload :contentReference[oaicite:4]{index=4}
        data: form,
        options: Options(contentType: 'multipart/form-data'),
      );
      return UploadResponseModel.fromJson(Map<String, dynamic>.from(res.data as Map));
    } catch (e) {
      throw AppError('Upload failed', cause: e);
    }
  }

  @override
  Future<List<int>> getEnhancedImageBytes({required String imageId}) async {
    try {
      final res = await dio.get<List<int>>(
        ApiEndpoints.download(imageId), // GET /download/{id} :contentReference[oaicite:5]{index=5}
        options: Options(
          responseType: ResponseType.bytes,
          headers: const {'Accept': 'image/*'},
        ),
      );
      return res.data ?? <int>[];
    } catch (e) {
      throw AppError('Download enhanced image failed', cause: e);
    }
  }

  @override
  Future<List<int>> getCompareImageBytes({required String imageId}) async {
    try {
      final res = await dio.get<List<int>>(
        ApiEndpoints.compare(imageId), // GET /compare/{id} :contentReference[oaicite:6]{index=6}
        options: Options(
          responseType: ResponseType.bytes,
          headers: const {'Accept': 'image/*'},
        ),
      );
      return res.data ?? <int>[];
    } catch (e) {
      throw AppError('Download compare image failed', cause: e);
    }
  }
}

import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/errors/app_error.dart';
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
      final form = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final res = await dio.post(
        ApiEndpoints.upload,
        data: form,
        options: Options(
          headers: const {'Accept': 'application/json'},
          contentType: 'multipart/form-data',
        ),
      );

      if (res.data is Map<String, dynamic>) {
        return UploadResponseModel.fromJson(res.data as Map<String, dynamic>);
      }
      return UploadResponseModel.fromJson(Map<String, dynamic>.from(res.data));
    } catch (e) {
      throw AppError('Upload failed', cause: e);
    }
  }

  @override
  Future<List<int>> getEnhancedImageBytes({required String imageId}) async {
    try {
      final res = await dio.get<List<int>>(
        ApiEndpoints.download(imageId),
        options: Options(
          responseType: ResponseType.bytes,
          // backend returns image bytes directly
          headers: const {'Accept': 'image/*'},
        ),
      );
      return (res.data ?? <int>[]);
    } catch (e) {
      throw AppError('Download enhanced image failed', cause: e);
    }
  }

  @override
  Future<List<int>> getCompareImageBytes({required String imageId}) async {
    try {
      final res = await dio.get<List<int>>(
        ApiEndpoints.compare(imageId),
        options: Options(
          responseType: ResponseType.bytes,
          headers: const {'Accept': 'image/*'},
        ),
      );
      return (res.data ?? <int>[]);
    } catch (e) {
      throw AppError('Download compare image failed', cause: e);
    }
  }
}

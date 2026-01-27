import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../models/upload_response_model.dart';

class RestorationApi {
  RestorationApi(this._dio);
  final Dio _dio;

  Future<UploadResponseModel> uploadImage(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.uri.pathSegments.last),
    });

    final res = await _dio.post<Map<String, dynamic>>(
      '/upload',
      data: formData,
      options: Options(
        headers: const {'Accept': 'application/json'},
        contentType: 'multipart/form-data',
      ),
    );

    return UploadResponseModel.fromJson(res.data ?? {});
  }

  Future<Uint8List> getImageBytes(String path) async {
    final res = await _dio.get<List<int>>(
      path,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(res.data ?? []);
  }
}

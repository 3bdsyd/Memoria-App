class ApiEndpoints {
  static const baseUrl = 'https://image-restoration-backend-1.onrender.com';

  static const upload = '/upload';
  static String download(String id) => '/download/$id';
  static String compare(String id) => '/compare/$id';
}

class ApiEndpoints {
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  static const upload = '/upload';
  static String download(String id) => '/download/$id';
  static String compare(String id) => '/compare/$id';
}

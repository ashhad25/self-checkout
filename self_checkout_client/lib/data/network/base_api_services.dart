abstract class BaseApiServices {
  Future<dynamic> getApiService(String url, Map<String, String> headers);
  Future<dynamic> postApiService(
      dynamic data, String url, Map<String, String> headers);
}

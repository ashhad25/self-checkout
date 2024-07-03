import 'package:self_checkout_client/data/network/base_api_services.dart';
import 'package:self_checkout_client/data/network/network_api_services.dart';

class HistoryRepository {
  BaseApiServices networkApiServices = NetworkApiServices();
  Future<dynamic> getUserHistory(
      String url, Map<String, String> headers) async {
    try {
      dynamic response = await networkApiServices.getApiService(url, headers);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> addUserHistory(dynamic data, String url) async {
    print({"user history data": data});
    try {
      dynamic response =
          await networkApiServices.postApiService(data, url, requestHeaders);

      return response;
    } catch (e) {
      throw e;
    }
  }
}

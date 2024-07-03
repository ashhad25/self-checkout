import 'package:self_checkout_client/data/network/base_api_services.dart';
import 'package:self_checkout_client/data/network/network_api_services.dart';

class OrderRepository {
  BaseApiServices networkApiServices = NetworkApiServices();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future<dynamic> getStoreProducts(
      String url, Map<String, String> headers) async {
    try {
      dynamic response = await networkApiServices.getApiService(url, headers);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> placeOrder(dynamic data, String url) async {
    try {
      dynamic response =
          await networkApiServices.postApiService(data, url, requestHeaders);

      return response;
    } catch (e) {
      throw e;
    }
  }
}

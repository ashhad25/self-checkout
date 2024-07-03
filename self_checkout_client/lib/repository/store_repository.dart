import 'package:self_checkout_client/data/network/base_api_services.dart';
import 'package:self_checkout_client/data/network/network_api_services.dart';
import 'package:self_checkout_client/utils/constants.dart';

class StoreRepository {
  BaseApiServices networkApiServices = NetworkApiServices();
  Future<dynamic> getStoresApi(Map<String, String> headers) async {
    try {
      dynamic response = await networkApiServices.getApiService(
          Constants.stores_route_get_stores, headers);
      return response;
    } catch (e) {
      throw e;
    }
  }
}

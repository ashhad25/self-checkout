import 'package:self_checkout_client/data/network/base_api_services.dart';
import 'package:self_checkout_client/data/network/network_api_services.dart';
import 'package:self_checkout_client/utils/constants.dart';

class AuthRepository {
  BaseApiServices networkApiServices = NetworkApiServices();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await networkApiServices.postApiService(
          data, Constants.auth_route_login, requestHeaders);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = await networkApiServices.postApiService(
          data, Constants.auth_route_register, requestHeaders);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getUserApi(Map<String, String> headers) async {
    try {
      dynamic response = await networkApiServices.getApiService(
          Constants.auth_route_getUser, headers);
      return response;
    } catch (e) {
      throw e;
    }
  }
}

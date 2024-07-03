import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:self_checkout_client/data/app_exception.dart';
import 'package:self_checkout_client/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApiService(String url, Map<String, String> headers) async {
    dynamic response;
    try {
      http.Response res = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      response = requestResponse(res);
    } on SocketException {
      throw NoInternetException('Lost connection in get API');
    } catch (e) {
      InvalidRequestException(e.toString());
    }
    // print(response);
    return response;
  }

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future postApiService(
      dynamic data, String url, Map<String, String> headers) async {
    dynamic response;
    try {
      http.Response res = await http
          .post(Uri.parse(url), body: data, headers: headers)
          .timeout(const Duration(seconds: 15));
      response = requestResponse(res);
    } on SocketException {
      throw NoInternetException('No internet connection');
    } catch (e) {
      print(e);
      InvalidRequestException(e.toString());
    }
    if (kDebugMode) {
      print(response);
    }
    return response;
  }

  dynamic requestResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic res = jsonDecode(response.body);
        return res;
      case 404:
        throw InvalidRequestException('');
      default:
        throw FetchDataException('');
    }
  }
}

// ignore_for_file: constant_identifier_names, unnecessary_brace_in_string_interps

class Constants {
  static const String app_title = 'Self Checkout';

  static const String local_url = 'http://192.168.43.224';
  // static const String local_url = 'http://192.168.0.104';
  static const String app_backend_url = '${local_url}:8000/api/';
  static const String auth_route_getUser =
      '${app_backend_url}authRoute/getUser';
  static const String auth_route_login = '${app_backend_url}authRoute/login';
  static const String auth_route_register =
      '${app_backend_url}authRoute/register';
  static const String stores_route_get_stores =
      '${app_backend_url}storeRoute/getStores';
  static const String stores_route_get_history =
      '${app_backend_url}historyRoute/getHistory/';
  static const String stores_route_add_history =
      '${app_backend_url}historyRoute/addHistory';
}

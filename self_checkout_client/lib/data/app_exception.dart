class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, 'Error during communication');
}

class NoInternetException extends AppException {
  NoInternetException(String message) : super(message, 'No internet found');
}

class InvalidRequestException extends AppException {
  InvalidRequestException(String message) : super(message, 'Invalid request');
}

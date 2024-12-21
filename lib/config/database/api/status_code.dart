class StatusCode {
  // Success
  static const int ok = 200;

  // Client Errors
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int tooManyRequests = 429;
  static const int requestEntityTooLarge = 413;
  static const int parameterError = 422;
  // Server Errors
  static const int internalServerError = 500; 
  static const int gatewayTimeout = 504;
  static const int serviceUnavailable = 503;
  // Add any other necessary status codes as needed
}

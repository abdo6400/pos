import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return message;
  }
}

class DataFormatException extends ServerException {
  const DataFormatException(String errorMessage) : super(errorMessage);
}

class ParamterErrorException extends ServerException {
  final List<String> errors;

  ParamterErrorException(this.errors)
      : super(errors.map((e) => e).join(", "));
}

class FetchDataException extends ServerException {
  const FetchDataException(String errorMessage) : super(errorMessage);
}

class BadRequestException extends ServerException {
  const BadRequestException(String errorMessage) : super(errorMessage);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException(String errorMessage) : super(errorMessage);
}

class NotFoundException extends ServerException {
  const NotFoundException(String errorMessage) : super(errorMessage);
}

class ConflictException extends ServerException {
  const ConflictException(String errorMessage) : super(errorMessage);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException(String errorMessage) : super(errorMessage);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException(String errorMessage) : super(errorMessage);
}

class RequestCancelledException extends ServerException {
  const RequestCancelledException(String errorMessage) : super(errorMessage);
}

class UnknownException extends ServerException {
  const UnknownException(String errorMessage) : super(errorMessage);
}

class PayloadTooLargeException extends ServerException {
  const PayloadTooLargeException(String errorMessage) : super(errorMessage);
}

class TooManyRequestsException extends ServerException {
  const TooManyRequestsException(String errorMessage) : super(errorMessage);
}

class GatewayTimeoutException extends ServerException {
  const GatewayTimeoutException(String errorMessage) : super(errorMessage);
}

class UnprocessableEntityException extends ServerException {
  const UnprocessableEntityException(String errorMessage) : super(errorMessage);
}


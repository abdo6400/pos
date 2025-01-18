import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<Either<Failure, T>> handleNetworkRequest<T>({
    required Future<T> Function() remoteRequest,
    required Future<void> Function(List<Map<String, dynamic>>) cacheData,
    required Future<T> Function() localRequest,
  });

  Future<Either<Failure, T>> handleNetworkPendingRequest<T>({
    required Future<T> Function() remoteRequest,
    required Future<T> Function() localRequest,
  });
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    if (kIsWeb) {
      return true;
    }
    bool previousConnection = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        previousConnection = true;
      } else {
        previousConnection = false;
      }
    } on SocketException catch (_) {
      previousConnection = false;
    }
    return previousConnection;
  }

  Future<Either<Failure, T>> handleNetworkRequest<T>({
    required Future<T> Function() remoteRequest,
    required Future<void> Function(List<Map<String, dynamic>>) cacheData,
    required Future<T> Function() localRequest,
  }) async {
    try {
      if ((await isConnected)) {
        final response = await remoteRequest();
        final dataToCache = (response as List)
            .map((x) => x.toJson() as Map<String, dynamic>)
            .toList();
        await cacheData(dataToCache);
        return Right(response);
      }
      return Right(await localRequest());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, T>> handleNetworkPendingRequest<T>(
      {required Future<T> Function() remoteRequest,
      required Future<T> Function() localRequest}) async {
    try {
      if ((await isConnected)) return Right(await remoteRequest());
      return Right(await localRequest());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

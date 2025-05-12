import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../utils/enums/internet_status_enums.dart';

class InternetCubit extends HydratedCubit<InternetStatus> {
  final Connectivity connectivity = Connectivity();
  late StreamSubscription connectivityStreamSubscription;
  Timer? _timer;

  InternetCubit() : super(InternetStatus.unknown) {
    _init();
  }

  void _init() {
    // Initial check
    checkInternet();
    // Listen for connectivity changes
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((_) {
      checkInternet();
    });
    // Periodic check (every 10 seconds)
    _timer = Timer.periodic(Duration(seconds: 10), (_) => checkInternet());
  }

  Future<void> checkInternet() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        emit(InternetStatus.disconnected);
        return;
      }

      final bool isActuallyConnected = await isConnected;

      if (isActuallyConnected) {
        final connectionType = connectivityResult == ConnectivityResult.wifi
            ? InternetStatus.connectedWifi
            : InternetStatus.connectedMobile;
        emit(connectionType);
      } else {
        emit(InternetStatus.disconnected);
      }
    } catch (_) {
      emit(InternetStatus.disconnected);
    }
  }

  Future<bool> get isConnected async {
    if (kIsWeb) {
      return true; // Assume web always has internet (or implement a web-specific check)
    }
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    _timer?.cancel();
    return super.close();
  }
  
  @override
  InternetStatus? fromJson(Map<String, dynamic> json) {
    return InternetStatus.values[json['status'] as int];
  }
  
  @override
  Map<String, dynamic>? toJson(InternetStatus state) {
    return {'status': state.index};
  }
}

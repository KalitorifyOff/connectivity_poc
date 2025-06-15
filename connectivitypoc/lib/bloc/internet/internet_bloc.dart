import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivitypoc/bloc/internet/internet_event.dart';
import 'package:connectivitypoc/bloc/internet/internet_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  InternetBloc() : super(const InternetOffline()) {
    on<InternetObserveRequested>(_onObserveRequested);
    on<InternetConnectionChanged>(_onConnectionChanged);
  }

  Future<void> _onObserveRequested(
    InternetObserveRequested event,
    Emitter<InternetState> emit,
  ) async {
    try {
      final result = await _connectivity.checkConnectivity();
      _emitConnectionState(result, emit);

      _subscription = _connectivity.onConnectivityChanged.listen((result) {
        add(InternetConnectionChanged(result));
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  void _onConnectionChanged(
    InternetConnectionChanged event,
    Emitter<InternetState> emit,
  ) {
    _emitConnectionState(event.connectionResults, emit);
  }

  void _emitConnectionState(
    List<ConnectivityResult> results,
    Emitter<InternetState> emit,
  ) {
    // If any of the result is not 'none', we consider it online
    final isOnline = results.any((r) => r != ConnectivityResult.none);

    if (isOnline) {
      emit(InternetOnline(results));
    } else {
      emit(const InternetOffline());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

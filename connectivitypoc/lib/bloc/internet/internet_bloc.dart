import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  InternetBloc() : super(InternetState.initial()) {
    on<InternetObserveRequested>(_onObserveRequested);
    on<InternetConnectionChanged>(_onConnectionChanged);
  }

  Future<void> _onObserveRequested(
    InternetObserveRequested event,
    Emitter<InternetState> emit,
  ) async {
    try {
      final result = await _connectivity.checkConnectivity();
      emit(state.copyWith(connectionResults: result));

      _subscription = _connectivity.onConnectivityChanged.listen((result) {
        add(InternetConnectionChanged(result));
      });
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
    }
  }

  void _onConnectionChanged(
    InternetConnectionChanged event,
    Emitter<InternetState> emit,
  ) {
    emit(state.copyWith(connectionResults: event.connectionResults));
    print('Connectivity changed: ${event.connectionResults}');
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

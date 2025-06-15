part of 'internet_bloc.dart';

class InternetState {
  final List<ConnectivityResult> connectionResults;

  const InternetState({required this.connectionResults});

  factory InternetState.initial() =>
      const InternetState(connectionResults: [ConnectivityResult.none]);

  InternetState copyWith({
    List<ConnectivityResult>? connectionResults,
  }) {
    return InternetState(
      connectionResults: connectionResults ?? this.connectionResults,
    );
  }
}

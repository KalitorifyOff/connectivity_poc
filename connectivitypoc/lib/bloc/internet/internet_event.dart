part of 'internet_bloc.dart';


abstract class InternetEvent {}

class InternetObserveRequested extends InternetEvent {}

class InternetConnectionChanged extends InternetEvent {
  final List<ConnectivityResult> connectionResults;

  InternetConnectionChanged(this.connectionResults);
}

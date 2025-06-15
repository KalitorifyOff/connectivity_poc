import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetState {
  const InternetState();
}

class InternetOnline extends InternetState {
  final List<ConnectivityResult> connectionResults;

  const InternetOnline(this.connectionResults);
}

class InternetOffline extends InternetState {
  const InternetOffline();
}

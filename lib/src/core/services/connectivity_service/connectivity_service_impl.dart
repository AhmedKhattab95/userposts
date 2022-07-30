import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  ConnectivityServiceImpl();

  @override
  Future<ConnectedFrom> get connectedFrom async =>
      ConnectedFrom.fromConnectivityResult(await _connectivity.checkConnectivity());

  @override
  Future<bool> get hasInterentConnection async {
    var result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) return true;
    return false;
  }

  @override
  Stream<ConnectedFrom> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map((event) => ConnectedFrom.fromConnectivityResult(event));
}

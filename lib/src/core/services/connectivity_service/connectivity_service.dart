import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

/// class to detect if app has interent and cpnnected or not based on   connectivity: ^3.0.6
abstract class ConnectivityService {
  Future<bool> get hasInterentConnection;

  Future<ConnectedFrom> get connectedFrom;

  Stream<ConnectedFrom> get onConnectivityChanged;
}

class ConnectedFrom extends Equatable {
  final String _value;

  const ConnectedFrom._(this._value);

  static const ConnectedFrom wifi = ConnectedFrom._('wifi');
  static const ConnectedFrom phoneCell = ConnectedFrom._('PhoneCell');
  static const ConnectedFrom none = ConnectedFrom._('none');

  factory ConnectedFrom.fromString(String value) {
    switch (value.toLowerCase().trim()) {
      case 'wifi':
        return wifi;
      case 'phone':
      case 'cell':
      case 'mobile':
      case 'Phonecell':
        return phoneCell;
      default:
        return none;
    }
  }

  factory ConnectedFrom.fromConnectivityResult(ConnectivityResult value) {
    switch (value) {
      case ConnectivityResult.wifi:
        return wifi;
      case ConnectivityResult.mobile:
        return phoneCell;
      default:
        return none;
    }
  }

  bool isConnected() {
    if (_value != 'none') {
      return true;
    } else {
      return false;
    }
  }

  @override
  List<Object?> get props => [_value];

  @override
  String toString() => _value;
}

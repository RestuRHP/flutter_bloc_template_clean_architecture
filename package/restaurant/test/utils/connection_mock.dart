import 'package:core/core.dart';

class AlwaysConnected implements Connection {
  @override
  Future<bool> get isConnected async {
    return true;
  }
}

class AlwaysDisconnected implements Connection {
  @override
  Future<bool> get isConnected async {
    return false;
  }
}
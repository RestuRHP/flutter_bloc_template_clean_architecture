
import 'dart:developer';
import 'dart:io';

abstract class Connection {
  Future<bool> get isConnected;
}

class ConnectionImpl extends Connection{
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      return false;
    } on SocketException catch (exception) {
      log(exception.toString());
      return false;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }
}
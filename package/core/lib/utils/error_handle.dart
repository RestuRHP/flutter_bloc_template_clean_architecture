import 'package:core/core.dart';

String errorHandling(dynamic e) {
  if (e is ServerFailure) {
    return e.message;
  } else if (e is ConnectionFailure) {
    return e.message;
  } else {
    return e.toString();
  }
}

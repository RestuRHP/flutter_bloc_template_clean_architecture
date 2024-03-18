import 'dart:io';

import 'package:core/core.dart';
import 'package:core/injection.dart' as di;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  ApiClient._internal();

  static ApiClient? _instance;

  static ApiClient get instance => _instance ??= ApiClient._internal();
  static Dio? _dio;

  final FirebaseRemoteConfigService remoteConfig = di.locator<FirebaseRemoteConfigService>();

  Dio get dio {
    return _dio ??= _initializeDio();
  }

  Dio _initializeDio() {
    String certificate = remoteConfig.getString('certificate');
    Dio dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseURL,
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (code) => code! <= 500,
      headers: {
        'Content-type': ApiConfig.contentType,
      },
    ));

    // if(!kIsWeb){
    //   dio.httpClientAdapter = IOHttpClientAdapter(
    //     createHttpClient: () {
    //       final client = HttpClient();
    //       client.badCertificateCallback = (X509Certificate cert, String host, int port) {
    //         return cert.pem == certificate;
    //       };
    //       return client;
    //     },
    //     validateCertificate: (cert, host, port) {
    //       if (cert == null) {
    //         return false;
    //       }
    //       return cert.pem == certificate;
    //     },
    //   );
    // }

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 150,
      ));
    }

    return dio;
  }
}

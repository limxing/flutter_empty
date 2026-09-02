import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_empty/extensions/obj_extension.dart';

import '../common.dart';
import '../utils/preference.dart';
import 'api.dart';

class Net {
  static final Dio _dio = Dio();

  static Api api = Api(_dio, baseUrl: baseUrl);

  static SKey<String> proxy = SKey<String>("_proxy");
  static SKey<String> proxyHome = SKey<String>("_proxy_home");

  static void init(String userAgent) {
    _dio.options.connectTimeout = Duration(seconds: 10);
    _dio.options.sendTimeout = Duration(seconds: 10);
    _dio.options.receiveTimeout = Duration(seconds: 10);
    _dio.options.headers["user-agent"] = userAgent;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          var queryP = options.queryParameters;
          queryP.addAll({"version": "1.0.0"});
          if (kDebugMode) {
            '🌐 REQUEST[${options.method}] => ${options.uri} \n📃 Headers:${options.headers}\n📦 BODY: ${options.data}'
                .p;
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            '✅ RESPONSE[${response.statusCode}] => ${response.requestOptions.uri} \n📦 DATA: ${response.data}'.p;
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode) {
            '❌ ERROR[${error.response?.statusCode}] => ${error.requestOptions.uri} \n💬 MESSAGE: ${error.message}'.e;
          }
          handler.resolve(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: '{"data":null,"code":${error.response?.statusCode ?? 400},"msg":"${error.response?.statusMessage}"',
            ),
          );
        },
      ),
    );
    if (proxy.getValue()?.isNotEmpty == true) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
        client.findProxy = (uri) => "PROXY ${proxy.getValue()}";
        client.badCertificateCallback = (_, _1, _2) => true;
        return client;
      };
    }
  }
}

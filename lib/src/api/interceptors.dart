
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class Interceptor {
  http.Request onRequest(http.Request request) => request;
  http.Response onResponse(http.Response response) => response;
}

class LoggingInterceptor extends Interceptor {
  @override
  http.Request onRequest(http.Request request) {
    debugPrint('[API] --> ${request.method} ${request.url}');
    return request;
  }

  @override
  http.Response onResponse(http.Response response) {
    debugPrint('[API] <-- ${response.statusCode} ${response.request?.url}');
    return response;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/src/api/interceptors.dart';


class ApiClient {
  ApiClient({
    http.Client? httpClient,
    List<Interceptor> interceptors = const [],
    Duration timeout = const Duration(seconds: 15),
  })  : _client = httpClient ?? http.Client(),
        _interceptors = interceptors,
        _timeout = timeout;

  final http.Client _client;
  final List<Interceptor> _interceptors;
  final Duration _timeout;

  Future<Map<String, dynamic>> get(String url) async {
    var request = http.Request('GET', Uri.parse(url));

    for (final interceptor in _interceptors) {
      request = interceptor.onRequest(request);
    }

    try {
      final streamedResponse =
      await _client.send(request).timeout(_timeout);

      var response = await http.Response.fromStream(streamedResponse);

      for (final interceptor in _interceptors) {
        response = interceptor.onResponse(response);
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }

      throw HttpException(
        'Request failed with status: ${response.statusCode}',
        uri: request.url,
      );
    } on SocketException {
      throw const SocketException('No internet connection');
    } on FormatException {
      if (kDebugMode) {
        debugPrint('Invalid JSON response from API');
      }
      throw const FormatException('Invalid response format');
    }
  }

  void dispose() {
    _client.close();
  }
}

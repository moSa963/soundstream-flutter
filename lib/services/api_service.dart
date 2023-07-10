import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:soundstream_flutter/models/api_service_exaption.dart';

class ApiService {
  const ApiService();
  static const _baseUrl = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>> get(String url) async {
    return await _response(http.get(uri(url), headers: getHeaders()));
  }

  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic>? data) async {
    return await _response(
        http.post(uri(url), body: jsonEncode(data), headers: getHeaders()));
  }

  Future<Map<String, dynamic>> delete(String url) async {
    return await _response(http.delete(uri(url), headers: getHeaders()));
  }

  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic>? data) async {
    return await _response(
        http.put(uri(url), body: jsonEncode(data), headers: getHeaders()));
  }

  Map<String, String> getHeaders() {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization":
          "Bearer 1|LE3ZmYE2qQZsg2XGTQw5yRco5HPky6vY4D0Ck4MR", //temporary
    };
  }

  static Uri uri(String url) {
    return Uri.parse("$_baseUrl/api/$url");
  }

  Future<Map<String, dynamic>> _response(Future<http.Response> response) async {
    try {
      final res = await response;
      final Map<String, dynamic>? js =
          res.body.isNotEmpty ? jsonDecode(res.body) : null;

      if (!(res.statusCode >= 200 && res.statusCode <= 299)) {
        throw ApiServiceExaption(
            status: res.statusCode, message: js?["message"]);
      }

      return js ?? {};
    } on SocketException {
      throw ApiServiceExaption(message: "No Internet connection");
    } catch (e) {
      throw ApiServiceExaption(message: e.toString());
    }
  }
}

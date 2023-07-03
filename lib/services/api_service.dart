import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:soundstream_flutter/models/api_service_exaption.dart';

class ApiService {
  const ApiService();
  static const _baseUrl = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>> get(String url) async {
    return await _response(http.get(_uri(url), headers: getHeaders()));
  }

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic>? data) async {
    return await _response(
        http.post(_uri(url), body: data, headers: getHeaders()));
  }

  Future<Map<String, dynamic>> delete(String url) async {
    return await _response(http.delete(_uri(url), headers: getHeaders()));
  }

  Future<Map<String, dynamic>> put(String url, Map<String, dynamic>? data) async {
    return await _response(
        http.put(_uri(url), body: data, headers: getHeaders()));
  }

  Map<String, String> getHeaders() {
    return {
      "Accept": "application/json",
      "Authorization": "Bearer 1|LE3ZmYE2qQZsg2XGTQw5yRco5HPky6vY4D0Ck4MR", //temporary 
    };
  }

  Uri _uri(String url) {
    return Uri.parse("$_baseUrl/api/$url");
  }

  Future<Map<String, dynamic>> _response(Future<http.Response> response) async {
    try {
      final res = await response;
      final json = jsonDecode(res.body);

      if (!(res.statusCode >= 200 && res.statusCode <= 299)) {
        throw ApiServiceExaption(
            status: res.statusCode, message: json["message"]);
      }
      return json;
    } on SocketException {
      throw ApiServiceExaption(message: "No Internet connection");
    } catch (_) {
      throw ApiServiceExaption(message: "There is something wrong");
    }
  }
}

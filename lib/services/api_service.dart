import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:soundstream_flutter/models/api_service_exaption.dart';

class ApiService {
  const ApiService();

  static const _baseUrl = "http://127.0.0.1:8000";

  static FlutterSecureStorage? _flutterStorage;
  FlutterSecureStorage get _storage =>
      (_flutterStorage ??= const FlutterSecureStorage());

  Future<Map<String, dynamic>> get(String url) async {
    return await _response(http.get(uri(url), headers: await _getHeaders()));
  }

  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic>? data) async {
    return await _response(http.post(uri(url),
        body: jsonEncode(data), headers: await _getHeaders()));
  }

  Future<Map<String, dynamic>> delete(String url) async {
    return await _response(http.delete(uri(url), headers: await _getHeaders()));
  }

  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic>? data) async {
    return await _response(http.put(uri(url),
        body: jsonEncode(data), headers: await _getHeaders()));
  }

  Future<Map<String, String>> _getHeaders() async {
    String? token = await _storage.read(key: "token");

    return {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      if (token != null) HttpHeaders.authorizationHeader: "Bearer $token",
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

  Future<void> setToken(String? token) async {
    await _storage.write(key: "token", value: token);
  }

  Future<Map<String, dynamic>> multipartRequest(String method, String url,
      {Map<String, PlatformFile>? files, Map<String, String>? fields}) async {
    final req = http.MultipartRequest(method, uri(url))
      ..headers.addAll(await _getHeaders())
      ..fields.addAll(fields ?? {});

    files?.forEach((key, value) async {
      late http.MultipartFile file;
      try {
        file = await http.MultipartFile.fromPath(key, value.path ?? "");
      } catch (_) {
        file = http.MultipartFile.fromBytes(key, value.bytes ?? [],
            filename: value.name);
      }
      req.files.add(file);
    });

    return _response(http.Response.fromStream(await req.send()));
  }

  Future<Duration?> setAudioPlayerUrl(AudioPlayer player, String url) async {
    return player.setUrl(url, headers: await _getHeaders());
  }
}

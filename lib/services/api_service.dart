import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "http://127.0.0.1:8000";

  Future<http.Response> get(String url) async {
    return http.get(_uri(url), headers: getHeaders());
  }

   Future<http.Response> post(String url, Map<String, dynamic>? data) async {
    return http.post(_uri(url), body: data, headers: getHeaders());
   }

   Future<http.Response> delete(String url) async {
    return http.delete(_uri(url), headers: getHeaders());
   }

   Future<http.Response> put(String url, Map<String, dynamic>? data) async {
    return http.put(_uri(url), body: data, headers: getHeaders());
   }

  Map<String, String> getHeaders() {
    return {
      "Accept": "application/json",
      "Authorization": "Bearer ",
    };
  }

  Uri _uri(String url){
    return Uri.parse("$baseUrl/api/$url");
  }
}

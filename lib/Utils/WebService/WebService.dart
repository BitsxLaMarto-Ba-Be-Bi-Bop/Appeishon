import 'dart:convert';
import 'package:http/http.dart' as http;

import '../StorageService.dart';
import 'WebServicesVariables.dart';

class WebService {
  final String baseUrl;

  WebService({required this.baseUrl});

  Future<Map<String, String>> _getHeaders(bool needSession) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (needSession) {
      String? token = await StorageService().getSessionToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<http.Response> get(String endpoint, bool needSession) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders(needSession);
    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(
      String endpoint, Map<String, dynamic> body, bool needSession) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders(needSession);
    return await http.post(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> put(
      String endpoint, Map<String, dynamic> body, bool needSession) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders(needSession);
    return await http.put(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(String endpoint, bool needSession) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders(needSession);
    return await http.delete(url, headers: headers);
  }

  static getUrl(String endpoint) {
    return WebServicesVariables.BASE_URL + endpoint;
  }
}

// Ejemplo de uso:
// var webService = WebService(baseUrl: 'https://api.example.com');
// webService.get('/endpoint', true);

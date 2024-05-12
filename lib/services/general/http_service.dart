import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tez_projesi_android/services/general/storage_service.dart';
import 'package:tez_projesi_android/types/response_type.dart';

class HttpService {
  final String baseUrl = "https://apposite.live/api/";
  Map<String, String> header = {"Content-Type": "application/json"};

  Future<ResponseType> get(String url) async {
    final token = await StorageService.getToken();
    Map<String, String> authHeader = {
      "Authorization": "Bearer $token",
    };
    header.addAll(authHeader);

    try {
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: header);
      return ResponseType(
          body: jsonDecode(response.body), status: response.statusCode == 200);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseType> post(String url, dynamic body,
      {Map<String, String>? config}) async {
    final token = await StorageService.getToken();
    Map<String, String> authHeader = {
      "Authorization": "Bearer $token",
    };
    header.addAll(authHeader);

    try {
      if (config != null) {
        header.addAll(config);
      }
      final response = await http.post(Uri.parse(baseUrl + url),
          body: jsonEncode(body), headers: header);
      return ResponseType(
          body: jsonDecode(response.body),
          status: response.statusCode == 201 ||
              response.statusCode == 200 ||
              response.statusCode == 204);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseType> put(String url, dynamic body,
      {Map<String, String>? config}) async {
    final token = await StorageService.getToken();
    Map<String, String> authHeader = {
      "Authorization": "Bearer $token",
    };
    header.addAll(authHeader);

    try {
      if (config != null) {
        header.addAll(config);
      }
      final response = await http.put(Uri.parse(baseUrl + url),
          body: jsonEncode(body), headers: header);
      return ResponseType(
          body: jsonDecode(response.body),
          status: response.statusCode == 200 || response.statusCode == 204);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseType> delete(String url) async {
    final token = await StorageService.getToken();
    Map<String, String> authHeader = {
      "Authorization": "Bearer $token",
    };
    header.addAll(authHeader);

    try {
      final response =
          await http.delete(Uri.parse(baseUrl + url), headers: header);
      return ResponseType(
          body: jsonDecode(response.body),
          status: response.statusCode == 200 || response.statusCode == 204);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

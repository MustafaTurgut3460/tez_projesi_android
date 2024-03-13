import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tez_projesi_android/types/response_type.dart';

class HttpService {
  final String baseUrl = "";
  final Map<String, String> header = {"Content-Type": "application/json"};

  Future<ResponseType> get(String url) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: header);
      return ResponseType(body: jsonDecode(response.body), statusCode: response.statusCode);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseType> post(String url, dynamic body,
      {Map<String, String>? config}) async {
    try {
      if (config != null) {
        header.addAll(config);
      }
      final response = await http
          .post(Uri.parse(baseUrl + url), body: body, headers: header);
      return ResponseType(body: jsonDecode(response.body), statusCode: response.statusCode);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseType> put(String url, dynamic body,
      {Map<String, String>? config}) async {
    try {
      if (config != null) {
        header.addAll(config);
      }
      final response = await http
          .put(Uri.parse(baseUrl + url), body: body, headers: header);
      return ResponseType(body: jsonDecode(response.body), statusCode: response.statusCode);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseType> delete(String url) async {
    try {
      final response =
          await http.delete(Uri.parse(baseUrl + url), headers: header);
      return ResponseType(body: jsonDecode(response.body), statusCode: response.statusCode);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
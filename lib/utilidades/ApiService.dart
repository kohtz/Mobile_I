import 'dart:convert';
import 'package:http/http.dart' as http;

/// Enum para definir os verbos HTTP suportados
enum HttpVerb { get, post, put, delete }

/// Classe que representa a resposta da API com status e dados
class ApiResponse<T> {
  final T? data;
  final int statusCode;

  ApiResponse({
    required this.data,
    required this.statusCode,
  });
}

/// Serviço genérico de requisições HTTP
class ApiService {
  /// Método estático para realizar requisições
  static Future<ApiResponse<T>> request<T>({
    required String url,
    required HttpVerb verb,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    required T Function(dynamic json) fromJson,
  }) async {
    http.Response response;
    final defaultHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    try {
      switch (verb) {
        case HttpVerb.get:
          response = await http.get(Uri.parse(url), headers: defaultHeaders);
          break;
        case HttpVerb.post:
          response = await http.post(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
        case HttpVerb.put:
          response = await http.put(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
        case HttpVerb.delete:
          response = await http.delete(
            Uri.parse(url),
            headers: defaultHeaders,
            body: jsonEncode(body),
          );
          break;
      }

      final decoded = jsonDecode(response.body);
      final data = fromJson(decoded);

      return ApiResponse<T>(
        data: data,
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse<T>(
        data: null,
        statusCode: 500,
      );
    }
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'auth_controller.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  // --- GET Request ---
  static Future<ApiResponse> getRequest({required String url}) async {
    await _ensureTokenLoaded();

    if (AuthController.accessToken == null) {
      return ApiResponse(
        isSuccess: false,
        responseCode: 401,
        responseData: null,
        errorMessage: 'Access token missing. Please login.',
      );
    }

    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await get(uri, headers: {
        'token': AuthController.accessToken!, // use your backend header
      });

      _logResponse(url, response);
      return _handleResponse(response);

    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  // --- POST Request ---
  static Future<ApiResponse> postRequest({required String url, Map<String, dynamic>? body}) async {
    await _ensureTokenLoaded();

    if (AuthController.accessToken == null) {
      return ApiResponse(
        isSuccess: false,
        responseCode: 401,
        responseData: null,
        errorMessage: 'Access token missing. Please login.',
      );
    }

    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);

      Response response = await post(
        uri,
        headers: {
          'content-type': 'application/json',
          'token': AuthController.accessToken!,
        },
        body: jsonEncode(body),
      );

      _logResponse(url, response);
      return _handleResponse(response);

    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  // --- DELETE Request ---
  static Future<ApiResponse> deleteRequest({required String url}) async {
    await _ensureTokenLoaded();

    if (AuthController.accessToken == null) {
      return ApiResponse(
        isSuccess: false,
        responseCode: 401,
        responseData: null,
        errorMessage: 'Access token missing. Please login.',
      );
    }

    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await delete(uri, headers: {
        'token': AuthController.accessToken!,
      });

      _logResponse(url, response);
      return _handleResponse(response);

    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  // --- Private helpers ---
  static Future<void> _ensureTokenLoaded() async {
    if (AuthController.accessToken == null) {
      await AuthController.getData();
    }
  }
//handing unauthorizeing problem
  static ApiResponse _handleResponse(Response response) {
    final int statusCode = response.statusCode;
    final decodedData = jsonDecode(response.body);

    if (statusCode == 200 || statusCode == 201) {
      return ApiResponse(
        isSuccess: true,
        responseCode: statusCode,
        responseData: decodedData,
      );
      //jdi 401 ashe tkn
    } else if (statusCode == 401) {
      return ApiResponse(
        isSuccess: false,
        responseCode: statusCode,
        responseData: null,
        errorMessage: 'Unauthorized access. Please login again.',
      );
    } else {
      return ApiResponse(
        isSuccess: false,
        responseCode: statusCode,
        responseData: decodedData,
        errorMessage: decodedData['data'] ?? 'Something went wrong', //postman e j data ase ta nibe
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i('URL => $url\nRequest Body: $body');
  }

  static void _logResponse(String url, Response response) {
    _logger.i('URL => $url\nStatus Code: ${response.statusCode}\nBody: ${response.body}');
  }
}

// --- Response Wrapper ---
class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}

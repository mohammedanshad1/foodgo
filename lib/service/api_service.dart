import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://api.gulika.app/api';
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Login endpoint
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login/',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Save tokens and email to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access']);
        await prefs.setString('refresh_token', data['refresh']);
        await prefs.setString('user_email', data['email']);
        await prefs.setBool('is_logged_in', true);
        
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'error': 'Something went wrong. Please try again.',
        };
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          final data = e.response!.data;
          return {
            'success': false,
            'error': data['detail'] ?? 'Invalid email or password.',
          };
        }
        return {
          'success': false,
          'error': 'Server error: ${e.response!.statusCode}',
        };
      } else if (e.type == DioExceptionType.connectionTimeout ||
                 e.type == DioExceptionType.receiveTimeout) {
        return {
          'success': false,
          'error': 'Connection timeout. Please try again.',
        };
      } else {
        return {
          'success': false,
          'error': 'Network error. Please check your connection.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'An unexpected error occurred.',
      };
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_email');
    await prefs.setBool('is_logged_in', false);
  }

  // Get stored email
  static Future<String?> getStoredEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  // Get stored access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Get stored refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  // Refresh token
  static Future<bool> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '/token/refresh/',
        data: {
          'refresh': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Generic GET request with token
  static Future<Response?> getWithAuth(String endpoint) async {
    try {
      final token = await getAccessToken();
      if (token == null) return null;

      final response = await _dio.get(
        endpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expired, try to refresh
        final refreshed = await refreshToken();
        if (refreshed) {
          // Retry the request
          final newToken = await getAccessToken();
          if (newToken != null) {
            return await _dio.get(
              endpoint,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $newToken',
                },
              ),
            );
          }
        }
      }
      return null;
    }
  }

  // Generic POST request with token
  static Future<Response?> postWithAuth(String endpoint, Map<String, dynamic> data) async {
    try {
      final token = await getAccessToken();
      if (token == null) return null;

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expired, try to refresh
        final refreshed = await refreshToken();
        if (refreshed) {
          // Retry the request
          final newToken = await getAccessToken();
          if (newToken != null) {
            return await _dio.post(
              endpoint,
              data: data,
              options: Options(
                headers: {
                  'Authorization': 'Bearer $newToken',
                },
              ),
            );
          }
        }
      }
      return null;
    }
  }
}
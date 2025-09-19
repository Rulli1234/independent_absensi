import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:independent_absensi/api/endpoint.dart';
import 'package:independent_absensi/shared_perfrence/shared_perfrence.dart';

class AuthService {
  /// LOGIN USER
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.login),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // contoh response {"success": true, "token": "...", "user": {...}}
        if (data['success'] == true) {
          final token = data['token'];
          PreferenceHandler.saveLogin();
          PreferenceHandler.saveToken(token);
        }

        return data;
      } else {
        return {"success": false, "message": "Login gagal"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// REGISTER USER
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.register),
        body: {"name": name, "email": email, "password": password},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        return {"success": false, "message": "Register gagal"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}

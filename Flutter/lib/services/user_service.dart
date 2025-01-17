import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String baseUrl = 'https://10.0.2.2:7042';

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/taiKhoan/DangNhap'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tenDangNhap': username,
          'MatKhau': password,
        }),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        String userID = responseBody['userID'] ?? '';
        await _saveUserID(userID);

        return responseBody;
      } else {
        print('API Error: ${response.body}');
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Network Error: $e');
      throw Exception('Network error: $e');
    }
  }

  static Future<void> _saveUserID(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID);
  }

  static Future<String?> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID');
  }

  static void overrideHttp() {
    HttpOverrides.global = MyHttpOverrides();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

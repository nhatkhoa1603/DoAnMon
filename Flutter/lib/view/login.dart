import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../Widget/text_field.dart';
import 'sign_up.dart';
import 'trangchu.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> loginApi(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://10.0.2.2:7042/taiKhoan/DangNhap'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tenDangNhap': username,
          'MatKhau': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Lỗi đăng nhập: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi mạng: $e');
    }
  }

  void loginUsers() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showSnackBar(context, "Vui lòng điền đầy đủ thông tin");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await loginApi(username, password);
      print('Response data: $response');

      if (response['success'] == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TrangChu(),
            settings: RouteSettings(arguments: response['maTaiKhoan']),
          ),
        );
        showSnackBar(context, "Đăng nhập thành công!");
      } else {
        showSnackBar(context, response['message'] ?? "Đăng nhập thất bại");
      }
    } catch (e) {
      showSnackBar(context, "Lỗi kết nối: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Image.asset(
                "images/signup.jpg",
                fit: BoxFit.cover,
                height: 250,
                width: 300,
              ),
            ),
            TextFieldInput(
              textEditingController: usernameController,
              hintText: "Nhập tên đăng nhập của bạn",
              icon: Icons.person,
            ),
            TextFieldInput(
              isPass: true,
              textEditingController: passwordController,
              hintText: "Nhập mật khẩu",
              icon: Icons.lock,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : MyButton(onTap: loginUsers, text: "Đăng nhập"),
            const SizedBox(height: 17),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                const Text("   or   "),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bạn Chưa Có Tài Khoản ? ",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Đăng Ký Ngay",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

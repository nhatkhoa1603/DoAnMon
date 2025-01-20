import 'package:doanmonhoc/view/danhsachdon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';
import '../Widget/text_field.dart';
import '../services/user_service.dart';
import 'sign_up.dart';
import 'trangchu.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({Key? key}) : super(key: key);

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

  Future<void> loginUsers() async {
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
      final response = await UserService.login(username, password);
      print('Dữ liệu phản hồi: $response');

      if (response['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', response['maTaiKhoan'].toString());

        String role = response['taiKhoan']['loaiTaiKhoan'];

        if (role == "ADMIN") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => QuanLyDonHang(),
              settings:
                  RouteSettings(arguments: response['maTaiKhoan'].toString()),
            ),
          );
        } else {
          // If the user is a regular user, navigate to TrangChu (Home Page)
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TrangChu(),
              settings:
                  RouteSettings(arguments: response['maTaiKhoan'].toString()),
            ),
          );
        }

        showSnackBar(context, "Đăng nhập thành công!");
      } else {
        showSnackBar(context, response['message'] ?? "Đăng nhập thất bại");
      }
    } catch (e) {
      showSnackBar(context, "Tên đăng nhập và mật khẩu không hợp lệ");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 120, left: 18, right: 18, bottom: 18),
                child: Image.asset(
                  "images/signup.jpg",
                  fit: BoxFit.cover,
                  height: 250,
                  width: 300,
                ),
              ),
              TextFieldInput(
                textEditingController: usernameController,
                hintText: "Nhập tên đăng nhập",
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
                  const Text("   hoặc   "),
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
                    "Bạn chưa có tài khoản? ",
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
                      "Đăng ký ngay",
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
      ),
    );
  }
}

// Hàm hiển thị thông báo SnackBar
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

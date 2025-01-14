import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../Widget/text_field.dart';
import 'login.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedAccountType;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    genderController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    final username = usernameController.text.trim();
    final name = nameController.text.trim();
    final gender = genderController.text.trim();
    final address = addressController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final accountType = selectedAccountType;

    // Validate inputs
    if (username.isEmpty ||
        name.isEmpty ||
        gender.isEmpty ||
        address.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        accountType == null) {
      showSnackBar(context, "Vui lòng điền đầy đủ thông tin");
      return;
    }

    if (!isValidEmail(email)) {
      showSnackBar(context, "Email phải có định dạng @gmail.com");
      return;
    }

    if (password.length < 6) {
      showSnackBar(context, "Mật khẩu phải có ít nhất 6 ký tự");
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      showSnackBar(context, "Số điện thoại không hợp lệ");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://localhost:7042/taiKhoan/Them'),
        // Đổi endpoint cho phù hợp
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tenDangNhap': username,
          'MatKhau': password,
          'LoaiTaiKhoan': accountType,
          'TenKhachHang': name,
          'GioiTinh': gender,
          'DiaChi': address,
          'SoDienThoai': phone,
          'Email': email,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginApp(),
          ),
        );
        showSnackBar(context, "Đăng ký thành công!");
      } else {
        showSnackBar(context,
            responseData['message'] ?? "Đăng ký thất bại, vui lòng thử lại");
      }
    } catch (e) {
      print('Error during sign-up: $e');
      showSnackBar(context, "Lỗi kết nối: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isValidEmail(String email) {
    return email.toLowerCase().endsWith('@gmail.com');
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
              hintText: "Nhập tên đăng nhập",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 10),
            TextFieldInput(
              textEditingController: nameController,
              hintText: "Nhập tên khách hàng",
              icon: Icons.person,
            ),
            const SizedBox(height: 10),
            TextFieldInput(
              textEditingController: genderController,
              hintText: "Nhập giới tính",
              icon: Icons.people,
            ),
            const SizedBox(height: 10),
            TextFieldInput(
              textEditingController: addressController,
              hintText: "Nhập địa chỉ",
              icon: Icons.location_on,
            ),
            const SizedBox(height: 10),
            TextFieldInput(
              textEditingController: phoneController,
              hintText: "Nhập số điện thoại",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            TextFieldInput(
              textEditingController: emailController,
              hintText: "Nhập email",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFieldInput(
              textEditingController: passwordController,
              hintText: "Nhập mật khẩu",
              icon: Icons.lock,
              isPass: true,
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_box, color: Colors.grey),
                  const SizedBox(width: 15),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedAccountType,
                        hint: const Text("Chọn loại tài khoản"),
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                              value: "Cá nhân", child: Text("Cá nhân")),
                          DropdownMenuItem(
                              value: "Doanh nghiệp",
                              child: Text("Doanh nghiệp")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedAccountType = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            isLoading
                ? const CircularProgressIndicator()
                : MyButton(onTap: signUpUser, text: "Đăng Ký"),
            const SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bạn đã có tài khoản? ",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginApp(),
                      ),
                    );
                  },
                  child: const Text(
                    "Đăng Nhập Ngay",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

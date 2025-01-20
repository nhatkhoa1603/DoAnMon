import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Widget/text_field.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedGender;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    final username = usernameController.text.trim();
    final name = nameController.text.trim();
    final gender = selectedGender;
    final address = addressController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final accountType = 'KHACHHANG';

    setState(() {
      isLoading = true;
    });

    if (username.isEmpty ||
        name.isEmpty ||
        gender == null ||
        address.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      showSnackBar(context, "Vui lòng điền đầy đủ thông tin");
      setState(() {
        isLoading = false;
      });
      return;
    }
    if (gender == null) {
      showSnackBar(context, "Vui lòng chọn giới tính");
      setState(() {
        isLoading = false;
      });
      return;
    }

    bool isValidEmail(String email) {
      return email.toLowerCase().endsWith('@gmail.com');
    }

    if (!isValidEmail(email)) {
      showSnackBar(context, "Email phải có định dạng @gmail.com");
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (password.length < 6) {
      showSnackBar(context, "Mật khẩu phải có ít nhất 6 ký tự");
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      showSnackBar(context, "Số điện thoại không hợp lệ");
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final responseKhachHang = await http.post(
        Uri.parse('https://10.0.2.2:7042/KhachHang/Them'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'TenKhachHang': name,
          'GioiTinh': gender,
          'DiaChi': address,
          'SoDienThoai': phone,
          'Email': email,
        }),
      );

      final responseTaiKhoan = await http.post(
        Uri.parse('https://10.0.2.2:7042/TaiKhoan/Them'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tenDangNhap': username,
          'matKhau': password,
          'loaiTaiKhoan': accountType,
        }),
      );

      if (responseKhachHang.statusCode == 200 &&
          responseTaiKhoan.statusCode == 200) {
        final responseDataKhachHang = jsonDecode(responseKhachHang.body);
        final responseDataTaiKhoan = jsonDecode(responseTaiKhoan.body);

        if (responseDataKhachHang['success'] == true &&
            responseDataTaiKhoan['success'] == true) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginApp(),
            ),
          );
          showSnackBar(context, "Đăng ký thành công!");
        } else {
          showSnackBar(
              context,
              responseDataKhachHang['message'] ??
                  "Đăng ký thất bại, vui lòng thử lại");
        }
      } else {
        showSnackBar(context, "Đăng ký thất bại, vui lòng thử lại");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
            const SizedBox(height: 20), // Khoảng cách từ trên cùng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginApp(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
            const SizedBox(height: 5),
            TextFieldInput(
              textEditingController: nameController,
              hintText: "Nhập tên khách hàng",
              icon: Icons.person,
            ),
            const SizedBox(height: 5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chọn giới tính:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text("Nam"),
                        value: "Nam",
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text("Nữ"),
                        value: "Nữ",
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
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

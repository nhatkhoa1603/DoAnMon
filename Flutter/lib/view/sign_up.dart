import 'package:doanmonhoc/view/login.dart';
import 'package:flutter/material.dart';
//import '../LoginSignin/login.dart';
import '../Widget/snack_bar.dart';
import '../Widget/button.dart';
import '../Widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    // Kiểm tra thông tin người dùng nhập
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      showSnackBar(context, "Vui lòng điền đầy đủ thông tin");
      return;
    }

    if (password.length < 6) {
      showSnackBar(context, "Mật khẩu phải có ít nhất 6 ký tự");
      return;
    }

    // Giả lập đăng ký thành công
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });

      // Điều hướng tới màn hình đăng nhập sau khi đăng ký thành công
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginApp(),
        ),
      );

      showSnackBar(context, "Đăng ký thành công!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký tài khoản"),
        backgroundColor: Color(0xFF2196F3),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Image.asset(
                "images/signup.jpg",
                fit: BoxFit.cover,
                height: 300,
                width: 300,
              ),
            ),
            TextFieldInpute(
              textEditingController: nameController,
              hintText: "Nhập tên của bạn",
              icon: Icons.person,
            ),
            TextFieldInpute(
              textEditingController: emailController,
              hintText: "Nhập email của bạn",
              icon: Icons.email,
            ),
            TextFieldInpute(
              textEditingController: passwordController,
              hintText: "Nhập mật khẩu",
              icon: Icons.lock,
              isPass: true,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : MyButton(onTap: signUpUser, text: "Đăng Ký"),
            const SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Bạn đã có tài khoản? ",
                    style: TextStyle(fontSize: 16)),
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
                        color: Color(0xFF2196F3)),
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

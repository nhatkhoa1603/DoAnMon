import 'package:doanmonhoc/view/forgotpassword.dart';
import 'package:doanmonhoc/view/sign_up.dart';
import 'package:doanmonhoc/view/trangchu.dart';
import 'package:flutter/material.dart';
//import '../ForgotPassword/forgotpassword.dart';
//import '../LoginSignin/sign_up.dart';
import '../Widget/button.dart';
import '../Widget/text_field.dart';
import '../Widget/snack_bar.dart';
//import '../screen/chitietsp.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUsers() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(context, "Vui lòng điền đầy đủ thông tin");
      return;
    }

    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });

      if (email == "1@gmail.com" && password == "1") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TrangChu(),
          ),
        );
        showSnackBar(context, "Đăng nhập thành công!");
      } else {
        showSnackBar(context, "Email hoặc mật khẩu không đúng");
      }
    });
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
                "images/login.jpg",
                fit: BoxFit.cover,
                height: 300,
                width: 300,
              ),
            ),
            TextFieldInpute(
              textEditingController: emailController,
              hintText: "Nhập email của bạn",
              icon: Icons.email,
            ),
            TextFieldInpute(
              isPass: true,
              textEditingController: passwordController,
              hintText: "Nhập mật khẩu",
              icon: Icons.lock,
            ),
            const Forgotpassword(),
            isLoading
                ? const CircularProgressIndicator()
                : MyButton(onTap: loginUsers, text: "Đăng nhập"),
            const SizedBox(
              height: 17,
            ),
            //SizedBox(height: 70,),
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
                const Text("Bạn Chưa Có Tài Khoản ? ",
                    style: TextStyle(fontSize: 16)),
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
// Widget/forgotpassword.dart
//import 'package:flutter/material.dart';
//import '../screen/forgotpassword.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
          child: const Text(
            "Quên mật khẩu ?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF2196F3),
            ),
          ),
        ),
      ),
    );
  }
}

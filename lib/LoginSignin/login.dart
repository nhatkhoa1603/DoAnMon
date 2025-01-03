import 'package:doanmonhoc/screen/trangchu.dart';
import 'package:flutter/material.dart';
import '../ForgotPassword/forgotpassword.dart';
import '../LoginSignin/sign_up.dart';
import '../Widget/button.dart';
import '../Widget/text_field.dart';
import '../Services/FirebaseAPI.dart';
import '../Widget/snack_bar.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void despose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUsers() async {
    // ignore: unused_local_variable
    String res = await AuthServicews().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => trangChu(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context, res);
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
              child: Image.asset("images/login.jpg",
                  fit: BoxFit.cover, height: 300, width: 300),
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
            MyButton(onTap: loginUsers, text: "Đăng nhập"),
            const SizedBox(
              height: 17,
            ),
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
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

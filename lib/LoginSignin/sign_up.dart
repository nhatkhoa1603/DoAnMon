import 'package:flutter/material.dart';
import '../LoginSignin/login.dart';
import '../Widget/snack_bar.dart';
import '../Services/FirebaseAPI.dart';
import '../Widget/button.dart';
import '../Widget/text_field.dart';
import '../screen/trangchu.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    // ignore: unused_local_variable
    bool isLoading = false;

    void dispose() {
      super.dispose();
      emailController.dispose();
      passwordController.dispose();
      nameController.dispose();
    }

    void signUpUser() async {
      // ignore: unused_local_variable
      String res = await AuthServicews().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
      );
      if (res == "success") {
        setState(() {
          isLoading = true;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginApp(),
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Image.asset("images/signup.jpg",
                  fit: BoxFit.cover, height: 300, width: 300),
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
            MyButton(onTap: signUpUser, text: "Đăng Ký"),
            const SizedBox(
              height: 17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Bạn đã có tài khoản ? ",
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

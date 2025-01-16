// lib/screens/login.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart'; // Import the UserService
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
      showSnackBar(context, "Please fill in all fields");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response =
          await UserService.login(username, password); // Call the login method
      print('Response data: $response');

      if (response['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', response['maTaiKhoan'].toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TrangChu(),
            settings:
                RouteSettings(arguments: response['maTaiKhoan'].toString()),
          ),
        );
        showSnackBar(context, "Login successful!");
      } else {
        showSnackBar(context, response['message'] ?? "Login failed");
      }
    } catch (e) {
      showSnackBar(context, "Connection error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // void checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString('userId');
  //   print(userId);
  //   if (userId != null) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => TrangChu(),
  //         settings: RouteSettings(arguments: userId),
  //       ),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //checkLoginStatus();
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
              hintText: "Enter your username",
              icon: Icons.person,
            ),
            TextFieldInput(
              isPass: true,
              textEditingController: passwordController,
              hintText: "Enter your password",
              icon: Icons.lock,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : MyButton(onTap: loginUsers, text: "Login"),
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
                  "Don't have an account? ",
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
                    "Sign Up",
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

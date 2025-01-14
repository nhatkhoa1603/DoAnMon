// forgotpassword.dart
import 'package:flutter/material.dart';
import '../Widget/button.dart';
import '../Widget/text_field.dart';
import '../Widget/snack_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showSnackBar(context, "Vui lòng nhập email");
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Giả lập gửi email reset password
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Đã gửi link reset password đến email của bạn");
      Navigator.pop(context); // Quay lại màn hình login
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quên Mật Khẩu',
          style: TextStyle(color: Colors.black),
        ),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                "images/forgot_password.jpg", // Thêm hình ảnh nếu có
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 30),
              const Text(
                'Nhập email của bạn để reset mật khẩu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              TextFieldInpute(
                textEditingController: emailController,
                hintText: "Nhập email của bạn",
                icon: Icons.email,
              ),
              const SizedBox(height: 30),
              isLoading
                  ? const CircularProgressIndicator()
                  : MyButton(
                      onTap: resetPassword,
                      text: "Reset Password",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
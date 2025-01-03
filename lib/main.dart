import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // Để sử dụng kIsWeb
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../LoginSignin/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase tùy theo môi trường Web hoặc Di động
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB1aptfQX8n-H6WjF1WevAHhhL5Y8MBkAs",
        authDomain: "stationery-c01.firebaseapp.com",
        databaseURL: "https://stationery-c01-default-rtdb.firebaseio.com",
        projectId: "stationery-c01",
        storageBucket: "stationery-c01.appspot.com",
        messagingSenderId: "1036464544050",
        appId: "1:1036464544050:web:2eac9b979f608bae04df2b",
      ),
    );
  } else {
    await Firebase
        .initializeApp(); // Mobile tự động sử dụng file google-services.json
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (kIsWeb) {
              return const WebHomeScreen(); // Màn hình Home dành cho Web
            } else if (Platform.isAndroid || Platform.isIOS) {
              return const MobileHomeScreen(); // Màn hình Home dành cho Mobile
            } else {
              return const LoginApp(); // Dự phòng cho các nền tảng khác
            }
          } else {
            return const LoginApp();
          }
        },
      ),
    );
  }
}

// Placeholder: Màn hình dành riêng cho Web
class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web Home')),
      body: const Center(child: Text('Welcome to the Web version!')),
    );
  }
}

// Placeholder: Màn hình dành riêng cho Mobile
class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Home')),
      body: const Center(child: Text('Welcome to the Mobile version!')),
    );
  }
}

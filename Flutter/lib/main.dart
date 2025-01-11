import 'dart:io';
import 'package:doanmonhoc/LoginSignin/homeScreen.dart';
import 'package:doanmonhoc/screen/chitietsp.dart';
import 'package:doanmonhoc/screen/dien_tt_mua_hang.dart';
import 'package:doanmonhoc/screen/giohang.dart';
import 'package:doanmonhoc/screen/thongTinNguoiDungScreen.dart';
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
    return MaterialApp(debugShowCheckedModeBanner: false, home: Chitietsp());
  }
}

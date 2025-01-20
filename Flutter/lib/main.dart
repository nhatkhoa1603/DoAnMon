import 'dart:io';
import 'package:provider/provider.dart';
import 'package:doanmonhoc/model/gioHang.dart';

import 'package:doanmonhoc/view/chitietdon.dart';
import 'package:doanmonhoc/view/danhmuc.dart';
import 'package:doanmonhoc/view/danhsachdon.dart';
import 'package:doanmonhoc/view/donhangsreen.dart';
//import 'package:doanmonhoc/screen/forgotpassword.dart';
import 'package:doanmonhoc/view/login.dart';
import 'package:doanmonhoc/view/setting.dart';
import 'package:doanmonhoc/view/sign_up.dart';
import 'package:doanmonhoc/view/taikhoan.dart';
import 'package:doanmonhoc/view/thanhtoan.dart';
import 'package:doanmonhoc/view/thongtincanhan.dart';
import 'package:doanmonhoc/view/thongtincanhan_real.dart';

import 'package:doanmonhoc/view/timkiemSP.dart';
import 'package:flutter/material.dart';
//import 'screen/danhmuc.dart';
//import 'screen/taikhoang.dart';
import 'view/trangchu.dart';
import 'view/chitietsp.dart';
import 'view/thongtinmuahang.dart';
import 'view/giohang.dart';
//import '../LoginSignin/login.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/dangnhap',
      routes: {
        '/dangnhap': (context) => LoginApp(),
        '/signup': (context) => SignUpScreen(),
        '/trangchu': (context) => TrangChu(),
        '/danhmuc': (context) => DanhMuc(),
        '/taikhoan': (context) => TaiKhoan(),
        '/giohang': (context) => Giohang(),
        '/caidat': (context) => CaiDat(),
        '/chinhsuattcanhan': (context) => PersonalInfoScreen(
              userId: '{id}',
            ),
        '/thongtinmuahang': (context) => thong_tin_mua_hang(),
        '/chitietsanpham': (context) => Chitietsp(),
        '/danhsachdon': (context) => QuanLyDonHang(),
        '/chitietdon': (context) => chitietdon(),
        '/donhangcuatoi': (context) => DonHangScreen(),
        '/thanhtoan': (context) => ThanhToan(),
        '/timkiem': (context) => Timkiemsp(),
        '/thongtincanhan': (context) => tTinCaNhan(userId: '{id}'),
      },
    );
  }
}

import 'dart:convert';

import 'package:doanmonhoc/model/hoaDon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hoadonviewmodel extends ChangeNotifier {
  List<Hoadon> _hoaDons = [];
  bool _isLoading = false;

  List<Hoadon> get hoaDons => _hoaDons;
  bool get isLoading => _isLoading;

  Future<void> fetchHoaDons() async {
    _isLoading = true;
    notifyListeners(); // Thông báo UI để hiển thị trạng thái loading

    final response =
        await http.get(Uri.parse('https://10.0.2.2:7042/hoaDon/danhSach'));

    if (response.statusCode == 200) {
      // Nếu phản hồi thành công, parse dữ liệu
      final List<dynamic> data = json.decode(response.body);
      _hoaDons = data.map((json) => Hoadon.fromJson(json)).toList();
    } else {
      // Nếu có lỗi, bạn có thể xử lý như hiển thị thông báo lỗi
      throw Exception('Không thể tải dữ liệu');
    }

    _isLoading = false;
    notifyListeners(); // Cập nhật UI sau khi xong
  }
}

import 'dart:convert';

import 'package:doanmonhoc/model/hoaDonAdmin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuanLyDonHang extends StatefulWidget {
  @override
  State<QuanLyDonHang> createState() => _QuanLyDonHangState();
}

class _QuanLyDonHangState extends State<QuanLyDonHang> {
  List<hoaDonAdmin> hoaDons = [];

  Future<void> fetchDSDon() async {
    final response =
        await http.get(Uri.parse("https://10.0.2.2:7042/hoaDon/danhSach"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        hoaDons = data.map((value) => hoaDonAdmin.fromJson(value)).toList();
      });
    }
  }

  Future<void> fetchDSDonTheoTrangThai(int trangthai) async {
    final response = await http.get(
        Uri.parse("https://10.0.2.2:7042/hoaDon/locTheotrangthai/$trangthai"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        hoaDons = data.map((value) => hoaDonAdmin.fromJson(value)).toList();
      });
    }
  }

  Future<void> duyetDon(BuildContext context, int maHoaDon) async {
    final reponse = await http.put(
      Uri.parse('https://10.0.2.2:7042/hoaDon/capNhat/$maHoaDon'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (reponse.statusCode == 200) {
      final data = json.decode(reponse.body);
      if (data['success']) {
        Navigator.pop(context, true);
      } else {
        thongBaoLoi(context, data['message']);
      }
    } else {
      thongBaoLoi(context, "Lỗi khi cập nhật thông tin");
    }
  }

  void thongBaoLoi(BuildContext context, String mess) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Lỗi"),
            content: Text(mess),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  int selectedFilter = -1;

  @override
  void initState() {
    super.initState();
    fetchDSDon();
  }

  void filterOrders(int status) {
    setState(() {
      selectedFilter = status;
    });
    if (status == -1) {
      fetchDSDon();
    } else {
      fetchDSDonTheoTrangThai(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản Lý Đơn Hàng',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PopupMenuButton<int>(
                  onSelected: filterOrders,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: -1,
                      child: Text('Tất cả'),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Chờ xác nhận'),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text('Đang giao'),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text('Đã hoàn thành'),
                    ),
                    const PopupMenuItem(
                      value: 0,
                      child: Text('Đã hủy'),
                    ),
                  ],
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.filter_list),
                    label: Text(
                        'Lọc: ${selectedFilter == -1 ? "Tất cả" : selectedFilter == 0 ? "Đã hủy" : selectedFilter == 1 ? "Chờ xác nhận" : selectedFilter == 2 ? "Đang giao" : "Đã hoàn thành"} '),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Danh sách đơn hàng
            Expanded(
              child: ListView.builder(
                itemCount: hoaDons.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          // Thông tin đơn hàng
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mã đơn: ${hoaDons[index].maHoaDon}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    'Khách hàng: ${hoaDons[index].tenKhachHang}'),
                                Text(
                                  'Trạng thái: ${hoaDons[index].trangThai == 2 ? "Đang giao" : hoaDons[index].trangThai == 0 ? "Đã hủy" : hoaDons[index].trangThai == 3 ? "Đã hoàn thành" : "Chờ xác nhận"}',
                                  style: TextStyle(
                                    color: hoaDons[index].trangThai == 2
                                        ? Colors.blue
                                        : hoaDons[index].trangThai == 0
                                            ? Colors.red
                                            : hoaDons[index].trangThai == 3
                                                ? Colors.green
                                                : Colors.orange,
                                  ),
                                ),
                                Text('Ngày Đặt: ${hoaDons[index].ngayDatHang}'),
                              ],
                            ),
                          ),
                          // Nút hành động
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.visibility,
                                    color: Colors.blue),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/chitietdon",
                                      arguments: hoaDons[index]);
                                },
                              ),
                              hoaDons[index].trangThai == 1
                                  ? IconButton(
                                      icon: const Icon(Icons.check,
                                          color: Colors.green),
                                      onPressed: () {
                                        duyetDon(
                                            context, hoaDons[index].maHoaDon);
                                      },
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

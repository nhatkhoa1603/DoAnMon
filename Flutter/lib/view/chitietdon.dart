import 'dart:convert';

import 'package:doanmonhoc/model/chiTietHoaDon.dart';
import 'package:doanmonhoc/model/hoaDonAdmin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class chitietdon extends StatefulWidget {
  @override
  State<chitietdon> createState() => _chitietdonState();
}

class _chitietdonState extends State<chitietdon> {
  List<chiTietHoaDonAdmin> chiTietdons = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hoaDon = ModalRoute.of(context)!.settings.arguments as hoaDonAdmin;
      fetchDSDon(hoaDon.maHoaDon); // Tải danh sách khi widget được khởi tạo
    });
  }

  Future<void> fetchDSDon(int ma) async {
    final response = await http
        .get(Uri.parse("https://10.0.2.2:7042/chiTietHoaDon/danhSach/$ma"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        chiTietdons =
            data.map((value) => chiTietHoaDonAdmin.fromJson(value)).toList();
      });
    }
  }

  Future<void> capNhatSoLuong(
      BuildContext context, int maHoaDon, int maSanPham, int soLuong) async {
    final reponse = await http.put(
        Uri.parse(
            'https://10.0.2.2:7042/chiTietHoaDon/Sua/soLuong?maHoaDon=$maHoaDon&maSanPham=$maSanPham&soLuongMoi=$soLuong'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{'soLuong': soLuong}));
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

  // Hàm cập nhật số lượng sản phẩm
  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      chiTietdons[index].soLuong = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    hoaDonAdmin hoaDon =
        ModalRoute.of(context)!.settings.arguments as hoaDonAdmin;
    // fetchDSDon(hoaDon.maHoaDon);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn hàng",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin người mua
              Text(
                "Thông tin người mua",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                title: Text(hoaDon.tenKhachHang),
                subtitle: Text(hoaDon.soDienThoai),
              ),
              Divider(),

              // Thông tin đơn hàng (Danh sách sản phẩm)
              Text(
                "Thông tin đơn hàng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: chiTietdons.length,
                itemBuilder: (context, index) {
                  final item = chiTietdons[index];
                  return OrderItemCard(
                    item: item,
                    onQuantityChanged: (newQuantity) {
                      _updateQuantity(index, newQuantity);
                    },
                  );
                },
              ),
              Divider(),

              // Trạng thái đơn hàng
              Text(
                "Trạng thái đơn hàng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              color: hoaDon.trangThai == 3
                                  ? Colors.greenAccent
                                  : hoaDon.trangThai == 0
                                      ? Colors.red
                                      : hoaDon.trangThai == 2
                                          ? Colors.lightBlue
                                          : Colors.orange),
                          SizedBox(width: 8),
                          Text(
                              '${hoaDon.trangThai == 3 ? "Hoàn thành" : hoaDon.trangThai == 0 ? "Đã hủy" : hoaDon.trangThai == 2 ? "Đang giao" : "Chờ xác nhận"}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: hoaDon.trangThai == 3
                                      ? Colors.greenAccent
                                      : hoaDon.trangThai == 0
                                          ? Colors.red
                                          : hoaDon.trangThai == 2
                                              ? Colors.lightBlue
                                              : Colors.orange)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),

              // Tổng cộng
              Text(
                "Tổng cộng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TotalPriceCard(orderItems: chiTietdons),
              Divider(),

              // Các nút hành độngs
              SizedBox(height: 16),
              hoaDon.trangThai == 1
                  ? ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Xác nhận"),
                              content: Text(
                                  "Bạn có chắc chắn muốn cập nhật thông tin sản phẩm không?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng dialog
                                  },
                                  child: Text("Hủy"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop(); // Đóng dialog
                                    // Thực hiện cập nhật thông tin
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Thông tin sản phẩm đã được cập nhật!"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    for (var item in chiTietdons) {
                                      await capNhatSoLuong(
                                        context,
                                        hoaDon.maHoaDon,
                                        item.maSanPham,
                                        item.soLuong,
                                      );
                                    }
                                  },
                                  child: Text("Xác nhận"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Cập nhật lại thông tin sản phẩm",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final chiTietHoaDonAdmin item;
  final Function(int) onQuantityChanged;

  OrderItemCard({required this.item, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              item.hinhAnh,
              width: 100,
              height: 100,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.tenSanPham,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Số lượng: ${item.soLuong}"),
                  SizedBox(height: 8),
                  // Các nút điều chỉnh số lượng
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (item.soLuong > 1) {
                            onQuantityChanged(item.soLuong - 1);
                          }
                        },
                      ),
                      Text(item.soLuong.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onQuantityChanged(item.soLuong + 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text("${item.Gia} VNĐ", style: TextStyle(color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}

class TotalPriceCard extends StatelessWidget {
  final List<chiTietHoaDonAdmin> orderItems;

  TotalPriceCard({required this.orderItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        orderItems.fold(0, (sum, item) => sum + (item.Gia * item.soLuong));

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tổng tiền:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("$totalPrice VNĐ", style: TextStyle(color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}

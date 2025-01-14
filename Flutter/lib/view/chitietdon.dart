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
  final List<OrderItem> orderItems = [
    OrderItem(
      name: "Laptop ASUS TUF Gaming F15 FX507ZC4-HN095W",
      imageUrl: "images/lap13.png",
      quantity: 1,
      price: 300000,
    ),
    OrderItem(
      name: "Laptop Gaming Acer Nitro V ANV15-51-58AN",
      imageUrl: "images/lap13.png",
      quantity: 2,
      price: 450000,
    ),
  ];

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

  // Hàm cập nhật số lượng sản phẩm
  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      orderItems[index].quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    hoaDonAdmin hoaDon =
        ModalRoute.of(context)!.settings.arguments as hoaDonAdmin;

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
                title: Text("Nguyễn Văn A"),
                subtitle: Text("Số điện thoại: 0901234567"),
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
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderItems[index];
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
              StatusCard(),
              Divider(),

              // Tổng cộng
              Text(
                "Tổng cộng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TotalPriceCard(orderItems: orderItems),
              Divider(),

              // Các nút hành động
              SizedBox(height: 16),
              ElevatedButton(
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
                            onPressed: () {
                              Navigator.of(context).pop(); // Đóng dialog
                              // Thực hiện cập nhật thông tin
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Thông tin sản phẩm đã được cập nhật!")),
                              );
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem {
  final String name;
  final String imageUrl;
  int quantity; // quantity cần là int để có thể thay đổi
  final int price;

  OrderItem({
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

class OrderItemCard extends StatelessWidget {
  final OrderItem item;
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
            Image.asset(
              item.imageUrl,
              width: 100,
              height: 100,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Số lượng: ${item.quantity}"),
                  SizedBox(height: 8),
                  // Các nút điều chỉnh số lượng
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (item.quantity > 1) {
                            onQuantityChanged(item.quantity - 1);
                          }
                        },
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onQuantityChanged(item.quantity + 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text("${item.price * item.quantity} VNĐ",
                style: TextStyle(color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.orange),
                SizedBox(width: 8),
                Text("Đang giao hàng", style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TotalPriceCard extends StatelessWidget {
  final List<OrderItem> orderItems;

  TotalPriceCard({required this.orderItems});

  @override
  Widget build(BuildContext context) {
    int totalPrice =
        orderItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

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

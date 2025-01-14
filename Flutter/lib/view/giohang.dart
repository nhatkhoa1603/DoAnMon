import 'package:doanmonhoc/view/thongtinmuahang.dart';
import 'package:flutter/material.dart';

class Giohang extends StatefulWidget {
  @override
  _GioHangState createState() => _GioHangState();
}

class _GioHangState extends State<Giohang> {
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "MacBook Pro 14 inch",
      "price": 45990000,
      "quantity": 1,
      "isChecked": false,
      "image": "images/lap1.png",
      "specs": "M2 Pro, 16GB RAM, 512GB SSD"
    },
    {
      "name": "ROG Strix G15",
      "price": 32990000,
      "quantity": 1,
      "isChecked": true,
      "image": "images/lap1.png",
      "specs": "RTX 4060, i7-13700H, 16GB"
    },
  ];

  void updateQuantity(int index, bool increase) {
    setState(() {
      if (increase) {
        cartItems[index]['quantity']++;
      } else if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void toggleCheckBox(int index) {
    setState(() {
      cartItems[index]['isChecked'] = !cartItems[index]['isChecked'];
    });
  }

  double calculateTotal() {
    return cartItems
        .where((item) => item['isChecked'])
        .fold(0.0, (sum, item) => sum + item['price'] * item['quantity']);
  }

  void xacNhanXoa(BuildContext context, int index) {
    final productName = cartItems[index]['name'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: Text('Bạn có muốn xóa sản phẩm "$productName" không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                removeItem(index); // Xóa sản phẩm
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        title: Text(
          'Giỏ hàng',
          //style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),
        //centerTitle: true,
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              // Xử lý xóa tất cả
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Xác nhận'),
                        content: Text('Bạn có muốn xóa tất cả sản phẩm?'),
                        actions: [
                          TextButton(
                            child: Text('Hủy'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text('Xóa tất cả',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              setState(() {
                                cartItems.clear();
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
            },
            child: Text('Xóa tất cả', style: TextStyle(color: Colors.red)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checkbox
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: item['isChecked'],
                                onChanged: (value) => toggleCheckBox(index),
                                activeColor: Colors.blue,
                              ),
                            ),
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item['image'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            // Product details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    item['specs'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${item['price'].toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]},')}đ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Quantity controls
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () => updateQuantity(index, false),
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${item['quantity']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  onPressed: () => updateQuantity(index, true),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            // Delete button
                            IconButton(
                              icon:
                                  Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => xacNhanXoa(context, index),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Bottom bar
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tổng thanh toán:',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${calculateTotal().toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]},')}đ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/thongtinmuahang');
                    //  // Navigator.pop(context,'/thongtinmuahang');
                    //   },
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => thong_tin_mua_hang()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Mua hàng (${cartItems.where((item) => item['isChecked']).length})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

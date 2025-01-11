import 'package:flutter/material.dart';

class Giohang extends StatefulWidget{
  @override
  _gioHang createState()=> _gioHang();
}

class _gioHang extends State<Giohang>{
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Sản phẩm 1",
      "price": 100000,
      "quantity": 1,
      "isChecked": false,
      "image": "assets/images/lap1.png"
    },
    {
      "name": "Sản phẩm 2",
      "price": 200000,
      "quantity": 2,
      "isChecked": true,
      "image": "assets/images/lap12.png"
    },
    {
      "name": "Sản phẩm 3",
      "price": 150000,
      "quantity": 1,
      "isChecked": false,
      "image": "assets/images/lap13.png"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng', style: TextStyle(color: Colors.white, fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(
                      item['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item['price']} đ'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => updateQuantity(index, false),
                            ),
                            Text('${item['quantity']}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => updateQuantity(index, true),
                            ),
                          ],
                        )
                      ],
                    ),
                   trailing: Row(
                    mainAxisSize: MainAxisSize.min, // Đảm bảo chiều rộng không bị chiếm toàn bộ
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          xacNhanXoa(context, index);
                        },
                      ),
                      Checkbox(
                        value: item['isChecked'],
                        onChanged: (value) {
                          toggleCheckBox(index);
                        },
                      ),
                    ],
                  ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, -1),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng: ${calculateTotal().toStringAsFixed(0)} đ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý thanh toán
                  },
                  child: const Text('Đặt hàng', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
}



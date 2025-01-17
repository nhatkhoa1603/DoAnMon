import 'package:flutter/material.dart';
import 'SanPham.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Sanpham sanpham) {
    _cartItems.add({
      "name": sanpham.tenSanPham,
      "price": sanpham.giaXuat,
      "quantity": 1,
      "isChecked": false,
      "image": sanpham.hinhAnh,
      "specs": "Ram: ${sanpham.Ram}, CPU: ${sanpham.CPU}",
    });
    notifyListeners();
  }

  void updateQuantity(int index, bool increase) {
    if (increase) {
      _cartItems[index]['quantity']++;
    } else if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  double calculateTotal() {
    if (_cartItems.isEmpty) {
      print("Giỏ hàng trống khi tính tổng tiền");
      return 0.0;
    }
    double total = 0.0;
    for (var item in _cartItems) {
      if (item['isChecked']) {
        total += item['price'] * item['quantity'];
      }
    }
    return total;
  }

  // Cập nhật giỏ hàng khi đăng nhập
  void setCartItems(List<Map<String, dynamic>> items) {
    _cartItems = items;
    notifyListeners();
  }
}

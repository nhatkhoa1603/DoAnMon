import 'dart:convert';
import 'package:doanmonhoc/model/gioHang.dart';
import 'package:doanmonhoc/model/thongTinCaNhan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class thong_tin_mua_hang extends StatefulWidget {
  @override
  _thong_tin_mua_hang createState() => _thong_tin_mua_hang();
}

class _thong_tin_mua_hang extends State<thong_tin_mua_hang> {
  List<Giohang_model> gioHangs = [];
  bool isLoading = false;
  late thongTinCaNhan user;
  @override
  void initState() {
    super.initState();
    fetchDSGioHang();
    _fetchUserInfo();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<String?> _getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> fetchDSGioHang() async {
    setState(() {
      isLoading = true;
    });

    String? userId = await _getuserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng đăng nhập lại!')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url =
        Uri.parse("https://10.0.2.2:7042/gioHang/danhSachChiTiet/$userId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          gioHangs =
              data.map((value) => Giohang_model.fromJson(value)).toList();
        });
      } else {
        _showErrorSnackBar(
            'Không thể tải thông tin giỏ hàng. Mã lỗi: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackBar('Có lỗi xảy ra khi tải thông tin giỏ hàng.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUserInfo() async {
    String? userId = await _getuserId();
    if (userId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng đăng nhập lại!')),
        );
      }

      return;
    }
    final response =
        await http.get(Uri.parse("https://10.0.2.2:7042/khachHang/$userId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        user = thongTinCaNhan.fromJson(data);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Không thể tải thông tin người dùng'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _datHang(int tongTien) async {
    String? userIdString = await _getuserId();

    if (userIdString == null) {
      _showErrorSnackBar("Vui lòng đăng nhập để đặt hàng.");
      return;
    }

    // Chuyển đổi userId từ String sang int
    int? userId = int.tryParse(userIdString);

    if (userId == null) {
      _showErrorSnackBar("Mã người dùng không hợp lệ.");
      return;
    }
    if (userId % 1 == 0) {
      print("kieu int");
    }
    final hoaDonResponse = await http.post(
      Uri.parse("https://10.0.2.2:7042/hoaDon/Them"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"maKhachHang": userId, "tongTien": tongTien}),
    );

    if (hoaDonResponse.statusCode == 200) {
      final hoaDonData = jsonDecode(hoaDonResponse.body);
      int maHoaDon = hoaDonData['data']['maDonHang'];

      for (var gioHang in gioHangs) {
        final chiTietResponse = await http.post(
          Uri.parse("https://10.0.2.2:7042/chiTietHoaDon/Them"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "maHoaDon": maHoaDon,
            "maSanPham": gioHang.maSanPham,
            "soLuong": gioHang.soLuong,
            "giaBan": gioHang.Gia,
          }),
        );

        if (chiTietResponse.statusCode != 200) {
          _showErrorSnackBar(
              "Lỗi khi tạo chi tiết hóa đơn cho sản phẩm: ${gioHang.tensanPham}");
          return;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đặt hàng thành công!")),
      );
    } else {
      _showErrorSnackBar("Lỗi khi tạo hóa đơn. Vui lòng thử lại.");
    }
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      gioHangs[index].soLuong = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn hàng",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child:
                    isLoading || gioHangs.isEmpty || user.tenKhachHang.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Thông tin người mua",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://static.vecteezy.com/system/resources/previews/014/194/215/original/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg'),
                                ),
                                title: Text(user.tenKhachHang),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.soDienThoai),
                                    Text("${user.diaChi}")
                                  ],
                                ),
                              ),
                              Divider(),
                              Text(
                                "Thông tin đơn hàng",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: gioHangs.length,
                                itemBuilder: (context, index) {
                                  final item = gioHangs[index];
                                  return OrderItemCard(
                                      item: item,
                                      onQuantityChanged: (newQuantity) {
                                        _updateQuantity(index, newQuantity);
                                      });
                                },
                              ),
                            ],
                          ),
              ),
            ),
          ),
          TotalPriceCard(orderItems: gioHangs),
        ],
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final Giohang_model item;
  final Function(int) onQuantityChanged;
  OrderItemCard({
    required this.item,
    required this.onQuantityChanged,
  });

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
                  Text(item.tensanPham,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Số lượng: ${item.soLuong}"),
                  SizedBox(height: 8),
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
  final List<Giohang_model> orderItems;

  TotalPriceCard({required this.orderItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        orderItems.fold(0, (sum, item) => sum + (item.Gia * item.soLuong));

    return Container(
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
                    '$totalPrice VNĐ',
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
              onPressed: () async {
                // Gọi phương thức _datHang từ StatefulWidget
                final state =
                    context.findAncestorStateOfType<_thong_tin_mua_hang>();
                if (state != null) {
                  await state._datHang(
                      totalPrice.toInt()); // Gọi hàm _datHang từ StatefulWidget
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Đặt hàng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

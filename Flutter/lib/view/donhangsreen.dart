import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/hoaDon.dart';

class DonHangScreen extends StatefulWidget {
  @override
  _DonHangScreenState createState() => _DonHangScreenState();
}

class _DonHangScreenState extends State<DonHangScreen> {
  List<Hoadon> dsHoaDon = [];
  String _selectedStatus = 'Tất cả';
  bool isLoading = false;

  Future<String?> _getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> fetchDSDon() async {
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
        Uri.parse("https://10.0.2.2:7042/hoaDonKhachHang/danhSach/$userId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          dsHoaDon = data.map((value) => Hoadon.fromJson(value)).toList();
        });
      } else {
        _showErrorSnackBar(
            'Không thể tải thông tin người dùng. Mã lỗi: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackBar('Có lỗi xảy ra khi tải thông tin người dùng.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Hoadon> getFilteredOrders() {
    if (_selectedStatus == 'Tất cả') {
      return dsHoaDon;
    }
    return dsHoaDon.where((order) {
      String statusText;
      switch (order.trangThai) {
        case 0:
          statusText = 'Đã hủy';
          break;
        case 2:
          statusText = 'Đang giao';
          break;
        case 3:
          statusText = 'Đã giao';
          break;
        default:
          statusText = 'Chờ xác nhận';
      }
      return statusText == _selectedStatus;
    }).toList();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> huyDon(int maDonHang) async {
    String? userId = await _getuserId();
    if (userId == null) {
      _showErrorSnackBar('Vui lòng đăng nhập lại!');
      return;
    }

    final url = Uri.parse("https://10.0.2.2:7042/hoaDon/huyDon/$maDonHang");
    final response = await http.put(url, body: {'userId': userId});

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hủy đơn thành công')),
      );
      setState(() {
        dsHoaDon.removeWhere((order) => order.maDonHang == maDonHang);
      });
    } else {
      _showErrorSnackBar('Không thể hủy đơn. Mã lỗi: ${response.statusCode}');
    }
  }

  void _showOrderDetail(Hoadon order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mã hóa đơn: ${order.maDonHang}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(),
              Text(
                'Ngày đặt: ${order.ngayDatHang}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Trạng thái: ${order.trangThai == 3 ? "Đã giao" : order.trangThai == 0 ? "Đã hủy" : order.trangThai == 2 ? "Đang giao" : "Chờ xác nhận"}',
                style: TextStyle(
                  fontSize: 16,
                  color: order.trangThai == 3
                      ? Colors.greenAccent
                      : order.trangThai == 0
                          ? Colors.red
                          : order.trangThai == 2
                              ? Colors.lightBlue
                              : Colors.orange,
                ),
              ),
              SizedBox(height: 16),
              if (order.trangThai == 1)
                ElevatedButton(
                  onPressed: () => huyDon(order.maDonHang),
                  child: Text('Hủy Đơn'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDSDon();
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = getFilteredOrders();

    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng của tôi'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: [
                'Tất cả',
                'Chờ xác nhận',
                'Đang giao',
                'Đã giao',
                'Đã hủy'
              ].length,
              itemBuilder: (context, index) {
                final status = [
                  'Tất cả',
                  'Chờ xác nhận',
                  'Đang giao',
                  'Đã giao',
                  'Đã hủy'
                ][index];
                final isSelected = status == _selectedStatus;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(status),
                    onSelected: (selected) {
                      setState(() {
                        _selectedStatus = status;
                      });
                    },
                    backgroundColor:
                        isSelected ? Colors.blue : Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Text('Không có đơn hàng nào'),
                  )
                : ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return InkWell(
                        onTap: () => _showOrderDetail(order),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Đơn hàng ${order.maDonHang}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${order.trangThai == 3 ? "Hoàn thành" : order.trangThai == 0 ? "Đã hủy" : order.trangThai == 2 ? "Đang giao" : "Chờ xác nhận"}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: order.trangThai == 3
                                            ? Colors.greenAccent
                                            : order.trangThai == 0
                                                ? Colors.red
                                                : order.trangThai == 2
                                                    ? Colors.lightBlue
                                                    : Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

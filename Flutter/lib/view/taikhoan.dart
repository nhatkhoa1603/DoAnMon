//import 'package:doanmonhoc/LoginSignin/login.dart';
import 'package:doanmonhoc/view/danhmuc.dart';
import 'package:doanmonhoc/view/donhangsreen.dart';
import 'package:doanmonhoc/view/login.dart';
import 'package:doanmonhoc/view/setting.dart';
import 'package:doanmonhoc/view/thongtincanhan.dart';
import '../view/thongtincanhan_real.dart';
import 'package:doanmonhoc/view/trangchu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/thongTinCaNhan.dart';

//import '../setting/setting.dart';

class TaiKhoan extends StatefulWidget {
  @override
  _TaiKhoanState createState() => _TaiKhoanState();
}

class _TaiKhoanState extends State<TaiKhoan> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _thongTinCaNhan();
  }


  Future<void> _thongTinCaNhan() async {
    final response = await http.get(Uri.parse("https://localhost:7042/khachHang/5"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        final user = thongTinCaNhan.fromJson(data);
        _nameController.text = user.tenKhachHang;
        _phoneController.text = user.soDienThoai;
        _emailController.text = user.email;
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

  int _selectedIndex = 2;
  final Map<String, dynamic> userData = {
    'avatar': 'images/NK.png',
    'membershipLevel': 'Thành viên Vàng',
    'points': 2500,
  };

  final List<Map<String, dynamic>> orderStats = [
    {
      'icon': Icons.pending_actions,
      'title': 'Chờ xác nhận',
      'count': 2,
    },
    {
      'icon': Icons.local_shipping,
      'title': 'Đang giao',
      'count': 1,
    },
    {
      'icon': Icons.rate_review,
      'title': 'Chờ đánh giá',
      'count': 3,
    },
    {
      'icon': Icons.assignment_return,
      'title': 'Trả hàng',
      'count': 0,
    },
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Đơn hàng của tôi',
      'icon': Icons.receipt_long,
      'color': Colors.blue[100],
    },
    {
      'title': 'Sản phẩm yêu thích',
      'icon': Icons.favorite,
      'color': Colors.red[100],
    },
    {
      'title': 'Sản phẩm đã xem',
      'icon': Icons.remove_red_eye,
      'color': Colors.purple[100],
    },
    {
      'title': 'Địa chỉ của tôi',
      'icon': Icons.location_on,
      'color': Colors.green[100],
    },
    {
      'title': 'Thông tin thanh toán',
      'icon': Icons.payment,
      'color': Colors.orange[100],
    },
    {
      'title': 'Mã giảm giá',
      'icon': Icons.local_offer,
      'color': Colors.yellow[100],
    },
    {
      'title': 'Thông báo',
      'icon': Icons.notifications,
      'color': Colors.teal[100],
    },
    {
      'title': 'Cài đặt',
      'icon': Icons.settings,
      'color': Colors.grey[300],
    },
  ];

  void _handleNavigation(String screen, [Map<String, dynamic>? data]) {
    if (screen == 'Cài đặt') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CaiDat()),
      );
    } else if (screen == 'Đơn hàng của tôi') {
      // Chuyển đến màn hình DonHangScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DonHangScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đang chuyển đến: $screen'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Widget _buildUserHeader() {
  return InkWell(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => tTinCaNhan()),
    ),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalInfoScreen()),  // Chuyển đến màn hình Thông tin cá nhân
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(userData['avatar']),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonalInfoScreen()),  // Chuyển đến màn hình Thông tin cá nhân
                      ),
                      child: Text(
                        _nameController.text,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                     _emailController.text,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    InkWell(
                      onTap: () => _handleNavigation('Thông tin thành viên'),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 4),
                          Text(
                            userData['membershipLevel'],
                            style: TextStyle(
                              color: Colors.amber[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalInfoScreen()),  // Chuyển đến màn hình Thông tin cá nhân
                    );
                  }),
            ],
          ),
          SizedBox(height: 16),
          InkWell(
            onTap: () => _handleNavigation('Điểm tích lũy'),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Điểm tích lũy',
                        style: TextStyle(
                          color: Colors.amber[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${userData['points']} điểm',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[700],
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => _handleNavigation('Lịch sử điểm'),
                    child: Text('Xem lịch sử'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildOrderStats() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đơn hàng của tôi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => _handleNavigation('Tất cả đơn hàng'),
                  child: Text('Xem tất cả'),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: orderStats.map((stat) {
              return InkWell(
                onTap: () => _handleNavigation('Đơn hàng', stat),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Icon(
                          stat['icon'],
                          size: 28,
                          color: Colors.blue,
                        ),
                        if (stat['count'] > 0)
                          Positioned(
                            right: -8,
                            top: -8,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${stat['count']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      stat['title'],
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tiện ích',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Kiểm tra nếu là "Đơn hàng của tôi"
                  if (menuItems[index]['title'] == 'Đơn hàng của tôi') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DonHangScreen()),
                    );
                  } else {
                    _handleNavigation(menuItems[index]['title']);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: menuItems[index]['color'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        menuItems[index]['icon'],
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      menuItems[index]['title'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TrangChu()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DanhMuc()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Tài khoản',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.receipt_long),
            color: Colors.black87,
            onPressed: () {
              Navigator.pushNamed(context, "/danhsachdon");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserHeader(),
            SizedBox(height: 8),
            _buildOrderStats(),
            SizedBox(height: 8),
            _buildMenuGrid(),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginApp(),
                    ),
                  );
                },
                child: Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Danh mục'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }
}

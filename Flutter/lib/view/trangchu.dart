import 'dart:async';
import 'dart:convert';
import 'package:doanmonhoc/model/SanPham.dart';
//import 'package:doanmonhoc/view/chitietsp.dart';
import 'package:doanmonhoc/view/giohang.dart';
import 'package:doanmonhoc/view/taikhoan.dart';
import 'danhmuc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class TrangChu extends StatefulWidget {
  @override
  _TrangChuState createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  // FocusNode _searchFocusNode = FocusNode();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _searchSanPham = TextEditingController();

  List<Sanpham> sanPhams = [];

  Future<void> fetchdsSanPham() async {
    final response =
        await http.get(Uri.parse("https://10.0.2.2:7042/sanPham/danhSach"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        sanPhams = data.map((value) => Sanpham.fromJson(value)).toList();
      });
    }
  }

  //  Future<void> fetchTimSp() async {
  //   final response =
  //       await http.get(Uri.parse("https://10.0.2.2:7042/sanPham/timkiem/$_searchSanPham"));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> dataTimSp = json.decode(response.body)['data'];
  //     setState(() {
  //       sanPhams = dataTimSp.map((value) => Sanpham.fromJson(value)).toList();
  //     });
  //   }
  // }

  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;
  int _selectedIndex = 0;

  final List<Map<String, String>> banners = [
    {
      'image': 'images/a1.png',
      'title': 'MacBook Pro M2',
      'description': 'Hiệu năng vượt trội'
    },
    {
      'image': 'images/a2.png',
      'title': 'Gaming Laptop',
      'description': 'Giảm giá đến 20%'
    },
    {
      'image': 'images/a3.png',
      'title': 'Laptop Văn Phòng',
      'description': 'Khuyến mãi đặc biệt'
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.laptop_mac,
      'title': 'MacBook',
      'color': Colors.grey[200],
    },
    {
      'icon': Icons.games,
      'title': 'Gaming',
      'color': Colors.red[100],
    },
    {
      'icon': Icons.work,
      'title': 'Văn phòng',
      'color': Colors.blue[100],
    },
    {
      'icon': Icons.design_services,
      'title': 'Đồ họa',
      'color': Colors.purple[100],
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchdsSanPham();
    //fetchTimSp();
    _searchController.addListener(() {});

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // SystemChannels.textInput.invokeMethod('TextInput.show');
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DanhMuc()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaiKhoan()),
      );
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildBannerSlider() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    banners[index]['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banners[index]['title']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          banners[index]['description']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: banners.asMap().entries.map((entry) {
                return Container(
                  width: _currentPage == entry.key ? 20 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == entry.key
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh Mục Sản Phẩm',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: categories[index]['color'],
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        categories[index]['icon'],
                        size: 32,
                        color: Colors.black87,
                      ),
                      SizedBox(height: 8),
                      Text(
                        categories[index]['title'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedLaptops() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Laptop Nổi Bật',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Xem tất cả'),
              ),
            ],
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: sanPhams.length,
            itemBuilder: (context, index) {
              final laptop = sanPhams[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/chitietsanpham',
                    arguments: laptop
                        .maSanPham, //truyền cái mã sản phẩm sang chi tiết sp screen
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          child: Image.network(
                            laptop.hinhAnh,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${laptop.tenSanPham}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Ram: ${laptop.Ram}\nCPU: ${laptop.CPU}",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${laptop.giaXuat} đ",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                        ),
                        child: Text(
                          'Mua ngay',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            child: TextField(
              controller: _searchSanPham,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm laptop...',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0), // Điều chỉnh khoảng cách vào bên trong
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black87,
            // onPressed: () {
            //   fetchTimSp();
            // },
            onPressed: () {
              if (_searchSanPham.text.isNotEmpty)
                Navigator.pushNamed(context, '/timkiem',
                    arguments: _searchSanPham.text);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.black87,
            onPressed: () {
              // Chuyển sang màn hình giỏ hàng
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Giohang()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildBannerSlider(),
          _buildCategoryGrid(),
          _buildFeaturedLaptops(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}

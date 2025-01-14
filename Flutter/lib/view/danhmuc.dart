import 'package:flutter/material.dart';
import 'package:doanmonhoc/view/taikhoan.dart';
import 'package:doanmonhoc/view/trangchu.dart';

class DanhMuc extends StatefulWidget {
  @override
  _DanhMucState createState() => _DanhMucState();
}

class _DanhMucState extends State<DanhMuc> {
  int _selectedIndex = 1;

  final List<Map<String, dynamic>> brands = [
    {'name': 'MacBook', 'image': 'images/brands/macbook.png'},
    {'name': 'ASUS', 'image': 'images/brands/asus.png'},
    {'name': 'Lenovo', 'image': 'images/brands/lenovo.png'},
    {'name': 'Dell', 'image': 'images/brands/dell.png'},
    {'name': 'Acer', 'image': 'images/brands/acer.png'},
    {'name': 'LG', 'image': 'images/brands/Lg.png'},
    {'name': 'HP', 'image': 'images/brands/hp.png'},
    {'name': 'MSI', 'image': 'images/brands/msi.png'},
  ];

  final List<Map<String, String>> priceRanges = [
    {'title': 'Dưới 10 triệu', 'range': '<10000000'},
    {'title': 'Từ 10-15 triệu', 'range': '10000000-15000000'},
    {'title': 'Từ 15-25 triệu', 'range': '15000000-25000000'},
    {'title': 'Từ 25-35 triệu', 'range': '25000000-35000000'},
  ];

  final List<Map<String, String>> screenSizes = [
    {'title': '13 inch', 'size': '13'},
    {'title': '14 inch', 'size': '14'},
    {'title': '15.6 inch', 'size': '15.6'},
    {'title': '16 inch', 'size': '16'},
    {'title': '17 inch', 'size': '17'},
  ];

  final List<Map<String, dynamic>> usageCategories = [
    {
      'title': 'Văn phòng',
      'image': 'images/categories/office.png',
      'icon': Icons.business,
      'color': Color(0xFFE3F2FD),
    },
    {
      'title': 'Gaming',
      'image': 'images/categories/gaming.png',
      'icon': Icons.sports_esports,
      'color': Color(0xFFFCE4EC),
    },
    {
      'title': 'Mỏng nhẹ',
      'image': 'images/categories/slim.png',
      'icon': Icons.laptop_mac,
      'color': Color(0xFFF3E5F5),
    },
  ];

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  void _handleCategoryTap(String categoryType, dynamic categoryData) {
    // You can navigate to a new screen or filter results based on the selected category
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Đã chọn ${categoryData['title'] ?? categoryData['name']}'),
        duration: Duration(seconds: 1),
      ),
    );
    // Add your navigation or filtering logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              hintText: 'Bạn cần tìm...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Thương hiệu'),
            _buildBrandsGrid(),
            _buildSectionHeader('Phân khúc giá'),
            _buildPriceRanges(),
            _buildSectionHeader('Kích thước màn hình'),
            _buildScreenSizes(),
            _buildSectionHeader('Nhu cầu sử dụng'),
            _buildUsageCategories(),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Danh mục'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Tài khoản'),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenSizes() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: screenSizes.map((size) {
          return InkWell(
            onTap: () => _handleCategoryTap('screen_size', size),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                size['title']!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBrandsGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => _handleCategoryTap('brand', brands[index]),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    brands[index]['image'],
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(height: 8),
                  Text(
                    brands[index]['name'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRanges() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: priceRanges.map((range) {
          return InkWell(
            onTap: () => _handleCategoryTap('price_range', range),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                range['title']!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUsageCategories() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 24) / 3;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: usageCategories.map((category) {
              return InkWell(
                onTap: () => _handleCategoryTap('usage', category),
                child: Container(
                  width: itemWidth,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: category['color'],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category['icon'],
                        size: 28,
                        color: Colors.black87,
                      ),
                      SizedBox(height: 8),
                      Text(
                        category['title'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
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
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TaiKhoan()),
        );
      }
    }
  }
}

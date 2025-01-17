import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:doanmonhoc/model/SanPham.dart';
import 'package:doanmonhoc/view/trangchu.dart';
import 'package:doanmonhoc/view/taikhoan.dart';

class DanhMuc extends StatefulWidget {
  @override
  _DanhMucState createState() => _DanhMucState();
}

class _DanhMucState extends State<DanhMuc> {
  int _selectedIndex = 1;
  int? selectedBrandId; //theo doi thương hiệu đã chọn

  List<Map<String, dynamic>> brands = [
    {'icon': Icons.laptop_mac, 'name': 'Asus', 'id': 1},
    {'icon': Icons.computer, 'name': 'Lenovo', 'id': 2},
    {'icon': Icons.laptop_chromebook, 'name': 'Apple', 'id': 3},
    {'icon': Icons.devices, 'name': 'Dell', 'id': 4},
    {'icon': Icons.apple, 'name': 'Acer', 'id': 5},
    {'icon': Icons.laptop_chromebook, 'name': 'LG', 'id': 6},
    {'icon': Icons.devices, 'name': 'HP', 'id': 7},
    {'icon': Icons.computer, 'name': 'MSI', 'id': 8},
  ];

  List<Sanpham> allSanPhams = [];
  List<Sanpham> filteredSanPhams = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchdsSanPham();
  }

  Future<void> fetchdsSanPham() async {
    try {
      final response =
          await http.get(Uri.parse("https://10.0.2.2:7042/sanPham/danhSach"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          allSanPhams = data.map((value) => Sanpham.fromJson(value)).toList();
          filteredSanPhams = allSanPhams;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching products: $e');
    }
  }

  void filterProductsByBrand(int brandId) {
    setState(() {
      if (selectedBrandId == brandId) {
        selectedBrandId = null;
        filteredSanPhams = allSanPhams;
      } else {
        selectedBrandId = brandId;
        filteredSanPhams = allSanPhams
            .where((product) => product.maThuongHieu == brandId)
            .toList();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrangChu()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaiKhoan()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Mục Sản Phẩm'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Thương hiệu nổi bật',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              final isSelected = selectedBrandId == brand['id'];
              return GestureDetector(
                onTap: () => filterProductsByBrand(brand['id']),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        brand['icon'],
                        size: 32,
                        color: isSelected ? Colors.white : null,
                      ),
                      radius: 30,
                      backgroundColor: isSelected ? Colors.blue : null,
                    ),
                    SizedBox(height: 8),
                    Text(
                      brand['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.blue : null,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh Sách Sản Phẩm',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (selectedBrandId != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedBrandId = null;
                        filteredSanPhams = allSanPhams;
                      });
                    },
                    child: Text('Xem tất cả'),
                  ),
              ],
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: filteredSanPhams.length,
                  itemBuilder: (context, index) {
                    final product = filteredSanPhams[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/chitietsanpham',
                          arguments: product.maSanPham,
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                child: Image.network(
                                  product.hinhAnh,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${product.tenSanPham}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Ram: ${product.Ram}\nCPU: ${product.CPU}",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                        height: 1.3,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${product.giaXuat} đ",
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

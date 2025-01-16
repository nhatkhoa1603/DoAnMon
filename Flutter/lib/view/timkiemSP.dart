import 'dart:async';
import 'dart:convert';
import 'package:doanmonhoc/model/SanPham.dart';
//import 'package:doanmonhoc/view/giohang.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class Timkiemsp extends StatefulWidget {
  @override
  _Timkiemsp createState() => _Timkiemsp();
}

class _Timkiemsp extends State<Timkiemsp> {
  TextEditingController _searchController = TextEditingController();
 // TextEditingController _searchSanPham = TextEditingController();

  
  // Future<void> fetchdsSanPham() async {
  //   final response =
  //       await http.get(Uri.parse("https://10.0.2.2:7042/sanPham/danhSach"));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body)['data'];
  //     setState(() {
  //       sanPhams = data.map((value) => Sanpham.fromJson(value)).toList();
  //     });
  //   }
  // }
   String key ="";
  Future< List<Sanpham>> fetchTimSp() async {
    final response =
        await http.get(Uri.parse("https://10.0.2.2:7042/sanPham/timkiem/Ten?name=$key"));
    if (response.statusCode == 200) {
      final List<dynamic> dataTimSp = json.decode(response.body)['data'];
        List<Sanpham> sanPhams = [];

        sanPhams = dataTimSp.map((value) => Sanpham.fromJson(value)).toList();
        return sanPhams;
    }else{
      throw Exception("Không có sản phẩm nào");
    }
  }

  @override
  void initState() {
    super.initState();
fetchTimSp();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
        key = ModalRoute.of(context)?.settings.arguments as String;//hứng chuỗi tim kiếm bên màng hình trang chủ

  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                ' Danh sách tìm kiếm ',
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
          FutureBuilder(future: fetchTimSp(), builder: (context, snapshot) {
            if(snapshot.hasData){
              return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: snapshot.data!.length, 
            itemBuilder: (context, index) {
              final laptop = snapshot.data![index]; 
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/chitietsanpham',
                    arguments: laptop.maSanPham,
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
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
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
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                    ],
                  ),
                ),
              );
            },
          );
            }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }else{
          return const Center(child: CircularProgressIndicator());
        }
          },
          )
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        title: Text('Sản phẩm'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     color: Colors.black87,
        //     onPressed: () {
        //       fetchTimSp();
        //     },
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     color: Colors.black87,
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => Giohang()),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: ListView(
        children: [
          _buildFeaturedLaptops(),
        ],
      ),
    );
  }
}

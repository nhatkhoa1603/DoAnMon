import 'dart:convert';

import 'package:doanmonhoc/model/SanPham.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chitietsp extends StatefulWidget {
  @override
  _chiTietSP createState() => _chiTietSP();
}

class _chiTietSP extends State<Chitietsp> {
  int masp=0; 
  Future< Sanpham> fetchChitietSP() async {
    final response =
        await http.get(Uri.parse("https://10.0.2.2:7042/sanPham/chiTietSanPham/$masp"));
    if (response.statusCode == 200) {
      final List<dynamic> dataTimSp = json.decode(response.body);
        List<Sanpham> sanPhams = [];

        sanPhams = dataTimSp.map((value) => Sanpham.fromJson(value)).toList();
        return sanPhams[0];
    }else{
      throw Exception("Không có chi tiết sản phẩm ");
    }
  }
  @override
  void initState() {
    super.initState();
fetchChitietSP();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
        masp = ModalRoute.of(context)?.settings.arguments as int;//hứng chuỗi tim kiếm bên màng hình trang chủ

  }

  
  @override
  Widget build(BuildContext context) {
    // Lấy đối tượng sản phẩm từ ModalRoute
   // final Sanpham sanpham = ModalRoute.of(context)!.settings.arguments as Sanpham;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết sản phẩm',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2196F3),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: FutureBuilder(future: fetchChitietSP(), builder: (context, snapshot) {
              if(snapshot.hasData){
                return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  snapshot.data!.hinhAnh, // Sử dụng hình ảnh từ đối tượng
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 350,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.tenSanPham, // Hiển thị tên sản phẩm
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                     // SizedBox(height: 10),
                      Row(
                        children: [
                         // SizedBox(width: 5),
                          Text(
                            "Ram: ${snapshot.data!.Ram}\nCPU: ${snapshot.data!.CPU}",
                            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${snapshot.data!.giaXuat} ₫', // Sử dụng giá xuất từ đối tượng
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Đặc điểm nổi bật',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          snapshot.data!.moTa, // Sử dụng mô tả sản phẩm từ đối tượng
                          style: TextStyle(fontSize: 16),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(height: 15),
                      // Thêm các ảnh và chi tiết khác tùy thuộc vào sản phẩm
                     
                      // SizedBox(height: 15),
                      // Text(
                      //   'Thiết kế HP Pavilion 14-dv2070TU 7C0V9PA thanh lịch, sang trọng và cao cấp',
                      //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(height: 15),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 2),
                      //   child: Text(
                      //     'HP Pavilion 14-dv2070TU 7C0V9PA khoác trên mình bộ cánh...',
                      //     style: TextStyle(fontSize: 16),
                      //     softWrap: true,
                      //   ),
                      // ),
                      // SizedBox(height: 15),
                      // Thêm các thông số còn lại từ đối tượng 'Sanpham'
                      // ...
                    ],
                  ),
                ),
              ],
            );

              }else if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }else{
          return const Center(child: CircularProgressIndicator());
        }
            })
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3, // Cho button thêm vào giỏ hàng nhiều không gian hơn
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/giohang');
                      },
                      child: FittedBox( // Sử dụng FittedBox để đảm bảo text không bị xuống dòng
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Thêm vào giỏ hàng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1, // Giới hạn chỉ 1 dòng
                          overflow: TextOverflow.ellipsis, // Nếu quá dài sẽ hiển thị ...
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(0, 50),
                        padding: EdgeInsets.symmetric(horizontal: 10), // Giảm padding ngang
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Giảm khoảng cách giữa 2 button
                  Expanded(
                    flex: 2, // Button mua ngay chiếm ít không gian hơn
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/thongtinmuahang');
                      },
                      child: Text(
                        'Mua ngay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(0, 50),
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

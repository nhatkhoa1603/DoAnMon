import 'package:flutter/material.dart';

class thong_tin_mua_hang extends StatefulWidget{
  @override
  _thong_tin_mua_hang createState()=> _thong_tin_mua_hang();
}

class _thong_tin_mua_hang extends State<thong_tin_mua_hang> {
  String? gioi_tinh;
  String? hinh_thuc_nhan_hang;
  int so_luong = 1;
  final int gia = 13790000;

  int get tong_tien => so_luong * gia;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Điền thông tin mua hàng', style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/lap1.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MTXT HP Pavilion 14-dv2070TU',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Core i3 1215U/8GB/256GB SSD/Intel UHD Graphics'),
                          SizedBox(height: 8),
                          Text('${gia.toString()} đ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (so_luong > 1) so_luong--;
                        });
                      },
                      icon: Icon(Icons.remove_circle_outline),
                    ),
                    Text('$so_luong'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          so_luong++;
                        });
                      },
                      icon: Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                Divider(height: 32),

                // Recipient Information
                Text(
                  'THÔNG TIN NGƯỜI NHẬN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Anh',
                      groupValue: gioi_tinh,
                      onChanged: (value) {
                        setState(() {
                          gioi_tinh = value;
                        });
                      },
                    ),
                    Text('Anh'),
                    SizedBox(width: 20,),
                    Radio<String>(
                      value: 'Chị',
                      groupValue: gioi_tinh,
                      onChanged: (value) {
                        setState(() {
                          gioi_tinh = value;
                        });
                      },
                    ),
                    Text('Chị'),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Họ và tên người nhận'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Số điện thoại'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 16),

                // Delivery Method
                Text(
                  'HÌNH THỨC NHẬN HÀNG',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Giao hàng tận nơi',
                      groupValue: hinh_thuc_nhan_hang,
                      onChanged: (value) {
                        setState(() {
                          hinh_thuc_nhan_hang = value;
                        });
                      },
                    ),
                    Text('Giao hàng tận nơi'),
                    SizedBox(width: 20,),
                    Radio<String>(
                      value: 'Nhận hàng tại cửa hàng',
                      groupValue: hinh_thuc_nhan_hang,
                      onChanged: (value) {
                        setState(() {
                          hinh_thuc_nhan_hang = value;
                        });
                      },
                    ),
                    Text('Nhận hàng tại cửa hàng'),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Địa chỉ'),
                ),
                // CheckboxListTile(
                //   value: false,
                //   onChanged: (value) {},
                //   title: Text('Yêu cầu hóa đơn VAT'),
                // ),
                SizedBox(height: 16),

                // Payment Method
                Text(
                  'PHƯƠNG THỨC THANH TOÁN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Text('Thanh toán online', style: TextStyle(color: Colors.white, fontSize: 12),),
                        ),                       
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          minimumSize: Size(150, 50)
                        )
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Chuyển khoản ngân hàng', style: TextStyle(color: Colors.white, fontSize: 12),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          minimumSize: Size(150, 50)
                        )
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Thanh toán khi nhận hàng', style: TextStyle(color: Colors.white, fontSize: 12),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          minimumSize: Size(150, 50)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Total and Confirm Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền: ${tong_tien.toString()} đ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('THANH TOÁN',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        minimumSize: Size(200, 50)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
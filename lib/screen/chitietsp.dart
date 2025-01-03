import 'package:flutter/material.dart';

class Chitietsp extends StatefulWidget {
  @override
  _chiTietSP createState() => _chiTietSP();
}

class _chiTietSP extends State<Chitietsp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Bọc toàn bộ nội dung trong SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/lap1.png',
                  fit: BoxFit.cover, // Thu phóng hình ảnh sao cho container được bao phủ hoàn toàn.
                  width: double.infinity, // Đảm bảo ảnh phủ rộng toàn bộ
                  height: 350, // Đặt chiều cao cụ thể cho ảnh
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'MTXT HP Pavilion 14-dv2070TU 7C0V9PA (Core i3 1215U/ 8GB/ 256GB SSD/ Intel UHD Graphics/ 14.0inch Full HD/ Windows 11 Home/ Silver)',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '47/15, LY THUC MAN, Quan 7, TP.HCM',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '13.790.000 ₫',
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
                      'HP Pavilion 14-dv2070TU 7C0V9PA sở hữu thiết kế cuốn hút, sang trọng và tinh tế thu hút người dùng từ cái nhìn đầu tiên. Bên cạnh thiết kế đẹp, Pavilion 14-dv2070TU 7C0V9PA còn đem đến hiệu năng mạnh mẽ đáp ứng tốt mọi nhu cầu từ xem phim, lướt web đến làm việc văn phòng và chơi các tựa game nhẹ nhàng.',
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 15), // Thêm khoảng cách giữa text và hình ảnh
                  Image.asset(
                    'images/lap12.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 380,
                  ),
                  SizedBox(height: 15), // Khoảng cách sau hình ảnh
                  Text(
                    'Thiết kế HP Pavilion 14-dv2070TU 7C0V9PA thanh lịch, sang trọng và cao cấp',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      'HP Pavilion 14-dv2070TU 7C0V9PA khoác trên mình bộ cánh khiến nhiều đối thủ cùng phân khúc phải thèm thuồng. Máy được hoàn thiện từ hợp kim nhôm nguyên khối, kết hợp màu bạc - Silver đem đến vẻ đẹp vừa thanh lịch vừa sang trọng. Pavilion 14-dv2070TU 7C0V9PA chỉ nặng 1,4 kg và có kích thước 32.5 x 21.66 x 1.7 cm khá nhỏ gọn giúp người dùng có thể đem theo mọi lúc mọi nơi, đi học, đi làm đều rất thuận tiện.',
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 15), // Thêm khoảng cách giữa text và hình ảnh
                  Image.asset(
                    'images/lap1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 380,
                  ),
                  SizedBox(height: 15), // Khoảng cách sau hình ảnh
                  Text(
                    'Màn hình 14 inch sắc nét',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      'HP Pavilion 14-dv2070TU 7C0V9PA có kích thước nhỏ gọn nên màn hình không quá lớn chỉ 14 inch. Tuy nhiên, HP đã tối ưu 2 bạnh viền bên khá mỏng đem đến không gian trải nghiệm rộng rãi cho người dùng. Chưa hết, máy sử dụng tấm nền IPS, độ phân giải full HD+ và được tích hợp công nghệ BrightView cho chất lượng hình ảnh vừa chân thực, vừa sống động, độ tương phản cao. Mọi chi tiết được tái hiện lại một cách sắc nét giúp người dùng đắm chìm trong không gian giải trí.',
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 15), // Thêm khoảng cách giữa text và hình ảnh
                  Image.asset(
                    'images/lap13.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 380,
                  ),
                  SizedBox(height: 15), // Khoảng cách sau hình ảnh
                  Text(
                    'Bàn phím và Touchpad',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      'Pavilion 14-dv2070TU 7C0V9PA được trang bị bàn phím có độ nảy cao, người dùng không cần dùng sức nhiều khi đánh máy đem lại cảm giác thoải mái khi sử dụng, không bị mỏi tay khi dùng lâu. Ngoài ra, các góc cạnh của phím được bo tròn mềm mại, kích thước và khoảng cách rất hợp lý giúp người dùng không bị đánh máy nhầm. Touchpad có bề mặt mịn, cảm ứng đa điểm với độ chính xác cao trong từng động tác kéo thả, vuốt chạm.',
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 15), // Thêm khoảng cách giữa text và hình ảnh
                  Image.asset(
                    'images/lap14.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 380,
                  ),
                  SizedBox(height: 15), // Khoảng cách sau hình ảnh
                  Text(
                    'Hiệu năng mạnh mẽ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      'Cung cấp sức mạnh cho máy tính HP Pavilion 14-dv2070TU 7C0V9PA là bộ vi xử lý Core i3 Alder Lake của Intel. Được biết, bộ vi xử lý này cho tốc độ xung nhịp lên tới 4,4 GHz và có bộ nhớ đệm 10MB xử lý mượt mà mọi tác vụ. Đi kèm theo máy còn có card đồ họa Intel UHD Graphics với khả năng xử lý hình ảnh cực tốt. Qua đó giúp người dùng có được không gian trải nghiệm tốt nhất, hình ảnh sắc nét và sống động.',
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 15), // Thêm khoảng cách giữa text và hình ảnh
                  Image.asset(
                    'images/lap15.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 380,
                  ),
                  SizedBox(height: 15), // Khoảng cách sau hình ảnh
                  Text(
                    'Kết nối đa dạng',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      'Laptop HP Pavilion 14-dv2070TU 7C0V9PA được tích hợp đa dạng các cổng kết nối cho phép người dùng kết nối với thiết bị ngoại vi nhanh chóng. Các cổng kết nối trên Pavilion 14-dv2070TU 7C0V9PA bao gồm: 2 cổng USB Type-A, 1 cổng HDMI, 1 cổng USB Type-C, jack tai nghe 3.5mm,… Máy được tích hợp đầy đủ wifi và Bluetooth đảm bảo kết nối luôn được ổn định.',
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(height: 15), // Thêm khoảng cách giữa text và hình ảnh
                  Image.asset(
                    'images/lap16.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/giohang');
                        }, 
                        child: 
                          Text('Thêm vào giỏ hàng',style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          minimumSize: Size(200, 50), // Chiều rộng 200, chiều cao 50
                        ),
                       ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/thongtinmuahang');
                        }, 
                        child: 
                          Text('Mua ngay',style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                        minimumSize: Size(200, 50), // Chiều rộng 200, chiều cao 50
                      ),
                      ),
                    ],
                  )                     
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

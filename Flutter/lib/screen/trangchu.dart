import 'dart:async';
import 'package:flutter/material.dart';

class trangChu extends StatefulWidget {
  @override
  _trangChu createState() => _trangChu();
}

class _trangChu extends State<trangChu> {
  final PageController _pageController = PageController();
  final List<String> imageList = [
    'images/a1.png',
    'images/a2.png',
    'images/a3.png',
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Tạo bộ đếm thời gian để tự động chuyển động slider
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < imageList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Slider Hình Ảnh", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Slider với thanh kéo và chỉnh kích cỡ ảnh
          Expanded(
            child: Stack(
              children: [
                Scrollbar(
                  thickness: 4, // Độ dày của thanh kéo
                  radius: Radius.circular(10), // Bo góc thanh kéo
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imageList.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 1.0, // Chiều rộng ảnh nhỏ lại
                          height: MediaQuery.of(context).size.height * 0.5, // Chiều cao ảnh nhỏ lại
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(imageList[index]),
                              fit: BoxFit.contain, // Giữ nguyên tỉ lệ ảnh
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Dấu chấm chỉ báo
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.map((image) {
                      int index = imageList.indexOf(image);
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.red : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

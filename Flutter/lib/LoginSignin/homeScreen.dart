import 'dart:async';
import 'package:flutter/material.dart';

class trangChu extends StatefulWidget {
  @override
  _trangChu createState() => _trangChu();
}

class _trangChu extends State<trangChu> {
  final PageController _pageController = PageController();
  final List<String> imageList = [
    'https://via.placeholder.com/800x400.png?text=Image+1', // Hình ảnh 1
    'https://via.placeholder.com/800x400.png?text=Image+2', // Hình ảnh 2
    'https://via.placeholder.com/800x400.png?text=Image+3', // Hình ảnh 3
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Tạo Timer để tự động chuyển động slider
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
        title: Text('CellphoneS Slider', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Slider ảnh tự động
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: imageList.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                // Dấu chấm chỉ báo trạng thái trang
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
          // Phần nội dung dưới slider (tùy chọn)
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              "Chào mừng bạn đến với giao diện giống CellphoneS!",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

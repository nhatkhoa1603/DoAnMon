import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/thongTinCaNhan.dart';
import '../view/thongtincanhan.dart';

class tTinCaNhan extends StatefulWidget {
  final String userId;

  tTinCaNhan({Key? key, required this.userId}) : super(key: key);

  @override
  _tTinCaNhan createState() => _tTinCaNhan();
}

class _tTinCaNhan extends State<tTinCaNhan> {
  String? _selectedGender;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _diaChiController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final response = await http
        .get(Uri.parse("https://10.0.2.2:7042/khachHang/${widget.userId}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        final user = thongTinCaNhan.fromJson(data);
        _nameController.text = user.tenKhachHang;
        _selectedGender = user.gioiTinh;
        _phoneController.text = user.soDienThoai;
        _diaChiController.text = user.diaChi ?? "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2196F3),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Nhập thông tin cá nhân của bạn'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard('Họ và tên', _nameController.text),
            const SizedBox(height: 16),
            _buildInfoCard('Giới tính', _selectedGender ?? 'Chưa cập nhật'),
            const SizedBox(height: 16),
            _buildInfoCard('Số điện thoại', _phoneController.text),
            const SizedBox(height: 16),
            _buildInfoCard('Địa chỉ', _diaChiController.text),
            const SizedBox(height: 16),
            _buildInfoCard('Email', _emailController.text),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalInfoScreen(
                  //userId: '{id}',
                  ),
            ),
          );
        },
        child: const Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.blueAccent,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _diaChiController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

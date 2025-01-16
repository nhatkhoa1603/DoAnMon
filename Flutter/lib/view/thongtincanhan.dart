import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/thongTinCaNhan.dart';

class PersonalInfoScreen extends StatefulWidget {
  // PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
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
    final url = Uri.parse("https://10.0.2.2.com/khachHang/${1}");
    try {
      final response = await http.get(url);
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
        _showErrorSnackBar(
            'Không thể tải thông tin người dùng. Mã lỗi: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackBar('Có lỗi xảy ra khi tải thông tin người dùng.');
    }
  }

  Future<void> _updateUserInfo() async {
    final url = Uri.parse("https://10.0.2.2.com/khachHang/Sua/${1}");
    final updatedUser = {
      "tenKhachHang": _nameController.text.trim(),
      "gioiTinh": _selectedGender,
      "soDienThoai": _phoneController.text.trim(),
      "diaChi": _diaChiController.text.trim(),
      "email": _emailController.text.trim(),
    };

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedUser),
      );

      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        _showErrorSnackBar(
            'Cập nhật thông tin thất bại. Mã lỗi: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackBar('Có lỗi xảy ra khi cập nhật thông tin.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Thành công'),
            ],
          ),
          content: const Text('Thông tin cá nhân đã được cập nhật thành công!'),
          actions: [
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Thông tin cá nhân',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chỉnh sửa thông tin cá nhân',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextField(_nameController, 'Họ và tên', Icons.person),
              const SizedBox(height: 16),
              _buildDropdownField(),
              const SizedBox(height: 16),
              _buildTextField(_phoneController, 'Số điện thoại', Icons.phone,
                  keyboardType: TextInputType.phone, validator: _validatePhone),
              const SizedBox(height: 16),
              _buildTextField(_diaChiController, 'Địa chỉ', Icons.home),
              const SizedBox(height: 16),
              _buildTextField(_emailController, 'Email', Icons.email,
                  validator: _validateEmail),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text('Lưu thông tin',
                      style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateUserInfo();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.blue),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vui lòng nhập $label';
            }
            return null;
          },
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Giới tính',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.people, color: Colors.blue),
      ),
      items: const [
        DropdownMenuItem(value: 'Nam', child: Text('Nam')),
        DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng chọn giới tính';
        }
        return null;
      },
    );
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
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

import 'package:doanmonhoc/view/trangchu.dart';
import 'package:flutter/material.dart';

class thong_tin_mua_hang extends StatefulWidget {
  @override
  _thong_tin_mua_hang createState() => _thong_tin_mua_hang();
}

class _thong_tin_mua_hang extends State<thong_tin_mua_hang> {
  String? gioi_tinh;
  String? hinh_thuc_nhan_hang;
  int so_luong = 1;
  final int gia = 13790000;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _nameError;
  String? _phoneError;
  String? _emailError;
  String? _addressError;
  String? _genderError;
  String? _paymentError;

  String? _selectedPaymentMethod;

  int get tong_tien => so_luong * gia;

  bool validateForm() {
    bool isValid = true;

    setState(() {
      _nameError = null;
      _phoneError = null;
      _emailError = null;
      _addressError = null;
      _genderError = null;
      _paymentError = null;

      if (gioi_tinh == null) {
        _genderError = "Vui lòng chọn giới tính";
        isValid = false;
      }

      if (_nameController.text.isEmpty) {
        _nameError = "Vui lòng nhập họ tên";
        isValid = false;
      }

      if (_phoneController.text.isEmpty) {
        _phoneError = "Vui lòng nhập số điện thoại";
        isValid = false;
      }

      if (_emailController.text.isEmpty) {
        _emailError = "Vui lòng nhập email";
        isValid = false;
      }

      if (_addressController.text.isEmpty) {
        _addressError = "Vui lòng nhập địa chỉ";
        isValid = false;
      }

      if (_selectedPaymentMethod == null) {
        _paymentError = "Vui lòng chọn phương thức thanh toán";
        isValid = false;
      }
    });

    return isValid;
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận đặt hàng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thông tin đơn hàng:'),
              SizedBox(height: 10),
              Text('Người nhận: ${gioi_tinh} ${_nameController.text}'),
              Text('Số điện thoại: ${_phoneController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('Địa chỉ: ${_addressController.text}'),
              Text('Phương thức thanh toán: $_selectedPaymentMethod'),
              Text('Tổng tiền: ${tong_tien.toString()} đ'),
              SizedBox(height: 10),
              Text('Bạn có chắc chắn muốn đặt hàng?'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đặt hàng thành công!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                _clearForm();
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrangChu(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    setState(() {
      gioi_tinh = null;
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _addressController.clear();
      _selectedPaymentMethod = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Điền thông tin mua hàng',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 32),
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
                        _genderError = null;
                      });
                    },
                  ),
                  Text('Anh'),
                  SizedBox(width: 20),
                  Radio<String>(
                    value: 'Chị',
                    groupValue: gioi_tinh,
                    onChanged: (value) {
                      setState(() {
                        gioi_tinh = value;
                        _genderError = null;
                      });
                    },
                  ),
                  Text('Chị'),
                ],
              ),
              if (_genderError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    _genderError!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Họ và tên người nhận',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: _nameError,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: _phoneError,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: _emailError,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Địa chỉ',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: _addressError,
                ),
              ),
              SizedBox(height: 16),
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
                      onPressed: () {
                        setState(() {
                          _selectedPaymentMethod = 'Chuyển khoản';
                          _paymentError = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedPaymentMethod == 'Chuyển khoản'
                                ? Colors.blue
                                : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(150, 50),
                      ),
                      child: Text(
                        'Chuyển khoản',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedPaymentMethod = 'Tiền mặt';
                          _paymentError = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedPaymentMethod == 'Tiền mặt'
                            ? Colors.blue
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: Size(150, 50),
                      ),
                      child: Text(
                        'Tiền mặt',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              if (_paymentError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    _paymentError!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              SizedBox(height: 20),
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
                    onPressed: () {
                      if (validateForm()) {
                        _showConfirmDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      'ĐẶT HÀNG',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}

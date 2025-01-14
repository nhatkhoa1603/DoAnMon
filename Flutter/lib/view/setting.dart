import 'package:flutter/material.dart';

class CaiDat extends StatefulWidget {
  @override
  _CaiDatState createState() => _CaiDatState();
}

class _CaiDatState extends State<CaiDat> {
  bool _darkMode = false;
  bool _notifications = true;
  String _language = 'Tiếng Việt';
  bool _biometricAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cài đặt',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Giao diện & Hiển thị',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SwitchListTile(
                  title: Text('Chế độ tối'),
                  subtitle: Text('Thay đổi giao diện sang tông màu tối'),
                  value: _darkMode,
                  onChanged: (bool value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
                ListTile(
                  title: Text('Ngôn ngữ'),
                  subtitle: Text(_language),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Chọn ngôn ngữ'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('Tiếng Việt'),
                                onTap: () {
                                  setState(() {
                                    _language = 'Tiếng Việt';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('English'),
                                onTap: () {
                                  setState(() {
                                    _language = 'English';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                Divider(height: 1),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Thông báo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SwitchListTile(
                  title: Text('Thông báo đẩy'),
                  subtitle: Text('Nhận thông báo về đơn hàng và khuyến mãi'),
                  value: _notifications,
                  onChanged: (bool value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
                Divider(height: 1),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Bảo mật',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Đổi mật khẩu'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement password change logic
                  },
                ),
                SwitchListTile(
                  title: Text('Xác thực sinh trắc học'),
                  subtitle: Text('Sử dụng vân tay hoặc Face ID để đăng nhập'),
                  value: _biometricAuth,
                  onChanged: (bool value) {
                    setState(() {
                      _biometricAuth = value;
                    });
                  },
                ),
                Divider(height: 1),
                ListTile(
                  title: Text('Về ứng dụng'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Tên ứng dụng',
                      applicationVersion: 'Phiên bản 1.0.0',
                      applicationLegalese: '© 2025 Your Company',
                    );
                  },
                ),
                ListTile(
                  title: Text('Điều khoản sử dụng'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Navigate to Terms of Service
                  },
                ),
                ListTile(
                  title: Text('Chính sách bảo mật'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Navigate to Privacy Policy
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

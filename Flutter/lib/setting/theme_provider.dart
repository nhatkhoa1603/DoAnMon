// // theme_provider.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ThemeProvider with ChangeNotifier {
//   bool _isDarkMode = false;

//   bool get isDarkMode => _isDarkMode;

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }

//   ThemeData get theme => _isDarkMode ? _darkTheme : _lightTheme;

//   static final _lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: Colors.grey[100],
//   );

//   static final _darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: Colors.grey[900],
//   );
// }

// // password_change_screen.dart
// class PasswordChangeScreen extends StatefulWidget {
//   @override
//   _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
// }

// class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _isObscure = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text('Đổi mật khẩu', style: TextStyle(color: Colors.black87)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _currentPasswordController,
//                 obscureText: _isObscure,
//                 decoration: InputDecoration(
//                   labelText: 'Mật khẩu hiện tại',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                         _isObscure ? Icons.visibility : Icons.visibility_off),
//                     onPressed: () => setState(() => _isObscure = !_isObscure),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Vui lòng nhập mật khẩu hiện tại';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _newPasswordController,
//                 obscureText: _isObscure,
//                 decoration: InputDecoration(
//                   labelText: 'Mật khẩu mới',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                         _isObscure ? Icons.visibility : Icons.visibility_off),
//                     onPressed: () => setState(() => _isObscure = !_isObscure),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Vui lòng nhập mật khẩu mới';
//                   }
//                   if (value!.length < 6) {
//                     return 'Mật khẩu phải có ít nhất 6 ký tự';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 obscureText: _isObscure,
//                 decoration: InputDecoration(
//                   labelText: 'Xác nhận mật khẩu mới',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                         _isObscure ? Icons.visibility : Icons.visibility_off),
//                     onPressed: () => setState(() => _isObscure = !_isObscure),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Vui lòng xác nhận mật khẩu mới';
//                   }
//                   if (value != _newPasswordController.text) {
//                     return 'Mật khẩu xác nhận không khớp';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     // TODO: Implement actual password change logic
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Đổi mật khẩu thành công')),
//                     );
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text('Đổi mật khẩu'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 48),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // terms_screen.dart
// class TermsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title:
//             Text('Điều khoản sử dụng', style: TextStyle(color: Colors.black87)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           Text(
//             '1. Điều khoản sử dụng',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Bằng cách truy cập và sử dụng ứng dụng này, bạn đồng ý tuân theo các điều khoản và điều kiện sau...',
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(height: 16),
//           Text(
//             '2. Quyền sở hữu trí tuệ',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Tất cả nội dung trong ứng dụng này được bảo vệ bởi luật bản quyền...',
//             style: TextStyle(fontSize: 16),
//           ),
//           // Add more terms as needed
//         ],
//       ),
//     );
//   }
// }

// // privacy_policy_screen.dart
// class PrivacyPolicyScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title:
//             Text('Chính sách bảo mật', style: TextStyle(color: Colors.black87)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(16),
//         children: [
//           Text(
//             '1. Thu thập thông tin',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Chúng tôi thu thập các thông tin cá nhân khi bạn đăng ký tài khoản...',
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(height: 16),
//           Text(
//             '2. Sử dụng thông tin',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Thông tin của bạn được sử dụng để cung cấp và cải thiện dịch vụ...',
//             style: TextStyle(fontSize: 16),
//           ),
//           // Add more privacy policy content as needed
//         ],
//       ),
//     );
//   }
// }

// // Modified CaiDat class
// class CaiDat extends StatefulWidget {
//   @override
//   _CaiDatState createState() => _CaiDatState();
// }

// class _CaiDatState extends State<CaiDat> {
//   bool _notifications = true;
//   String _language = 'Tiếng Việt';
//   bool _biometricAuth = false;

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Cài đặt',
//           style: TextStyle(color: Colors.black87),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: ListView(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 16),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     'Giao diện & Hiển thị',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ),
//                 SwitchListTile(
//                   title: Text('Chế độ tối'),
//                   subtitle: Text('Thay đổi giao diện sang tông màu tối'),
//                   value: themeProvider.isDarkMode,
//                   onChanged: (bool value) {
//                     themeProvider.toggleTheme();
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Đổi mật khẩu'),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PasswordChangeScreen()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Điều khoản sử dụng'),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => TermsScreen()),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Chính sách bảo mật'),
//                   trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PrivacyPolicyScreen()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

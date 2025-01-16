class TaiKhoankethua {
  final int maTaiKhoan;

  TaiKhoankethua({required this.maTaiKhoan});

  // Phương thức từ Map<String, dynamic> chuyển thành đối tượng TaiKhoan
  factory TaiKhoankethua.fromJson(Map<String, dynamic> json) {
    return TaiKhoankethua(
      maTaiKhoan: json['maTaiKhoan'],
    );
  }
}

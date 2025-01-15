class thongTinCaNhan {
  final int maKhachHang;
  final String tenKhachHang;
  final String gioiTinh;
  final String? diaChi; 
  final String soDienThoai;
  final String email;
  final int trangThai;

  thongTinCaNhan({
    required this.maKhachHang,
    required this.tenKhachHang,
    required this.gioiTinh,
    this.diaChi,  // Có thể null
    required this.soDienThoai,
    required this.email,
    required this.trangThai,
  });

  factory thongTinCaNhan.fromJson(Map<String, dynamic> json) {
    return thongTinCaNhan(
      maKhachHang: json['data']['maKhachHang'],
      tenKhachHang: json['data']['tenKhachHang'],
      gioiTinh: json['data']['gioiTinh'],
      diaChi: json['data']['diaChi'],
      soDienThoai: json['data']['soDienThoai'],
      email: json['data']['email'],
      trangThai: json['data']['trangThai'],
    );
  }
}

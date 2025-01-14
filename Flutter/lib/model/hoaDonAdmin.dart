class hoaDonAdmin {
  final int maHoaDon;
  final String tenKhachHang;
  final String soDienThoai;
  final int trangThai;
  final String ngayDatHang;

  hoaDonAdmin(
      {required this.maHoaDon,
      required this.tenKhachHang,
      required this.soDienThoai,
      required this.trangThai,
      required this.ngayDatHang});

  factory hoaDonAdmin.fromJson(Map<String, dynamic> json) {
    return hoaDonAdmin(
        maHoaDon: json['maDonHang'],
        tenKhachHang: json['tenKhachHang'],
        soDienThoai: json['soDienThoai'],
        trangThai: json['trangThai'],
        ngayDatHang: json['ngayDatHang']);
  }
}

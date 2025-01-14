class chiTietHoaDonAdmin {
  final int maHoaDon;
  final int maSanPham;
  final String tenSanPham;
  int soLuong;
  final double Gia;
  final String hinhAnh;

  chiTietHoaDonAdmin(
      {required this.maHoaDon,
      required this.maSanPham,
      required this.tenSanPham,
      required this.soLuong,
      required this.Gia,
      required this.hinhAnh});

  factory chiTietHoaDonAdmin.fromJson(Map<String, dynamic> json) {
    return chiTietHoaDonAdmin(
        maHoaDon: json['maHoaDon'],
        maSanPham: json['maSanPham'],
        tenSanPham: json['tenSanPham'],
        soLuong: json['soLuong'],
        Gia: json['giaXuat'],
        hinhAnh: json['hinhAnh']);
  }
}

class Hoadon {
  final int maHoaDon;
  final String tenKhachHang;
  final String soDienThoai;
  final int trangThai;
  final String ngayDatHang;

  Hoadon(
      {required this.maHoaDon,
      required this.tenKhachHang,
      required this.soDienThoai,
      required this.trangThai,
      required this.ngayDatHang});

  factory Hoadon.fromJson(Map<String, dynamic> json) {
    return Hoadon(
        maHoaDon: json['maDonHang'],
        tenKhachHang: json['tenKhachHang'],
        soDienThoai: json['soDienThoai'],
        trangThai: json['trangThai'],
        ngayDatHang: json['ngayDatHang']);
  }
}

class Hoadon {
  final int maDonHang;
  final int maKhachHang;
  final int maDiaChiGiao;
  final String ngayDatHang;
  final int trangThai;

  Hoadon(
      {required this.maDonHang,
      required this.maKhachHang,
      required this.maDiaChiGiao,
      required this.ngayDatHang,
      required this.trangThai});

  factory Hoadon.fromJson(Map<String, dynamic> json) {
    return Hoadon(
        maDonHang: json['maDonHang'],
        maKhachHang: json['maKhachHang'],
        maDiaChiGiao: json['maDiaChiGiao'],
        ngayDatHang: json['ngayDatHang'],
        trangThai: json['trangThai']);
  }
}

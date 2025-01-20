class Giohang_model {
  final int maSanPham;
  final int maKhachHang;
  final String tensanPham;
  final double Gia;
  final String hinhAnh;
  int soLuong;

  Giohang_model(
      {required this.maSanPham,
      required this.maKhachHang,
      required this.tensanPham,
      required this.Gia,
      required this.hinhAnh,
      required this.soLuong});
  factory Giohang_model.fromJson(Map<String, dynamic> json) {
    return Giohang_model(
        maSanPham: json['maSanPham'],
        maKhachHang: json['maKhachHang'],
        tensanPham: json['tenSanPham'],
        Gia: json['giaXuat'],
        hinhAnh: json['hinhAnh'],
        soLuong: json['soLuong']);
  }
}

class Sanpham {
  final int maSanPham;
  final String tenSanPham;
  final int maThuongHieu;
  final String xuatXu;
  final double giaXuat;
  final int soLuongTonKho;
  final String hinhAnh;
  final String Ram;
  final String CPU;
  final String moTa;
  final int trangThai;

  Sanpham(
      {required this.maSanPham,
      required this.tenSanPham,
      required this.maThuongHieu,
      required this.xuatXu,
      required this.giaXuat,
      required this.soLuongTonKho,
      required this.hinhAnh,
      required this.Ram,
      required this.CPU,
      required this.moTa,
      required this.trangThai});

  factory Sanpham.fromJson(Map<String, dynamic> json) {
    return Sanpham(
        maSanPham: json['maSanPham'],
        tenSanPham: json['tenSanPham'],
        maThuongHieu: json['maThuongHieu'],
        xuatXu: json['xuatXu'],
        giaXuat: json['giaXuat'],
        soLuongTonKho: json['soLuongTonKho'],
        hinhAnh: json['hinhAnh'],
        Ram: json['ram'],
        CPU: json['cpu'],
        moTa: json['moTa'],
        trangThai: json['trangThai']);
  }
}

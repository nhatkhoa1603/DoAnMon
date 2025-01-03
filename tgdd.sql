CREATE DATABASE QuanLyLaptop;
GO
USE QuanLyLaptop;
GO

-- Loại sản phẩm
CREATE TABLE LoaiSanPham (
  MaLoaiSanPham INT PRIMARY KEY IDENTITY(1,1),
  TenLoaiSanPham NVARCHAR(50) NOT NULL
);

-- Danh mục sản phẩm
CREATE TABLE DanhMucSanPham (
  MaDanhMuc INT PRIMARY KEY,
  TenDanhMuc NVARCHAR(50) NOT NULL
);

-- Tài khoản người dùng
CREATE TABLE TaiKhoan (
  MaTaiKhoan INT PRIMARY KEY IDENTITY(1,1),  
  TenDangNhap VARCHAR(50) UNIQUE NOT NULL,
  MatKhau VARCHAR(255) NOT NULL,
  LoaiTaiKhoan NVARCHAR(20) CHECK (LoaiTaiKhoan IN ('ADMIN', 'KHACHHANG')),
  TrangThai BIT NOT NULL DEFAULT 1
);

-- Phương thức thanh toán
CREATE TABLE HinhThucThanhToan (
  MaHinhThucThanhToan INT PRIMARY KEY IDENTITY(1,1),
  TenHinhThucThanhToan NVARCHAR(255) NOT NULL,
  MoTa NVARCHAR(MAX),
  TrangThai INT
);

-- Khuyến mãi
CREATE TABLE KhuyenMai (
  MaKhuyenMai INT PRIMARY KEY IDENTITY(1,1),
  TenKhuyenMai NVARCHAR(255) NOT NULL,
  NgayBatDau DATE,
  NgayKetThuc DATE,
  PhanTramGiam INT,
  MoTaKhuyenMai NVARCHAR(MAX),
  TrangThai INT
);

-- Thương hiệu (mới thêm vào)
CREATE TABLE ThuongHieu (
  MaThuongHieu INT PRIMARY KEY IDENTITY(1,1),
  TenThuongHieu NVARCHAR(255) NOT NULL
);

-- Sản phẩm
CREATE TABLE SanPham (
  MaSanPham INT PRIMARY KEY IDENTITY(1,1),
  TenSanPham NVARCHAR(255) NOT NULL,
  LoaiSanPham INT,
  MaDanhMuc INT,
  MaThuongHieu INT,  -- Thêm liên kết với bảng ThuongHieu
  XuatXu NVARCHAR(255),
  GiaNhap DECIMAL(10, 2),
  GiaXuat DECIMAL(10, 2),
  SoLuongTonKho INT DEFAULT 0,
  KhuVucKho NVARCHAR(255),
  HinhAnh NVARCHAR(255),
  Ram NVARCHAR(255),
  CPU NVARCHAR(255),
  MoTa NVARCHAR(MAX),
  TrangThai INT DEFAULT 1,
  FOREIGN KEY (LoaiSanPham) REFERENCES LoaiSanPham(MaLoaiSanPham),
  FOREIGN KEY (MaDanhMuc) REFERENCES DanhMucSanPham(MaDanhMuc),
  FOREIGN KEY (MaThuongHieu) REFERENCES ThuongHieu(MaThuongHieu)  -- Liên kết với ThuongHieu
);

-- Khách hàng
CREATE TABLE KhachHang (
  MaKhachHang INT PRIMARY KEY IDENTITY(1,1),
  TenKhachHang NVARCHAR(255) NOT NULL,
  GioiTinh NVARCHAR(10),
  DiaChi NVARCHAR(255),
  SoDienThoai VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  TrangThai INT,
  FOREIGN KEY (MaKhachHang) REFERENCES TaiKhoan(MaTaiKhoan)
);

-- Đánh giá sản phẩm
CREATE TABLE DanhGiaSanPham (
  MaDanhGia INT PRIMARY KEY IDENTITY(1,1),  
  MaSanPham INT NOT NULL,                    
  MaKhachHang INT NOT NULL,                   -- Liên kết khách hàng
  SoSao INT CHECK (SoSao BETWEEN 1 AND 5),  
  MoTa NVARCHAR(MAX),                        
  NgayDanhGia DATETIME DEFAULT GETDATE(),    
  TrangThai BIT NOT NULL DEFAULT 1,         
  FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham),
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

-- Địa chỉ giao hàng
CREATE TABLE DiaChiGiaoHang (
    MaDiaChi INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT NOT NULL,
    TenNguoiNhan NVARCHAR(255) NOT NULL,
    SoDienThoai VARCHAR(20) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    Tinh_ThanhPho NVARCHAR(100) NOT NULL,
    Quan_Huyen NVARCHAR(100) NOT NULL,
    Phuong_Xa NVARCHAR(100) NOT NULL,
    MacDinh BIT DEFAULT 0,
    TrangThai INT DEFAULT 1,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

-- Giỏ hàng
CREATE TABLE GioHang (
  MaGioHang INT PRIMARY KEY IDENTITY(1,1),
  MaSanPham INT NOT NULL,
  MaKhachHang INT NOT NULL,
  SoLuong INT NOT NULL,
  ThanhTien DECIMAL(10, 2) NOT NULL,
  TrangThai INT NOT NULL DEFAULT 1,   
  FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham),
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

-- Hóa đơn
CREATE TABLE HoaDon (
  MaDonHang INT PRIMARY KEY IDENTITY(1,1),
  MaKhachHang INT NOT NULL,
  MaGioHang INT,
  MaDiaChiGiao INT,
  NgayDatHang DATE NOT NULL DEFAULT GETDATE(),
  PhiVanChuyen DECIMAL(10, 2) DEFAULT 0,
  MaKhuyenMai INT,
  TrangThai INT NOT NULL,
  FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
  FOREIGN KEY (MaGioHang) REFERENCES GioHang(MaGioHang),
  FOREIGN KEY (MaDiaChiGiao) REFERENCES DiaChiGiaoHang(MaDiaChi),
  FOREIGN KEY (MaKhuyenMai) REFERENCES KhuyenMai(MaKhuyenMai)
);

-- Chi tiết hóa đơn
CREATE TABLE ChiTietHoaDon (
  MaHoaDon INT NOT NULL,
  MaSanPham INT NOT NULL,
  SoLuong INT NOT NULL,
  GiaBan DECIMAL(10, 2) NOT NULL,
  GiamGia DECIMAL(10, 2) DEFAULT 0,
  ThanhTien AS (SoLuong * GiaBan - GiamGia),
  PRIMARY KEY (MaHoaDon, MaSanPham),
  FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaDonHang),
  FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Trạng thái giao hàng
CREATE TABLE TrangThaiGiaoHang (
    MaTrangThai INT PRIMARY KEY IDENTITY(1,1),
    MaHoaDon INT NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    ThoiGian DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaDonHang)
);

-- Thông tin thanh toán
CREATE TABLE ThongTinThanhToan (
  MaThanhToan INT PRIMARY KEY IDENTITY(1,1),
  MaHoaDon INT NOT NULL,
  MaHinhThucThanhToan INT NOT NULL,
  NgayThanhToan DATE NOT NULL DEFAULT GETDATE(),
  SoTien DECIMAL(10, 2) NOT NULL,
  MaGiaoDich NVARCHAR(100),
  TrangThai INT NOT NULL,
  FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaDonHang),
  FOREIGN KEY (MaHinhThucThanhToan) REFERENCES HinhThucThanhToan(MaHinhThucThanhToan)
);

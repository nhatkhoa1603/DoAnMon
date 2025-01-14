USE [master]
GO
/****** Object:  Database [QuanLyLaptop]    Script Date: 14/01/2025 12:43:28 CH ******/
CREATE DATABASE [QuanLyLaptop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyLaptop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NHATKHOA\MSSQL\DATA\QuanLyLaptop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyLaptop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.NHATKHOA\MSSQL\DATA\QuanLyLaptop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QuanLyLaptop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyLaptop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyLaptop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyLaptop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyLaptop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyLaptop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyLaptop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyLaptop] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyLaptop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyLaptop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyLaptop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyLaptop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyLaptop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyLaptop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyLaptop', N'ON'
GO
ALTER DATABASE [QuanLyLaptop] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyLaptop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyLaptop]
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaHoaDon] [int] NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaBan] [decimal](10, 2) NOT NULL,
	[GiamGia] [decimal](10, 2) NULL,
	[ThanhTien]  AS ([SoLuong]*[GiaBan]-[GiamGia]),
 CONSTRAINT [PK_ChiTietHoaDon_1] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGiaSanPham]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGiaSanPham](
	[MaDanhGia] [int] IDENTITY(1,1) NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[SoSao] [int] NULL,
	[MoTa] [nvarchar](max) NULL,
	[NgayDanhGia] [datetime] NULL,
	[TrangThai] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDanhGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaChiGiaoHang]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaChiGiaoHang](
	[MaDiaChi] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[TenNguoiNhan] [nvarchar](255) NOT NULL,
	[SoDienThoai] [varchar](20) NOT NULL,
	[DiaChi] [nvarchar](255) NOT NULL,
	[Tinh_ThanhPho] [nvarchar](100) NOT NULL,
	[Quan_Huyen] [nvarchar](100) NOT NULL,
	[Phuong_Xa] [nvarchar](100) NOT NULL,
	[MacDinh] [bit] NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDiaChi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[MaKhachHang] [int] NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[ThanhTien] [decimal](10, 2) NOT NULL,
	[TrangThai] [int] NOT NULL,
 CONSTRAINT [PK_GioHang_1] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HinhThucThanhToan]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhThucThanhToan](
	[MaHinhThucThanhToan] [int] IDENTITY(1,1) NOT NULL,
	[TenHinhThucThanhToan] [nvarchar](255) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHinhThucThanhToan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaDonHang] [int] IDENTITY(1,1) NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[MaDiaChiGiao] [int] NULL,
	[NgayDatHang] [datetime] NULL,
	[PhiVanChuyen] [decimal](10, 2) NULL,
	[MaKhuyenMai] [int] NULL,
	[TongTien] [int] NULL,
	[TrangThai] [int] NULL,
 CONSTRAINT [PK__HoaDon__129584AD7A57C2FA] PRIMARY KEY CLUSTERED 
(
	[MaDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhachHang] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachHang] [nvarchar](255) NOT NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[DiaChi] [nvarchar](255) NULL,
	[SoDienThoai] [varchar](20) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[TrangThai] [int] NULL,
 CONSTRAINT [PK__KhachHan__88D2F0E5C1201AD7] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[MaKhuyenMai] [int] IDENTITY(1,1) NOT NULL,
	[TenKhuyenMai] [nvarchar](255) NOT NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[PhanTramGiam] [int] NULL,
	[MoTaKhuyenMai] [nvarchar](max) NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKhuyenMai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](255) NOT NULL,
	[MaThuongHieu] [int] NULL,
	[XuatXu] [nvarchar](255) NULL,
	[GiaNhap] [decimal](10, 2) NULL,
	[GiaXuat] [decimal](10, 2) NULL,
	[SoLuongTonKho] [int] NULL,
	[HinhAnh] [nvarchar](255) NULL,
	[Ram] [nvarchar](255) NULL,
	[CPU] [nvarchar](255) NULL,
	[MoTa] [nvarchar](max) NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [varchar](50) NOT NULL,
	[MatKhau] [varchar](255) NOT NULL,
	[LoaiTaiKhoan] [nvarchar](20) NULL,
	[TrangThai] [bit] NOT NULL,
 CONSTRAINT [PK__TaiKhoan__AD7C6529DE3F4AE9] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongTinThanhToan]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinThanhToan](
	[MaThanhToan] [int] IDENTITY(1,1) NOT NULL,
	[MaHoaDon] [int] NOT NULL,
	[MaHinhThucThanhToan] [int] NOT NULL,
	[NgayThanhToan] [datetime] NULL,
	[SoTien] [decimal](10, 2) NOT NULL,
	[TrangThai] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaThanhToan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThuongHieu]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuongHieu](
	[MaThuongHieu] [int] IDENTITY(1,1) NOT NULL,
	[TenThuongHieu] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaThuongHieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangThaiGiaoHang]    Script Date: 14/01/2025 12:43:28 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThaiGiaoHang](
	[MaTrangThai] [int] IDENTITY(1,1) NOT NULL,
	[MaHoaDon] [int] NOT NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
	[ThoiGian] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ChiTietHoaDon] ([MaHoaDon], [MaSanPham], [SoLuong], [GiaBan], [GiamGia]) VALUES (1, 1, 3, CAST(200.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[DiaChiGiaoHang] ON 

INSERT [dbo].[DiaChiGiaoHang] ([MaDiaChi], [MaKhachHang], [TenNguoiNhan], [SoDienThoai], [DiaChi], [Tinh_ThanhPho], [Quan_Huyen], [Phuong_Xa], [MacDinh], [TrangThai]) VALUES (1, 1, N'akhoa', N'0123456789', N'dn', N'dn', N'dn', N'dn', 0, 1)
SET IDENTITY_INSERT [dbo].[DiaChiGiaoHang] OFF
GO
INSERT [dbo].[GioHang] ([MaKhachHang], [MaSanPham], [SoLuong], [ThanhTien], [TrangThai]) VALUES (1, 1, 4, CAST(20.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[GioHang] ([MaKhachHang], [MaSanPham], [SoLuong], [ThanhTien], [TrangThai]) VALUES (1, 2, 2, CAST(1.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[GioHang] ([MaKhachHang], [MaSanPham], [SoLuong], [ThanhTien], [TrangThai]) VALUES (1, 3, 2, CAST(10.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[GioHang] ([MaKhachHang], [MaSanPham], [SoLuong], [ThanhTien], [TrangThai]) VALUES (2, 2, 1, CAST(6.00 AS Decimal(10, 2)), 1)
GO
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] ON 

INSERT [dbo].[HinhThucThanhToan] ([MaHinhThucThanhToan], [TenHinhThucThanhToan], [MoTa], [TrangThai]) VALUES (1, N'Tiền mặt', N'Thanh toán khi nhận hàng', 1)
INSERT [dbo].[HinhThucThanhToan] ([MaHinhThucThanhToan], [TenHinhThucThanhToan], [MoTa], [TrangThai]) VALUES (2, N'Online', N'', 1)
SET IDENTITY_INSERT [dbo].[HinhThucThanhToan] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([MaDonHang], [MaKhachHang], [MaDiaChiGiao], [NgayDatHang], [PhiVanChuyen], [MaKhuyenMai], [TongTien], [TrangThai]) VALUES (1, 1, 1, CAST(N'2025-01-07T11:21:16.420' AS DateTime), CAST(20.00 AS Decimal(10, 2)), NULL, NULL, 1)
INSERT [dbo].[HoaDon] ([MaDonHang], [MaKhachHang], [MaDiaChiGiao], [NgayDatHang], [PhiVanChuyen], [MaKhuyenMai], [TongTien], [TrangThai]) VALUES (2, 2, 1, CAST(N'2025-01-10T07:11:57.270' AS DateTime), CAST(10.00 AS Decimal(10, 2)), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (1, N'duy', N'string', NULL, N'string', N'string', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (2, N'Tr?n Th? B', N'N?', NULL, N'0912345678', N'tranthib@gmail.com', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (3, N'Trần Thị C', N'Nữ', NULL, N'0123', N'abc@gmail.com', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (4, N'ád', N'ds', NULL, N'21', N'a', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (5, N'á', N'á', NULL, N'á', N'sa', NULL)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (8, N'aa', NULL, NULL, N'ccc', N'ccc', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (9, N'test', NULL, NULL, N'0333', N'sss', NULL)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (10, N'haha', N'string', N'string', N'haha', N'haha', 0)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (11, N'a', N'a', NULL, N'3', N'3', NULL)
INSERT [dbo].[KhachHang] ([MaKhachHang], [TenKhachHang], [GioiTinh], [DiaChi], [SoDienThoai], [Email], [TrangThai]) VALUES (13, N'aaa', N'aaa', NULL, N'aaa', N'aaa', NULL)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (1, N'asus', 1, N'china', CAST(20.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)), 30, NULL, N'26', N'gtx', NULL, 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (2, N'lenovo', 2, N'china', CAST(20.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)), 30, NULL, N'32', N'rtx', NULL, 0)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (3, N'abc', 1, N'china', CAST(20.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)), 20, NULL, N'16', N'gtx', NULL, 1)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (1, N'akhoa', N'123', N'ADMIN', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (2, N'admin1', N'password123', N'ADMIN', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (3, N'khachhang1', N'password456', N'KHACHHANG', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (4, N'khachhang2', N'123', N'KHACHHANG', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (5, N'abc', N'222', N'ADMIN', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (8, N'123', N'111', N'ADMIN', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (9, N'test', N'123', N'KHACHHANG', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (10, N'hahaha', N'hahaha', N'ADMIN', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (11, N'haha', N'haha', N'ADMIN', 1)
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [TenDangNhap], [MatKhau], [LoaiTaiKhoan], [TrangThai]) VALUES (13, N'aaaa', N'cccc', N'ADMIN', 1)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] ON 

INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (1, N'asus')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (2, N'lenovo')
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TaiKhoan__55F68FC06A33D60E]    Script Date: 14/01/2025 12:43:28 CH ******/
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [UQ__TaiKhoan__55F68FC06A33D60E] UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietHoaDon] ADD  CONSTRAINT [DF__ChiTietHo__GiamG__619B8048]  DEFAULT ((0)) FOR [GiamGia]
GO
ALTER TABLE [dbo].[DanhGiaSanPham] ADD  DEFAULT (getdate()) FOR [NgayDanhGia]
GO
ALTER TABLE [dbo].[DanhGiaSanPham] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[DiaChiGiaoHang] ADD  DEFAULT ((0)) FOR [MacDinh]
GO
ALTER TABLE [dbo].[DiaChiGiaoHang] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[GioHang] ADD  CONSTRAINT [DF__GioHang__TrangTh__5535A963]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF__HoaDon__NgayDatH__59FA5E80]  DEFAULT (getdate()) FOR [NgayDatHang]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF__HoaDon__PhiVanCh__5AEE82B9]  DEFAULT ((0)) FOR [PhiVanChuyen]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_TrangThai]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((0)) FOR [SoLuongTonKho]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [DF__TaiKhoan__TrangT__398D8EEE]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[ThongTinThanhToan] ADD  DEFAULT (getdate()) FOR [NgayThanhToan]
GO
ALTER TABLE [dbo].[TrangThaiGiaoHang] ADD  DEFAULT (getdate()) FOR [ThoiGian]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietHo__MaHoa__628FA481] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaDonHang])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK__ChiTietHo__MaHoa__628FA481]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietHo__MaSan__6383C8BA] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK__ChiTietHo__MaSan__6383C8BA]
GO
ALTER TABLE [dbo].[DanhGiaSanPham]  WITH CHECK ADD  CONSTRAINT [FK__DanhGiaSa__MaKha__4D94879B] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
GO
ALTER TABLE [dbo].[DanhGiaSanPham] CHECK CONSTRAINT [FK__DanhGiaSa__MaKha__4D94879B]
GO
ALTER TABLE [dbo].[DanhGiaSanPham]  WITH CHECK ADD FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[DiaChiGiaoHang]  WITH CHECK ADD  CONSTRAINT [FK__DiaChiGia__MaKha__52593CB8] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
GO
ALTER TABLE [dbo].[DiaChiGiaoHang] CHECK CONSTRAINT [FK__DiaChiGia__MaKha__52593CB8]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK__GioHang__MaKhach__571DF1D5] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK__GioHang__MaKhach__571DF1D5]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK__GioHang__MaSanPh__5629CD9C] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK__GioHang__MaSanPh__5629CD9C]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK__HoaDon__MaDiaChi__5DCAEF64] FOREIGN KEY([MaDiaChiGiao])
REFERENCES [dbo].[DiaChiGiaoHang] ([MaDiaChi])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK__HoaDon__MaDiaChi__5DCAEF64]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK__HoaDon__MaKhachH__5BE2A6F2] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK__HoaDon__MaKhachH__5BE2A6F2]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK__HoaDon__MaKhuyen__5EBF139D] FOREIGN KEY([MaKhuyenMai])
REFERENCES [dbo].[KhuyenMai] ([MaKhuyenMai])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK__HoaDon__MaKhuyen__5EBF139D]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK__KhachHang__MaKha__46E78A0C] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK__KhachHang__MaKha__46E78A0C]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaThuongHieu])
REFERENCES [dbo].[ThuongHieu] ([MaThuongHieu])
GO
ALTER TABLE [dbo].[ThongTinThanhToan]  WITH CHECK ADD FOREIGN KEY([MaHinhThucThanhToan])
REFERENCES [dbo].[HinhThucThanhToan] ([MaHinhThucThanhToan])
GO
ALTER TABLE [dbo].[ThongTinThanhToan]  WITH CHECK ADD  CONSTRAINT [FK__ThongTinT__MaHoa__6B24EA82] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaDonHang])
GO
ALTER TABLE [dbo].[ThongTinThanhToan] CHECK CONSTRAINT [FK__ThongTinT__MaHoa__6B24EA82]
GO
ALTER TABLE [dbo].[TrangThaiGiaoHang]  WITH CHECK ADD  CONSTRAINT [FK__TrangThai__MaHoa__6754599E] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaDonHang])
GO
ALTER TABLE [dbo].[TrangThaiGiaoHang] CHECK CONSTRAINT [FK__TrangThai__MaHoa__6754599E]
GO
ALTER TABLE [dbo].[DanhGiaSanPham]  WITH CHECK ADD CHECK  (([SoSao]>=(1) AND [SoSao]<=(5)))
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [CK__TaiKhoan__LoaiTa__38996AB5] CHECK  (([LoaiTaiKhoan]='KHACHHANG' OR [LoaiTaiKhoan]='ADMIN'))
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [CK__TaiKhoan__LoaiTa__38996AB5]
GO
USE [master]
GO
ALTER DATABASE [QuanLyLaptop] SET  READ_WRITE 
GO

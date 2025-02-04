USE [master]
GO
/****** Object:  Database [QuanLyLaptop]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[DanhGiaSanPham]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[DiaChiGiaoHang]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[GioHang]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[HinhThucThanhToan]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[HoaDon]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[KhachHang]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[SanPham]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[ThongTinThanhToan]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[ThuongHieu]    Script Date: 14/01/2025 4:14:28 CH ******/
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
/****** Object:  Table [dbo].[TrangThaiGiaoHang]    Script Date: 14/01/2025 4:14:28 CH ******/
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

INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (1, N'Laptop ASUS Vivobook 15 X1504ZA-NJ517W', 1, N'china', CAST(20.00 AS Decimal(10, 2)), CAST(13990000.00 AS Decimal(10, 2)), 30, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_7_50.png', N'16', N'I5-1235U', N'Laptop Asus Vivobook 15 X1504ZA-NJ517W được trang bị bộ vi xử lý Intel Core i5-1235U cùng card đồ họa Intel Xe Graphics hạn chế độ trễ của khung hình. Sản phẩm sử dụng RAM 16GB DDR4 với ổ cứng SSD M.2 NVMe PCIe 3.0 dung lượng 512GB cung cấp kho lưu trữ lớn. Màn hình FHD 15.6 inch theo chuẩn tỉ lệ 16:9 tích hợp công nghệ màn hình Anti-Glare chống lóa. Thiết kế máy mỏng gọn với bản lề xoay 180 độ linh hoạt, dễ điều chỉnh. 
Laptop Asus Vivobook 15 X1504ZA-NJ517W: bản lề 180 độ, bộ xử lý Core i5 gen 12
Bạn là học sinh - sinh viên hay dân văn phòng đang tìm mua máy tính xách tay nhỏ gọn nhưng đồng thời phải đáp ứng yêu cầu về mặt hiệu năng? Vậy thì đừng bỏ qua Vivobook 15 X1504ZA-NJ517W - mẫu laptop Asus Vivobook văn phòng đến từ nhà ASUS. Không chỉ có thiết kế thời trang vô cùng bắt mắt, sản phẩm này còn sở hữu cấu hình cao với khả năng chạy đa nhiệm ấn tượng trong phân khúc. 
RAM 8GB chuẩn DDR4, SSD 512GB PCIe truyền tải nhanh
Vivobook 15 X1504ZA-NJ517W được trang bị RAM DDR4 dung lượng 16GB. Với bộ nhớ RAM này, Vivobook 15 X1504ZA-NJ517W sẽ cung cấp khả năng xử lý đa nhiệm ổn định.Ngoài ra, máy còn sử dụng ổ cứng SSD tốc độ cao với bộ nhớ lên tới 512GB. Dễ dàng khởi động hệ thống trong thời gian ngắn và tải ứng dụng kích thước lớn mà không cần bận tâm về tình trạng hết dung lượng. Chuẩn kết nối PCIe 3.0 tân tiến cho phép bạn chia sẻ dữ liệu với độ phân giải cao nhanh chóng và hiệu quả hơn. 
CPU Intel Core i5 thế hệ 12 mạnh mẽ, đáng tin cậy
Asus đã sử dụng bộ vi xử lý Intel Core i5-1235U gen 12 đa nhiệm cho giải trí và học tập trên Vivobook 15 X1504ZA-NJ517W. Chipset này bao gồm 10 lõi cùng 12 luồng với xung nhịp tối đa lên tới 4.4 GHz cho khả năng đa nhiệm đáng kinh ngạc. Bên cạnh đó, máy được tích hợp card đồ họa Intel Iris Xe Graphics để mang đến trải nghiệm chơi game 1080p 60FPS hiệu quả mà không cần đầu tư thêm card rời. 
Pin 3-cell 42 WHrs sử dụng bền bỉ
Laptop Asus Vivobook 15 X1504ZA-NJ517W sử dụng pin Li-ion 3S1P 42 WHrs cho thời gian sử dụng sau mỗi lần sạc lâu và tiết kiệm năng lượng. Bên cạnh đó, sản phẩm cũng được bố trí các cổng kết nối thông dụng để người dùng chia sẻ dữ liệu nhanh chóng mà không cần sử dụng thêm hub chuyển đổi rời:

-   1 cổng USB 2.0 Type-A. 

-   1 cổng USB 3.2 Gen 1 Type-C.

-   2 cổng USB 3.2 Gen 1 Type-A.

-   1 cổng HDMI loại 1.4.

-   1 nguồn vào DC. 
Màn hình FullHD 15.6 inch anti–glare sắc nét
Máy có màn hình FHD đạt chứng nhận TÜV Rheinland với độ phân giải 1920*1080 cùng kích thước 15.6 inch cho vùng hiển thị rộng. Tần số làm mới 60Hz phù hợp để phục vụ nhu cầu giải trí cơ bản và chơi các tựa game có cấu hình trung bình - thấp. Công nghệ Anti-glare kết hợp với độ sáng tối đa 250 nits cho phép bạn làm việc ngoài trời hiệu quả mà không bị lóa hay chói mắt. ', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (2, N'Laptop ASUS TUF Gaming A15 FA506NFR-HN006W
', 1, N'china', CAST(20.00 AS Decimal(10, 2)), CAST(17990000.00 AS Decimal(10, 2)), 30, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_14__6_64.png', N'16', N'R7-7435HS', N'Laptop Asus TUF Gaming A15 FA506NFR-HN006W mang tới hiệu suất vượt trội khi được trang bị bộ đôi CPU AMD Ryzen 7 7435HS và GPU NVIDIA GeForce RTX 2050. Kèm theo đó là 1 thanh RAM DDR5 16G cùng ổ cứng SSD 512G được trang bị sẵn để mang tới khả năng thực hiện tác vụ đa nhiệm mượt mà. Mẫu laptop gaming Asus này còn mang tới lợi thế trong các trận game khi được trang bị màn hình 15.6 inch FHD có tần số quét 144Hz.
Laptop Asus TUF Gaming A15 FA506NFR-HN006W - Hiệu năng vượt trội, đồ hoạ mãn nhãn
Laptop Asus TUF Gaming A15 FA506NFR-HN006W là mẫu laptop gaming sở hữu tốc độ xử lý mạnh mẽ cùng khả năng xử lý đồ hoạ ấn tượng. Bất kể người dùng trong chơi game, chỉnh sửa hình ảnh, render video, lập trình, dựng mô hình 3D,...mẫu laptop Asus TUF này cũng có thể đảm bảo mang tới khả năng vận hành mượt mà, ổn định.

Hiệu suất vượt trội với bộ đôi CPU AMD, GPU NVIDIA GeForce
Laptop Asus TUF Gaming A15 FA506NFR-HN006W được trang bị bộ vi xử lý Ryzen 7 7435HS của AMD để mang tới sức mạnh đúng nghĩa một chiếc laptop gaming. Với 8 nhân 16 luồng, con chip Ryzen 7 này có tốc độ ép xung cơ bản ở mức 3.1GHz và có thể đạt tối đa 4.5GHz. Nhờ vậy mà mọi tác vụ từ cơ bản tới nâng cao đều có thể được xử lý một cách nhanh chóng trên mẫu laptop gaming TUF của Asus.Ngoài con chip, Asus TUF Gaming A15 FA506NFR-HN006W còn được nâng cấp sức mạnh với card đồ hoạ rời NVIDIA GeForce RTX 2050. Mẫu VGA rời của NVIDIA này sở hữu công nghệ dò tia trứ danh và hiệu ứng Ray Tracing để mang tới trải nghiệm hình ảnh mãn nhãn. Không chỉ dừng lại ở đó, đây sẽ còn là một trợ thủ đáng tin cậy giúp người dùng xử lý hiệu quả các tác vụ liên quan tới công việc như chỉnh sửa hình ảnh, dựng mô hình 3D, render video,...
Mượt mà trong đa nhiệm, thoải mái trong lưu trữ
Laptop Asus TUF Gaming A15 FA506NFR-HN006W được trang bị sẵn 1 thanh RAM chuẩn DDR5 có dung lượng 16GB. Với băng thông rộng hơn, thiết bị sẽ có được không gian xử lý đa nhiệm lý tưởng cho các nhu cầu nâng cao. Với tổng cộng 2 khe RAM, mỗi khe RAM hỗ trợ dung lượng tối đa 32GB, người dùng còn có thể chủ động nâng cấp trong quá trình sử dụng để đáp ứng yêu cầu công việc, giải trí.
Ổ cứng SSD 512GB bên trong laptop TUF A15 FA506NFR-HN006W còn mang tới một không gian lưu trữ thoải mái cho người dùng. Kèm theo đó là tốc độ truy xuất dữ liệu cao để người dùng không chỉ thoải mái cài đặt, lưu trữ mà còn tối ưu được quá trình khởi động laptop, khởi chạy các phần mềm.
Thiết kế mạnh mẽ, chuẩn gaming
Laptop Asus TUF Gaming A15 FA506NFR-HN006W được thiết kế với vẻ bề ngoài mạnh mẽ, mang đậm dấu ấn của dòng laptop gaming. Phần vỏ ngoài của laptop sử dụng màu sắc Graphite Black cùng hoạ tiết phay xước giúp tạo nên sự thu hút kể cả khi không trang bị thêm các dải LED RGB. Với trọng lượng 2.3kg, người dùng sẽ có thể mang theo laptop đi theo bất kỳ nơi đâu mà không gặp quá nhiều bất tiện.
Lợi thế hơn với màn hình FHD 144Hz
Laptop Asus TUF Gaming A15 FA506NFR-HN006W sẽ tạo lợi thế lớn cho các game thủ trong những trận đấu của mình nhờ việc sở hữu màn hình có kích thước và tần số quét lớn. Màn hình 15.6 inch sử dụng tỷ lệ 16:9 mang tới một không gian hiển thị lớn. Với độ phân giải FHD và chuẩn màu 45% NTSC, hình ảnh và các ký tự sẽ được thể hiện đầy đủ, sắc nét và sống động.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (3, N'Laptop Lenovo LOQ 15IAX9 83GS001RVN', 2, N'china', CAST(20.00 AS Decimal(10, 2)), CAST(20490000.00 AS Decimal(10, 2)), 20, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_15__7_14.png', N'12', N'I5-12450HX', N'Laptop Lenovo LOQ 15IAX9 83GS001RVN được trang bị bộ xử lý Intel Core i5-12450HX với 8 lõi, 12 luồng cùng RAM DDR5-4800 cho khả năng đa nhiệm ấn tượng. Ổ cứng SSD 512GB chuẩn kết nối PCIe rút ngắn thời gian truy xuất dữ liệu và có thể nâng cấp với lên đến 1TB. Màn hình 15.6 inch cho vùng hiển thị rộng và tốc độ phản hồi nhanh nhờ tần số quét 144Hz. Sản phẩm laptop Lenovo Gaming trang bị đầy đủ cổng giao tiếp để kết nối với nhiều thiết bị ngoại vi. 
Laptop Lenovo LOQ 15IAX9 83GS001RVN: hiệu năng mạnh mẽ, màn hình hiển thị sắc nét
Nếu bạn đang tìm kiếm mẫu laptop gaming được trang bị CPU tối thiểu Core i5 với thiết kế đẹp mắt thì đừng bỏ qua LOQ 15IAX9 83GS001RVN. Sản phẩm đến từ thương hiệu Lenovo tích hợp nhiều công nghệ tân tiến hứa hẹn sẽ mang lại cho bạn trải nghiệm chiến game mượt mà và sống động. 

CPU Intel Core i5 chiến game cực đã
Laptop Lenovo LOQ 15IAX9 83GS001RVN sở hữu CPU Core i5-12450HX thuộc thế hệ thứ 12 của Intel, được sản xuất trên tiến trình tân tiến. Chipset này bao gồm 8 nhân 12 luồng, trong đó có 4 nhân hiệu quả cao E-Core và 4 nhân hiệu năng cao P-Core. Nhờ vậy, bạn có thể chạy đa nhiệm mượt mà và cải thiện hiệu suất công việc đáng kể chỉ với một thiết bị. Card đồ hoạ RTX 3050 với dung lượng 6GB thoả mãn nhu cầu chơi game trên laptop, từ các tựa game thịnh hành cho tới những phần mềm thiết kế đồ hoạ yêu cầu cấu hình cao. So với card 1650 thì sức mạnh của RTX 3050 đã được nâng cấp tới 30%. Không những vậy, mẫu card này mang lại cho Lenovo LOQ 15IAX9 83GS001RVN nhiều công nghệ hiện đại như DLSS, Ray Tracing,... để trải nghiệm game thêm phần chân thực.

SSD 512GB chuẩn kết nối PCIe tốc độ cao 
Dòng laptop Lenovo LOQ này được trang bị ổ cứng SSD PCIe giúp tăng tốc độ khởi động các ứng dụng và tối ưu thời gian truy xuất dữ liệu. Với dung lượng 512GB, thiết bị cho phép bạn giải trí và tải xuống nhiều tệp tin với độ phân giải cao mà không cần bổ sung ổ đĩa phụ. Nhờ vậy, việc lưu trữ các tựa game và tài liệu sẽ trở nên nhanh chóng và thuận tiện hơn. Bạn cũng có thể mở rộng bộ nhớ lên đến 1TB khi có nhu cầu.
RAM DDR5-4800 12GB cung cấp tốc độ xung bus cực cao lên tới 4800MT/giây cùng khả năng tăng băng thông lên tới 36%. Nhờ đó, Lenovo LOQ 15IAX9 83GS001RVN được cải thiện thông lượng dữ liệu tuần tự, đồng thời, tối ưu hoá các bộ xử lý cũng như nền tảng thế hệ mới. Không những vậy, bộ RAM này còn hỗ trợ giảm năng lượng tiêu thụ, đồng thời kéo dài tuổi thọ pin máy. 

Thiết kế gaming mang đậm phong cách Legion series
LOQ 15IAX9 83GS001RVN gây ấn tượng nhờ kiểu dáng tương đồng dòng Legion với hốc tản nhiệt rộng và độ dày mặt sau máy. Bản lề màn hình của chiếc laptop gaming này được thiết kế trang nhã, tạo điểm nhấn thu hút cho sản phẩm. So với người anh em Legion, LOQ 15IAX9 83GS001RVN có phần nhẹ hơn với trọng lượng khoảng 2.38 kg. Bên cạnh đó, sản phẩm vẫn sử dụng bàn phím White Backlit, giúp người dùng có thể làm việc và nhìn rõ phím ngay ở nơi có ít ánh sáng. Touchpad Buttonless Mylar surface multi-touch kích thước 75*120 mm mang đế trải nghiệm sử dụng chuột tự nhạy với vùng chạm rộng rãi. 
Màn hình sáng 300nits, tần số quét 144Hz mượt mà
Lenovo LOQ 15IAX9 83GS001RVN ghi điểm với màn hình sử dụng tấm nền IPS 15.6 inch cùng độ phân giải FHD sắc nét. Độ sáng tối đa lên tới 300nits Anti-glare có hỗ trợ G-SYNC kết hợp với tần số quét 144Hz hứa hẹn sẽ mang tới trải nghiệm chiến game chân thực và mượt mà ở mọi môi trường. Màn hình máy được đánh giá là ổn định khi thử nghiệm trên các tựa game eSport cũng như game AAA với tốc độ làm tươi ấn tượng, hạn chế độ trễ tốt.  ', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (4, N'Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN', 2, N'china', NULL, CAST(22490000.00 AS Decimal(10, 2)), 21, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_59__1_14.png', N'16', N'U7-155H', N'Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN xử lý mượt mà mọi tác vụ công việc và giải trí nhờ sự kết hợp CPU Qualcomm Snapdragon X Plus kèm RAM 16GB. Cùng với đó, ổ cứng SSD PCIe dung lượng 512GB cũng hỗ trợ tăng cường tốc độ truy xuất và không gian lưu trữ. Ngoài ra, màn hình WUXGA 14 inch còn giúp người dùng thưởng thức nội dung chi tiết, rõ ràng. 
Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN – Thoải mái trải nghiệm văn phòng
Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN là chiếc laptop văn phòng lý tưởng với nhiều tính năng hiện đại. Nổi bật qua các thông số đặc điểm ưu trội, phiên bản laptop Lenovo IdeaPad này rất thích hợp để chinh phục tối ưu nhu cầu sử dụng.

Dung lượng RAM lớn, ổ cứng chuẩn SSD
Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN mang trong mình bộ RAM dung lượng 16GB cho khả năng đa nhiệm mượt mà hay khởi động cùng lúc nhiều trình duyệt, mà không bị giật lag. Loại RAM LPDDR5x-8448 này cho phép laptop dễ dàng xử lý khối lượng công việc nặng như thiết kế đồ họa, chơi game hay chỉnh sửa video 4K với hiệu suất ở mức tối ưu.Bên cạnh đó, ổ cứng SSD PCIe NVMe cũng góp phần đẩy tốc độ đọc ghi dữ liệu, nhằm tiết kiệm thời gian truyền tải tài liệu, hình ảnh. Đồng thời với không gian lưu trữ lên đến 512GB, người dùng có thể cài đặt các phần mềm, dữ liệu theo nhu cầu, không lo gặp gián đoạn.
Thiết kế mỏng gọn, màu tươi trẻ
Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN được thiết kế gọn gàng với độ mỏng đáng kinh ngạc. Đi cùng là lớp vỏ kim loại chất lượng cao, tạo nên diện mạo đẳng cấp và bền bỉ. Thêm vào đó, trọng lượng của máy khá nhẹ cũng giúp người dùng di chuyển theo bên mình và sử dụng ở mọi lúc mọi nơi.Phần bàn phím của máy được bố trí khoa học với hành trình phím hợp lý, nhằm đem đến trải nghiệm gõ chính xác, thoải mái. Kết hợp Touchpad rộng, đa điểm giúp hỗ trợ điều khiển các cử chỉ trực quan. Ngoài ra, chiếc laptop này cũng khoác lên màu sắc trẻ trung, thời thượng theo phong cách xu hướng hiện nay của người dùng. 
CPU xử lý tốt, GPU đồ họa cao
Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN sở hữu chip Snapdragon X Plus cung cấp hiệu năng mạnh mẽ để đáp ứng tốt các nhu cầu giải trí, làm việc. Dựa trên quy trình tiên tiến, bộ vi xử lý này mang đến hiệu suất hoạt động ấn tượng trên mọi tác vụ. Người dùng có thể thực hiện đa nhiệm nhanh chóng hay chạy các ứng dụng nặng, chơi game (*) ở mức cài đặt trung bình một cách dễ dàng.Hơn thế nữa, laptop tích hợp thêm GPU Qualcomm Adreno đảm bảo trải nghiệm hình ảnh sắc nét, mượt mà khi làm việc với những phần mềm đồ họa 2D hoặc xem phim. Cộng thêm sự có mặt của NPU 45 TOPS đạt chẩn Copilot+PC hỗ trợ các tác vụ AI chuyên nghiệp.

Pin chạy lâu, kết nối đa dạng
Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN nổi bật với thời lượng pin có thể đáp ứng nhu cầu sử dụng liên tục. Thông qua viên pin dung lượng 57Wh, chiếc laptop này sẽ đồng hành cùng người dùng suốt hàng tiếng đồng hồ làm việc, giải trí.Bên cạnh đó, máy cũng được trang bị cổng giao tiếp đầy đủ theo các chuẩn thông dụng như USB-C, USB-A, khe cắm microSD,… Điều này cho phép laptop kết nối với nhiều thiết bị khác theo yêu cầu sử dụng. Mặt khác, laptop còn tạo điều kiện thuận lợi để kết nối không dây qua công nghệ Wi-Fi 6E, Bluetooth 5.2 đường truyền ổn định.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (5, N'Apple MacBook Air M2', 3, N'china', NULL, CAST(22890000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/macbook_air_m2_1_1_1.jpg', N'8', N'M2', N'Apple Macbook Air M2 2024 16GB 256GB thiết kế siêu mỏng 1.13cm, trang bị chip M2 8 nhân GPU, 16 nhân Neural Engine, RAM khủng 16GB, SSD 256GB, màn hình IPS Liquid Retina Display cùng hệ thống 4 loa cho trải nghiệm đỉnh cao.

Apple Macbook Air M2 2024 16GB 256GB – Nội lực siêu việt, ngoại hình đẳng cấp
Apple Macbook Air M2 2024 16GB 256GB không chỉ sở hữu ngoại hình siêu mỏng trong thiết kế đẳng cấp và lịch lãm mà còn sở hữu nguồn sức mạnh vượt trội khi được trang bị con chip Apple M2. Đây chính là một thiết bị tuyệt hảo đồng hành cùng bạn trong công việc cũng như giải trí.

Hiệu suất ấn tượng, mạnh mẽ hàng đầu từ chip Apple M2
Điểm ấn tượng trên Macbook Air 13 inch đó chính là được trang bị con chip Silicon M2 thế hệ mới với 8 nhân GPU, 16 nhân Neural Engine. Con chip này sẽ giúp nâng cao hiệu suất so với thế hệ trước, nâng cấp nguồn sức mạnh để mang đến khả năng xử lý tuyệt vời.

Những tác vụ nặng, các phần mềm đồ họa, chỉnh sửa video có chất lượng 4K hay 8K đều có thể được xử lý mượt mà trên Macbook Air M2. Bên cạnh đó, con chip M2 còn giúp tối ưu hiệu suất để có thể giảm bớt năng lượng tiêu thụ, giúp tiết kiệm pin tốt hơn.Đồng thời, chipset mới cũng đi kèm với giao diện được nâng cấp với những icon được tinh giản, các thông báo hay trình quản lý thông báo cũng có thể dễ dàng thiết lập để trở nên dễ theo dõi và điều chỉnh hơn.

Chạy đa nhiệm cực mướt với RAM 16GB, lưu trữ tốc độ cao với SSD 256GB
Không chỉ mang đến nguồn sức mạnh vượt trội, Apple Macbook Air M2 2024 16GB 256GB còn có khả năng xử lý đa nhiệm tốc độ cao khi được trang bị RAM khủng 16GB. Bạn hoàn toàn có thể dễ dàng sử dụng nhiều phần mềm cùng lúc, lướt web với nhiều tab mà không lo giật lag.Cùng với đó, bạn cũng có thể thoải mái cài đặt vô vàn ứng dụng cũng như lưu trữ lượng dữ liệu lớn, xử lý dữ liệu với tốc độ đọc ghi nhanh chóng nhờ ổ cứng SSD 256GB. 

Apple Macbook Air M2 2024 16GB 256GB sang trọng, màn hình 13.6 inch sắc nét
Apple Macbook Air M2 phiên bản 16GB 256GB không chỉ có cấu hình mạnh mẽ siêu việt mà còn đi đôi với thiết kế đẳng cấp, sang trọng. Máy siêu mỏng nhẹ khi có độ mỏng chỉ 1.13cm cùng trọng lượng 1.27kg cùng chất liệu vỏ nhôm bền bỉ để giúp bạn thuận tiện di chuyển linh hoạt.Bên cạnh đó máy cũng được trang bị màn hình 13.6 inch hiển thị đỉnh cao với tấm nền IPS cùng công nghệ Liquid Retina 1 tỷ màu và độ sáng 500 nits, dải màu P3 cùng True Tone cho hiển thị sắc nét, màu sắc sống động với độ tương phản phong phú, hình ảnh có chiều sâu.

Tích hợp 3 microphones, 4 loa cho âm thanh sống động, đàm thoại chất lượng
Apple Macbook Air M2 2024 16GB 256GB còn được tích hợp 3 microphones cùng với hệ thống 4 loa cho âm thanh sống động cũng như cho khả năng đàm thoại trực tiếp với chất lượng âm thanh rõ ràng, sắc nét.
', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (6, N'Apple MacBook Air M1', 3, N'china', NULL, CAST(17490000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/m/a/macbook-air-m1-2020-gold-600x600.jpg', N'8', N'M1', N'Macbook Air M1 2020 - Sang trọng, tinh tế, hiệu năng khủng
Macbook Air M1 là dòng sản phẩm có thiết kế mỏng nhẹ, sang trọng và tinh tế cùng với đó là giá thành phải chăng nên MacBook Air đã thu hút được đông đảo người dùng yêu thích và lựa chọn. Đây cũng là một trong những phiên bản Macbook Air mới nhất mà khách hàng không thể bỏ qua khi đến với CellphoneS. Dưới đây là chi tiết về thiết kế, cấu hình của máy.
Thiết kế tinh tế, chất liệu nhôm bền bỉ
Macbook Air 2020 M1 mới vẫn luôn tuân thủ triết lý thiết kế với những đường nét đơn nhưng vô cùng sang trọng. Máy có độ mỏng nhẹ chỉ 1,29kg và các cạnh tràn viền khiến thiết bị trở nên đẹp hơn và cao cấp hơn.Vỏ nhôm bên ngoài mang đến sự bền bỉ vượt trội theo thời gian. Các cổng vẫn được thiết kế tương tự như phiên bản trước đó được ra mắt hồi tháng 3 năm 2020.
Màn hình Retina 13.3 inch tráng gương
MacBook Air M1 256GB 2020 được trang bị màn hình Retina IPS 13.3 inch mang đến nhiều màu sắc hơn lên đến 48% so với những thế hệ trước đó. Bên cạnh đó, màn hình tráng gương tràn viền khiến viền giúp mỏng hơn 50% so với trước đây.Với độ phân giải 2560 x 1600 và tỉ lệ khung hình 16:10 với 227 ppi giúp hình ảnh trở nên rõ nét và sống động hơn bao giờ hết. Ngoài ra, công nghệ True Tone trên máy tự động điều chỉnh cân bằng trắng giúp phù hợp với nhiệt độ màu của ánh sáng xung quanh và mang đến không gian màu rộng hơn 25% so với sRGB.
Chip M1, hiệu năng cực đỉnh
Điểm nhấn của MacBook Air 13 inch phiên bản 256GB 2020 chính là con chip M1. CPU của chip M1 sẽ có 8 nhân, bao gồm 4 nhân hiệu suất cao và 4 nhân hiệu suất thấp mang đến sức mạnh vượt trội cho thiết bị rất. Sức mạnh trên M1 256GB hơn 98% so với các laptop Windows và hiệu năng vượt trội hơn so với các phiên bản Air sử dụng chip Intel.RAM 8GB và card đồ họa VGA 7-core GPU giúp máy có thể xử lý nhanh chóng các tác vụ hằng ngày. Ngoài ra với việc trang bị ổ cứng SSD dung lượng 256GB sẽ cho người dùng tốc độ đọc, sao chép, ghi cực nhanh so với ổ HDD thông thường.
Bàn phím Magic Keyboard, Touch ID tiện lợi
Macbook Air M1 2020 được trang bị bàn phím Magic Keyboard trên cơ chế cắt chéo với bước phím chỉ 1mm. Máy có phím Esc vật lý đồng thời cụm phím mũi tên được bố trí theo kiểu chữ "T" đảo ngược. Với thiết kế này mang lại cho người dùng trải nghiệm đánh máy chính xác, êm ái và vô cùng thoải mái.Touch ID được tích hợp vào MacBook Air mang đến độ bảo mật cao, an toàn tuyệt đối. Chỉ cần đặt ngón tay vào cảm biến Touch ID sẽ giúp máy tính MacBook Air mở khóa dễ dàng. Sử dụng vân tay để truy cập vào các tài liệu, ghi chú đồng thời thiết lập hệ thống đã khóa.

Bên cạnh đó,bạn cũng có thể sử dụng Apple Pay để thanh toán an toàn và tiện dụng khi mua sắm trực tuyến. Các thao tác nhập thông tin giao hàng hay hóa đơn, hay các chi tiết thẻ của bạn sẽ được bảo mật tuyệt đối.
Thunderbolt 3 giúp kết nối dễ dàng, thời lượng pin ấn tượng
MacBook Air M1 256GB 2020 kết nối dễ dàng với các thiết bị bằng Thunderbolt. Đây là giao diện phần cứng được tận dụng cổng USB Type-C thuận nghịch mang đến đôi tốc độ gấp đôi so với người tiền nhiệm. Cổng còn hỗ trợ USB4, cho phép kết nối với nhiều thiết bị ngoại vi hơn, kể cả màn hình Apple Pro Display XDR có độ phân giải cao nhất là 6K.Do sử dụng chip M1 rất ít tỏa nhiệt, nên máy rất tiết kiệm điện năng mang lại khả năng tối ưu pin và thời gian sử dụng. Bạn có thể thoải mái lướt web trong vòng 15 tiếng và 18 tiếng xem video mà không lo hết pin.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (7, N'Laptop Dell Inspiron 15 3520-5810BLK 102F0', 4, N'china', NULL, CAST(12790000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_6_39.png', N'8', N'I5-1155G7', N'Laptop Dell Inspiron 15 3520-5810BLK 102F0 trang bị con chip Core i5-1155G7 thế hệ 11 với hiệu năng ấn tượng, 8GB RAM nâng cấp tối đa đến 16GB thoải mái lưu trữ. Laptop Dell Inspiron 15 3520-5810BLK 102F0 cảm ứng với thiết kế nhỏ gọn, trọng lượng chỉ 1.9kg , màn hình 15.6 inch chất lượng Full HD cực rõ nét.
Laptop Dell Inspiron 15 3520-5810BLK 102F0 - Kết hợp hoàn hảo thiết kế hiện đại và hiệu năng mạnh mẽ
Là chiếc laptop Dell Inspiron tầm trung, Dell Inspiron 15 3520-5810BLK 102F0 gây ấn tượng với thiết kế màn hình cảm ứng thời thượng và hiệu năng mạnh mẽ, xử lý tác vụ êm mượt với Core i5-1155G7.

Intel core i5 thế hệ 11 cùng 8GB ram xử lý tốt mọi tác vụ
Không chỉ được đánh giá cao ở thiết kế, Dell Inspiron 15 3520-5810BLK 102F0 còn dễ dàng chinh phục mọi ứng dụng nặng nề với con chip intel Core i5-1155G7 4 nhân 8 luồng cùng xung nhịp tối đa lên đến 4.2Ghz. Kết hợp với một dòng CPU thế hệ mới, máy còn được trang bị 8GB RAM cùng khả năng nâng cấp tối đa lên đến 16GB. Do đó người dùng hoàn toàn có thể yên tâm rằng chiếc laptop này có thể xử lý tốt nhiều phần mềm cùng lúc mà không lo bị tràn ram.

Thiết kế thời thượng, bền bỉ
Được xem là mẫu laptop dành cho dân văn phòng hay học sinh, sinh viên Dell Inspiron 15 3520-5810BLK 102F0 sử dụng chất liệu cao cấp cho phần mặt lưng để vừa đảm bảo giữ được trọng lượng nhẹ chỉ 1.9kg lại vừa đạt được độ cứng cáp cần thiết. Với thiết kế mang hơi hướng tối giản lấy tông màu đen làm chủ đạo, chiếc laptop Dell Inspiron chắc chắn sẽ là sự lựa chọn phù hợp với đại đa số người dùng cần một thiết bị để phục vụ nhu cầu học tập, làm việc.
Đa dạng cổng kết nối
Được đánh giá là chiếc laptop văn phòng tầm trung, Dell Inspiron 15 3520-5810BLK 102F0 đáp ứng hầu hết các nhu cầu văn phòng cơ bản, không chỉ bởi hiệu năng và thiết kế mà còn bởi khả năng kết nối với các thiết bị ngoại vi. Dell Inspiron 15 3520-5810BLK 102F0 hỗ trợ đa dạng các cổng giao tiếp như cổng HDMI, cổng USB 2.0, USB 3.0, Jack cắm tai nghe 3.5mm và khe SD,... sẵn sàng kết nối với các thiết bị văn phòng như máy chiếu, loa, tivi,... và các loại phụ kiện khác.
Bàn phím & touchpad độ nhạy cao - Nâng cao chất lượng giải trí, làm việc
Dell Inspiron 15 3520-5810BLK 102F0 được trang bị hệ thống bàn phím có độ nảy cao, hành trình phím được sắp xếp hợp lý và dùng bền, phù hợp cho các công việc văn phòng soạn thảo văn bản, giúp nâng cao hiệu suất công việc.

Touchpad có độ nhạy cực ấn tượng, cho phép thao tác dễ dàng và nhanh chóng, hạn chế các tình trạng lờn phím, click không nhạy,... từ đó cho trải nghiệm thao tác hoàn hảo hơn, giây phút giải trí trọn vẹn hơn.

Thỏa sức giải trí trên màn hình 15.6 inch Full HD hỗ trợ cảm ứng
Chất lượng hình ảnh là một trong các tiêu chí quan trọng nhất khi chọn mua laptop. Dell Inspiron 15 3520-5810BLK 102F0 sở hữu chất lượng hiển thị được đánh giá khá tốt nhờ độ phân giải lên đến Full HD cùng góc nhìn rộng nhờ vào công nghệ tấm nền Wide-viewing angle (WVA).Ngoài ra màn hình cảm ứng được tích hợp trên Dell inspiron 15 còn được xem là một tính năng vô cùng hữu ích đối với những người dùng hay sử dụng các tác vụ đồ họa. Màn hình cảm ứng có thể được sử dụng như một chiếc bảng vẽ giúp việc thiết kế trở nên nhanh chóng và đơn giản hơn bao giờ hết.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (8, N'Laptop Dell Inspiron 15 3520 6R6NK', 4, N'china', NULL, CAST(13490000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_5__7_47.png', N'8', N'I5-1235U', N'Laptop Dell Inspiron 15 3520 6R6NK sở hữu cấu hình đáp ứng tốt các nhu cầu làm việc văn phòng, học tập khi được trang bị con chip Intel Core i5 1235U, 8GB RAM cùng bộ nhớ trong 512GB. Màn hình 15.6 inch FHD của laptop còn được Dell tích hợp tần số quét nâng cao 120Hz để phục vụ tốt cho các cả hoạt động giải trí. Mẫu laptop Dell Inspiron này còn được tối giản số lượng cổng kết nối để đảm bảo được độ mỏng nhẹ và vẻ ngoài thanh lịch.
Laptop Dell Inspiron 15 3520 6R6NK - Hiệu năng ổn định, trải nghiệm mượt mà trong công việc và giải trí
Laptop Dell Inspiron 15 3520 6R6NK là mẫu laptop được tối ưu dành cho công việc văn phòng và học tập. Không chỉ đảm bảo được tốc độ xử lý ổn định để phục vụ công việc, mẫu laptop của Dell này sẽ còn đảm bảo người dùng có được những phút giây giải trí trọn vẹn nhất sau những giờ làm việc, học tập căng thẳng.

Khả năng xử lý đa tác vụ mượt mà, lưu trữ thoải
Laptop Dell Inspiron 15 3520 6R6NK được trang bị sẵn 8GB RAM DDR4 để đảm bảo các hoạt động đa nhiệm luôn diễn ra mượt mà. Dell còn trang bị cho laptop Inspiron 15 3520 6R6NK tới 2 khe RAM DDR4 để người dùng chủ động mở rộng tối đa tới 16GB nhằm đáp ứng tốt hơn cho công việc. Nhờ vậy mà sản phẩm sẽ luôn có thể phục vụ tốt nhu cầu người dùng sau thời gian dài sử dụng.Không chỉ có dung lượng RAM lớn, Dell Inspiron 15 3520 6R6NK còn có dung lượng bộ nhớ trong lớn. Nhờ việc sử dụng dòng ổ cứng này mà tốc độ khởi động hệ điều hành, phần mềm cũng như khả năng đồng độ, truy xuất dữ liệu trên laptop Inspiron 15 3520 6R6NK của Dell cũng sẽ được cải thiện để người dùng dễ dàng xử lý các tập tin có kích thước lớn.

Ngoại hình hiện đại, cá tính và thanh lịch
Laptop Dell Inspiron 15 3520 6R6NK sở hữu một ngoại hình khác biệt so với thiết kế có nét đặc trưng riêng của dòng Inspiron. Thay vì sử dụng lớp vỏ nhôm phủ sơn bạc, Dell Inspiron 15 3520 6R6NK lại có cho mình phần vỏ ngoài cứng cáp, phủ sơn đen. Điều này giúp giảm trọng lượng cũng như mang tới một vẻ ngoài hiện đại, nổi bật và không kèm phần thanh lịch cho chiếc laptop văn phòng của Dell.Ngoài ra, Dell Inspiron 15 3520 6R6NK còn được trang bị bản lề bền bỉ Phần bản lề này sẽ mở rộng góc nhìn và tạo ra một góc nghiêng vừa đủ để mang tới sự thoải mái cho người dùng trong quá trình gõ phím. Đồng thời, thiết kế bản lề này cũng sẽ hỗ trợ để nâng cao hiệu quả tản nhiệt, giúp laptop duy trì được nhiệt độ ổn định trong quá trình xử lý các tác vụ nặng.

Tốc độ xử lý ổn định với CPU Intel Core i5 Gen 12th
Laptop Dell Inspiron 15 3520 6R6NK được trang bị bộ vi xử lý Intel Core i5 1235U, với khả năng duy trì hiệu suất ổn định và đồng thời tối ưu điện năng tiêu thụ. Nhờ vậy mà người dùng sẽ luôn có được trải nghiệm mượt mà với mọi phần mềm văn phòng như Word, Excel, Powerpoint, Photoshop,...hay nặng hơn như các tựa game League of Legend, DOTA 2, Valorant,...Một trong những yếu tố giúp đảm bảo được sự mượt mà này đó là nhờ vào card đồ họa Intel UHD. GPU tích hợp này sẽ đảm bảo Dell Inspiron 15 3520 6R6NK có thể xuất hình ảnh với độ phân giải tối đa ở mức 4K cũng như xử lý tốt các tác vụ đồ họa trong công việc và giải trí.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (9, N'Laptop Gaming Acer Nitro V ANV15-51-58AN', 5, N'china', NULL, CAST(15990000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_9__4_4.png', N'8', N'I5-13425H', N'Laptop Acer Nitro V mang một thiết kế gaming mạnh mẽ, màn hình 15.6” 144Hz FHD, cấu hình cân mọi tựa game với chip i5-13420H từ Intel. Bên cạnh đó, dòng laptop này còn được tích hợp GPU GeForce RTX 2050, RAM 8GB và lưu trữ khổng lồ với SSD 512GB tốc độ cao giúp mang lại trải nghiệm vượt trội cho người dùng.
Laptop Acer Nitro V – Cấu hình mạnh mẽ, đậm chất chiến binh
Laptop Acer Nitro V ANV15 là mẫu laptop quốc dân vừa cân mọi tựa game, vừa có thể làm việc với hiệu suất tối ưu khi được trang bị cấu hình mạnh mẽ từ chip Intel thế hệ 13 mới nhất. Cùng đó laptop Acer Nitro này còn được kết hợp GPU GeForce RTX 2050, màn hình 15.6” FHD có tần số 144Hz mang lại trải nghiệm chơi game chân thực cho bạn.

Nitro V ANV15 Chinh phục trận đấu với hiệu năng ấn tượng
Nguồn nội lực mạnh mẽ của laptop Acer Nitro V đến từ vi xử lý Intel Core Gen 13th i5-13420H cung cấp nguồn sức mạnh vượt trội để laptop có thể cân tốt mọi tựa game, mọi tác vụ một cách nhanh chóng. Nhờ đó, bạn có thể dễ dàng khởi động laptop một cách nhanh chóng, đảm bảo các tác vụ được hoạt động một cách mượt mà.
Acer Nitro V được trang bị con Chip Intel thế hệ 13 với 8 nhân 12 luồng sẽ cung cấp sức mạnh cho bạn tận hưởng các tựa game từ AAA đến các game Esport một cách mượt. Đồng thời, khi sử dụng dòng laptop gaming này, bạn có thể thoải mái chạy các phần mềm đồ họa nặng mà không cần lo bị giật lag. Từ đó, laptop Acer đã góp phần mang lại những trải nghiệm sử dụng ấn tượng cho nhiều người dùng.

Nitro V ANV15 xử lý đồ họa vượt trội với card NVIDIA GeForce RTX 2050
Cùng với chipset mạnh mẽ thì laptop Acer Nitro V còn kết hợp với GPU NVIDIA GeForce RTX 2050 giúp xử lý đồ họa mượt mà, tối ưu. Nhờ đó, laptop gaming hiển thị hình ảnh sắc nét, chi tiết, mượt mà, mang lại trải nghiệm chơi game chân thật, ấn tượng cho người dùng.Card đồ họa RTX 2050 của laptop Acer Nitro V cho sức mạnh vượt trội giúp người dùng hoàn toàn có thể yên tâm về những trải nghiệm về mặt xử lý hình ảnh của laptop luôn được thực hiện nhanh chóng.

Nitro V ANV15-51-58AN với Dual-Fan Cooling tản nhiệt tối ưu
Đối với một laptop gaming thì việc tản nhiệt là vô cùng quan trọng giúp đảm bảo nhiệt độ duy trì mát mẻ. Dòng laptop Acer Nitro V được ứng dụng công nghệ tản nhiệt vượt trội, giúp giữ laptop luôn mát mẻ để có thể vận hành cường độ cao hay chơi các game đồ họa nặng. Acer đã trang bị cho laptop Nitro V ANV15-51-58AN Dual-Fan Cooling để giúp tản nhiệt hiệu quả, duy trì hiệu năng vượt trội cho máy. Nhờ đó, khi sử dụng, chiếc laptop không bị quá nhiệt khi chơi game, làm việc trong thời gian dài.

Nitro V ANV15 có thể lưu trữ khổng lồ với SSD 512GB PCIe
Laptop Gaming Acer Nitro V còn được trang bị RAM 8GB DDR5 5200Mhz giúp chạy đa nhiệm một cách mượt mà cũng như tăng tốc các tác vụ của máy một cách tối ưu hơn, giúp bạn sử dụng máy để chơi game, làm việc cực mướt.Bên cạnh đó, máy cũng mang đến cho bạn một kho lưu trữ dữ liệu khổng lồ với ổ cứng SSD 512GB PCIe, hỗ trợ mở rộng với 2 khe cắm và cho phép bạn nâng cấp tối đa lên đến 2TB SSD lưu trữ siêu khủng.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (10, N'Laptop Acer Gaming Aspire 7 A715-76-53PJ', 5, N'china', NULL, CAST(13990000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_6_18.png', N'16', N'I5-12450H', N'Laptop Acer Gaming Aspire 7 A715-76-53PJ là chiếc laptop sở hữu cấu hình mạnh với bộ vi xử lý Intel Core thế hệ 12 và card đồ họa Intel UHD Graphics. Máy có màn hình 15.6 inch, độ phân giải Full HD (1920 x 1080), bộ nhớ RAM 16GB DDR4 và dung lượng lưu trữ SSD 512GB. Ngoài ra, máy còn được trang bị các cổng kết nối như HDMI, USB Type-C, USB 3.2 Gen 1 Type-A, RJ-45 và có khả năng chơi game tốt.
Laptop Acer Gaming Aspire 7 A715-76-53PJ - Chơi game đỉnh cao
Laptop Acer Gaming Aspire 7 A715-76-53PJ là một chiếc laptop Acer Aspire phổ thông hiệu năng cao hàng đầu trong phân khúc giá tầm trung. Sở hữu thiết kế trung tính phổ theo phong cách học tập - văn phòng nhưng Aspire 7 2023 vẫn đảm bảo cấu hình mạnh mẽ. Đáp ứng nhu cầu chơi game của người dùng với card đồ họa Intel® UHD Graphics chất lượng.

Laptop Acer Gaming Aspire 7 A715-76-53PJ vượt trội về hiệu năng
Với danh xưng là laptop gaming, laptop Acer Gaming Aspire 7 A715-76-53PJ đã được trang bị những yếu tố mà bắt buộc chiếc máy tính chơi game phải có. Với những điểm nổi bật này, Aspire 7 hoàn toàn có thể thu hút được nhiều người dùng.

Cấu hình mạnh mẽ với chip Intel thế hệ 12
Laptop Acer Gaming Aspire 7 A715-76-53PJ thật sự nổi bật trong phân khúc máy tính chơi game với CPU mạnh mẽ. Máy được trang bị bộ vi xử lý Intel® Core™ thế hệ 12, giúp đảm bảo hiệu năng xuất sắc cho cả công việc và giải trí.Bên cạnh đó, con máy còn sở hữu card đồ họa Intel® UHD Graphics tích hợp, với khả năng đáp ứng nhu cầu chơi game và xử lý đồ họa cơ bản. Tuy không phải là card đồ họa rời mạnh mẽ, nhưng nó đủ để người dùng tham gia vào thế giới ảo với mọi tựa game hot đang thịnh hành.

Bộ nhớ khổng lồ hỗ trợ tối đa cho người dùng
Để hỗ trợ cho sự mạnh mẽ của CPU và GPU, máy tính này cũng được trang bị 16GB RAM DDR4. Đây là sự kết hợp hoàn hảo giữa hiệu suất và dung lượng lưu trữ, máy sẽ đủ mạnh để xử lý cả công việc đa nhiệm và giải trí. Người dùng có thể mở nhiều ứng dụng hay trình duyệt cùng lúc mà không lo lắng gặp hiện tượng giật hình hay đơ.

Một điểm đáng khen ngợi khác là khả năng nâng cấp RAM lên tối đa 32 GB. Nhờ đó người dùng có thể linh hoạt hơn trong việc nâng cấp máy tính khi cần thiếtNgoài RAM, Acer Aspire 7 A715-76-53PJ còn trang bị một ổ cứng SSD 512GB. Ổ cứng này có tốc độ đọc và ghi nhanh chóng, giúp máy khởi động nhanh và các ứng dụng chạy mượt mà. Chúng cho phép người dùng tăng trải nghiệm sử dụng và giúp tiết kiệm thời gian trong quá trình làm việc và giải trí hiệu quả nhất.

Sự kết hợp của nét đẹp hiện đại và chất game
Acer Gaming Aspire 7 sở hữu một thiết kế đẹp, hiện đại với sự tạo dựng giữa tính chất văn phòng và gaming. Chiếc laptop thu hút sự chú ý từ cả người dùng làm việc và người chơi game.

Nắp máy được làm từ chất liệu nhôm màu xám cùng logo Acer nổi bật tạo nên vẻ sang trọng và bền bỉ. Các mặt còn lại của con máy này được làm bằng nhựa, mang đến sự cân bằng giữa trọng lượng và độ cứng. Điều này giúp máy trở nên nhẹ nhàng và dễ dàng mang theo mà vẫn đảm bảo tính chất gaming.Máy tính còn có một bàn phím có đèn nền, giúp bạn làm việc hoặc chơi game trong điều kiện thiếu sáng. Đèn nền bàn phím không chỉ tạo điểm nhấn mà còn giúp bạn dễ dàng thao tác trên bàn phím dù trong môi trường ánh sáng yếu. ', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (11, N'Laptop LG Gram 2023 14Z90R-G.AH53A5', 6, N'china', NULL, CAST(18990000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_-_2023-04-13t113426.787.png', N'16', N'I5-1340P', N'Laptop LG Gram 2023 14Z90R-G.AH53A5 - Sức mạnh hiệu quả cho công việc 
Laptop LG Gram 2023 14Z90R-G.AH53A5 là dòng laptop văn phòng có cấu hình tốt, thiết kế mỏng nhẹ nhã nhặn. Bạn có thể xem film, lướt web, thao tác các ứng dụng văn phòng khác như Microsoft Word, Powerpoint, Excel,...dễ dàng như mong muốn. Hãy xem những điểm mạnh khác của laptop LG Gram 2023 trong đoạn mô tả sau đây!

Đa nhiệm và lưu trữ tuyệt vời, thiết kế đỉnh 
Laptop LG Gram 2023 14Z90R-G.AH53A5 được tích hợp bộ RAM có dung lượng 16GB, thỏa sức đa nhiệm xử lý dữ liệu nhanh chóng cùng lúc. Ổ cứng lưu trữ SSD có không gian 256GB, đảm bảo đủ rộng để giữ lại các ứng dụng và dữ liệu cá nhân theo ý muốn.LG Gram 14Z90R-G.AH53A5 sở hữu ba gam màu sắc lạnh gồm xám, trắng và đen rất lịch sự nhã nhặn và sang trọng. Thiết kế mỏng nhẹ, kích thước 14 inch với viền hai bên siêu mỏng thích hợp cho đội ngũ nhân viên văn phòng.

Bộ xử lý thế hệ 13, đồ họa xứng tầm 
Tích hợp cho laptop là bộ xử lý Intel Core i5 thế hệ thứ 13, có sức mạnh giúp bạn vươn cao trong thế giới sáng tạo. Bạn có thể xử lý dữ liệu nhanh chóng đồng thời cùng một lúc, làm nhiều việc nhanh nhất có thể. Hỗ trợ hình ảnh cho laptop chính là Intel Iris Xe Graphics, card VGA này giúp cải tiến hiệu suất đồ họa máy tính lên tầm cao mới. Bạn có thể xử lý đồ họa tốt hơn, mượt mà hơn các phiên bản card VGA trước đó nhiều lần.

Sắm ngay Laptop LG Gram 2023 14Z90R-G.AH53A5 chính hãng giá tốt tại CellphoneS
Laptop LG Gram 2023 14Z90R-G.AH53A5 đã có mặt tại cửa hàng CellphoneS, giá cực tốt và rất thích hợp cho dân văn phòng. Kết nối ngay với chúng tôi nếu bạn muốn thăng tiến hơn trong công việc của mình nhé!', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (12, N'Laptop LG Gram 2024 14Z90S-G.AH55A5', 6, N'china', NULL, CAST(28990000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_23__2_34.png', N'16', N'U5-125H', N'Laptop LG Gram 2024 14Z90S-G.AH55A5 ấn tượng bởi hiệu quả xử lý ưu trội qua bộ chip Intel Core Ultra 5, kết hợp RAM chuẩn LPDRR5X 16GB cùng ổ cứng 512GB. Chiếc laptop LG này được trang bị màn hình IPS 14 inch phân giải cao với tốc độ làm mới 60Hz. Bên cạnh đó, mẫu laptop LG Gram 2024 này còn sở hữu thêm viên pin dung lượng đủ để chạy tác vụ trong nhiều giờ cùng đa dạng cổng giao tiếp phổ biến.
Laptop LG Gram 2024 14Z90S-G.AH55A5 – Làm việc nhanh, chuẩn công sở
Laptop LG Gram 2024 14Z90S-G.AH55A5 là dòng laptop văn phòng quốc dân với chất lượng tuyệt vời. Qua các đặc điểm thông số nổi bật, mẫu máy tính xách tay LG này hứa hẹn sex giúp người dùng hoàn thiện công việc, học tập hay giải trí một cách tối ưu.

RAM 16GB, ổ cứng SSD
Laptop LG Gram 2024 14Z90S-G.AH55A5 sử dụng RAM chuẩn LPDRR5X với dung lượng lên đến 16GB. Cộng thêm tốc độ Bus RAM cao 6400MHz, máy tính có thể xử lý nhanh nhạy các thao tác văn phòng và đa nhiệm một cách mượt mà. Thêm vào đó, ổ cứng SSD NVMe Gen 4 cũng góp phần tăng cường tốc độ khi máy khởi động ứng dụng, mở tệp tin nhanh chóng. Với dung lượng tối da 512GB, người dùng có thể lưu trữ lượng lớn dữ liệu trong không gian thoải mái, giảm tình huống gián đoạn giữa chừng. Hơn thế nữa, laptop còn trang bị thêm khe slot M.2 để nâng cấp khả năng lưu trữ phù hợp với nhu cầu sử dụng.

Thiết kế nhẹ nhàng, màu thẩm mỹ
Laptop LG Gram 2024 14Z90S-G.AH55A5 thu hút bởi diện mạo hiện đại, thanh lịch với lớp vỏ kim loại nguyên khối. Với trọng lượng nhẹ, chiếc laptop Gram này cho phép đi cùng người dùng đến bất cứ đâu. Đặc biệt, gam màu sang trọng của máy càng góp phần tôn lên vẻ đẹp tinh tế, thời trang theo xu hướng thị hiếu hiện nay. Không những vậy, độ bền của laptop còn được đánh giá đạt tiêu chuẩn quân sự. Cùng với đó, sự tỉ mỉ trong thiết kế cũng giúp máy tăng thêm tuổi thọ trong thời gian dài.
 CPU chuyên nghiệp, GPU hiện đại
Laptop LG Gram 2024 14Z90S-G.AH55A5 tận dụng sức mạnh từ bộ vi xử lý Intel Core Ultra 5 Processor 125H. Theo đó, con chip này cung cấp khả năng đa nhiệm mượt, cũng như dễ dàng giải quyết nhanh chóng các tác vụ văn phòng, đồ họa hay chơi game cấu hình nhẹ. Đi cùng là bộ card đồ họa Intel Arc Graphics sẵn sàng hỗ trợ tốt cho nhiệm vụ giải trí đa phương tiện. Thông qua đó, laptop có thể đáp ứng tốt hiệu quả đối với những chương trình yêu cầu tài nguyên lớn. Đồng thời giúp máy tính hoạt động với hiệu năng ổn định, tránh gặp phải tình trạng chậm lag khi thực hiện nhiều tác vụ cùng lúc.

Hoạt động nhiều giờ, đa cổng kết nối
Laptop LG Gram 2024 14Z90S-G.AH55A5 vận hành liên tục với năng lượng được cung cấp từ viên pin Li-on 72 WH. Từ đó, người dùng có thể trải nghiệm công việc và học tập, giải trí hiệu quả với hiệu suất bền bỉ trong nhiều giờ sau một lần sạc đầy. Mặt khác, máy được đi kèm đầy đủ các cổng giao tiếp thiết yếu, thông dụng để phục vụ tối đa nhu cầu. Ở phiên bản này, người dùng dễ dàng chia sẻ và hoàn thành tác vụ cùng với những thiết bị ngoại vi khác với khả năng kết nối ấn tượng. ', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (13, N'Laptop HP Pavilion 15-EG2083TU 7C0W9PA', 7, N'china', NULL, CAST(14990000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/_/1_468.png', N'8', N'I5-1240P', N'Laptop HP Pavilion 15-EG2083TU 7C0W9PA sẽ giúp người dùng dễ dàng hoàn thiện công việc khi được trang bị con chip Intel Core i5 dòng P thế hệ thứ 12, 8GB RAM cùng ổ cứng SSD 512GB. Màn hình 15.6 inch FHD của laptop được tích hợp các công nghệ giúp bảo vệ thị lực người dùng khi sử dụng trong thời gian dài. Với thiết kế hiện đại cùng tổng thể mỏng nhẹ, laptop vừa có được sự tối giản, hiện đại, vừa có thể linh động mang theo mọi nơi.
Laptop HP Pavilion 15-EG2083TU 7C0W9PA - Hoàn thiện công việc dễ dàng, thiết kế hiện đại, linh hoạt
Laptop HP Pavilion 15-EG2083TU 7C0W9PA với cấu hình vượt trội sẽ là lựa chọn mà bất kỳ người làm văn phòng nào cũng cần cân nhắc. Đi kèm khả năng xử lý tốt mọi công việc là kích thước mỏng nhẹ cùng vẻ ngoài tối giản nhằm tăng tính cơ động cũng như giúp sản phẩm HP Pavilion này phù hợp sử dụng trong nhiều không gian, môi trường khác nhau.

Luôn sẵn sàng phục vụ công việc
Laptop HP Pavilion 15-EG2083TU 7C0W9PA sở hữu một ổ cứng SSD có dung lượng 512GB. Việc sử dụng dòng ổ cứng SSD sẽ cho phép laptop có thể khởi động hệ điều hành, mở các phần mềm, tập tin trong thời gian ngắn để phục vụ công việc nhanh chóng. Đồng thời, dung lượng ổ cứng 512GB cũng cung cấp một không gian đủ lớn để người dùng thoải mái hơn trong việc cài đặt phần mềm, trò chơi hay lưu trữ tập tin đa phương tiện.HP còn trang bị cho chiếc laptop HP Pavilion 15-EG2083TU 7C0W9PA của mình thanh chuẩn DDR4 3200MHz. Tổng dung lượng RAM 8GB này sẽ cung cấp đủ tài nguyên để người dùng thực hiện đa tác vụ một cách mượt mà nhanh chóng.

Thiết kế nhỏ gọn, tối giản những vẫn mang nét đặc trưng riêng
Thiết kế của laptop HP Pavilion 15-EG2083TU 7C0W9PA đi theo phong cách tối giản và hiện đại. Phần vỏ ngoài của laptop được làm từ nhôm cứng cáp, phủ bên ngoài một lớp sơn trắng bạc thanh lịch. Điểm nhấn trong thiết kế là phần logo HP được mạ bóng, đặt trên nắp màn hình. Nhờ vậy mà sản phẩm dù có sự tối giản nhưng vẫn giữ được sự nổi bật và tính nhận diện cao.HP Pavilion 15-EG2083TU 7C0W9PA còn là mẫu laptop sở hữu tính cơ động cao. Với trọng lượng chỉ khoảng 1.74kg và độ dày chỉ 17.9mm, người dùng có thể tiện lợi cất laptop trong balo, túi tote, cặp xách,... để mang theo một cách nhẹ nhàng. Nhờ việc sở hữu phần vỏ nhôm mà tình trạng hư hỏng do va đập xảy ra trong quá trình di chuyển cũng được hạn chế đáng kể.

Xử lý công việc dễ dàng với hiệu suất vượt trội
Laptop HP Pavilion 15-EG2083TU 7C0W9PA được tích hợp con chip Intel Core i5 1240P chuyên dành do dòng sản phẩm laptop doanh nhân. Nhờ việc sở hữu tới 12 nhân và 16 luồng, bộ vi xử lý Intel Core i5 dòng P thế hệ thứ 12 này có thể đạt tốc độ xung nhịp tối đa lên đến 4.4GHz. Tốc độ xử lý này sẽ đảm bảo mọi tác vụ luôn được diễn ra một cách nhanh chóng để duy trì hiệu suất cao trong công việc.Kết hợp với con chip Core i5 1240P là card đồ họa on-board Intel Iris. Dòng GPU tích hợp này với tốc độ 1.4GHz có thể đảm nhiệm tốt các công việc liên quan tới hình ảnh trên Photoshop, CorelDraw,... cũng như chơi game với cài đặt đồ hoạ tầm trung. Nhờ sự kết hợp giữa CPU và GPU này mà HP Pavilion 15-EG2083TU 7C0W9PA đủ sức mạnh để đáp ứng các tác vụ năng, các công việc chuyên nghiệp nhằm mang đến hiệu quả công việc tốt nhất.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (14, N'Laptop HP Pavilion X360 14-EK2017TU 9Z2V5PA', 7, N'china', NULL, CAST(23990000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_3__5_129.png', N'16', N'CORE 5-120U', N'Laptop HP Pavilion X360 14-EK2017TU 9Z2V5PA với chipset Core 5 120U của Intel, 16GB RAM và ổ cứng SSD 512GB sẽ luôn mang tới hiệu năng xử lý mạnh mẽ. Mẫu laptop HP Pavilion này còn sở hữu màn hình FHD 14 inch hỗ trợ cảm ứng để vừa hiển thị sắc nét, vừa phục vụ linh hoạt các nhu cầu của người dùng. Sản phẩm còn được trang bị kèm một bút cảm ứng để hỗ trợ tốt hơn nhu cầu ghi chú, sáng tạo nội dung.
Laptop HP Pavilion X360 14-EK2017TU 9Z2V5PA - Màn hình cảm ứng chất lượng, khả năng đa nhiệm mạnh mẽ
Laptop HP Pavilion X360 14-EK2017TU 9Z2V5PA sở hữu cấu hình đủ mạnh mẽ để có thể phục vụ tốt từ các công việc văn phòng cơ bản cho tới hoạt động sáng tạo nội dung, chỉnh sửa hình ảnh, biên tập video,...Đây cũng là một trong những mẫu laptop 2 trong 1 hiếm hoi được trang bị sẵn bút cảm ứng để hỗ trợ nhu cầu ghi chú, sáng tạo nội dung của người dùng.

Dung lượng RAM, bộ nhớ lớn, thoải mái làm việc đa nhiệm
Laptop HP Pavilion X360 14-EK2017TU 9Z2V5PA được trang bị sẵn 16GB RAM on-board DDR4 3200MHz. Với dung lượng RAM này, người dùng có thể thoải mái xử lý tập tin dữ liệu lớn, mở nhiều tab trên trình duyệt, khởi động nhiều phần mềm cùng lúc,...mà không lo giật lag. Dù sở hữu kiểu RAM hàn thẳng vào bo mạch chủ nhưng dung lượng RAM lên tới 16GB vẫn sẽ phục vụ tốt nhu cầu công việc, giải trí của người dùng trong nhiều năm.Ổ cứng SSD của HP Pavilion X360 14-EK2017TU 9Z2V5PA có dung lượng 512GB để người dùng thoải mái lưu trữ dữ liệu, tập tin đa phương tiện và cài đặt phần mềm. Với chuẩn ổ cứng SSD PCIe, tốc độ đọc - ghi của laptop còn được đẩy lên cao để thời gian khởi động hệ điều hành, mở các phần mềm chỉ còn được tính bằng giây.

Thiết kế 2 trong 1 sang trọng, trọng lượng nhẹ tiện lợi mang theo
Laptop HP Pavilion X360 14-EK2017TU 9Z2V5PA sở hữu thiết kế lai vô cùng độc đạo. Phần bản về của laptop có thể xoay 360 độ để người dùng có thể thay đổi tư thế phù hợp với từng nhu cầu sử dụng. HP còn trang bị thêm cho mẫu laptop Pavilion này của mình một chiếc bút cảm ứng để việc ghi chú, vẽ, sáng tạo nội dung trở nên tiện lợi, linh hoạt hơn.Phần khung sườn của HP Pavilion X360 14-EK2017TU 9Z2V5PA được làm bằng kim loại để các linh kiện bên trong được bảo vệ an toàn trong quá trình di chuyển. Phần nắp và mặt dưới laptop lại sử dụng vật liệu nhựa thay cho kim loại nhằm tối ưu trọng lượng. Nhờ vậy mà laptop Pavilion X360 14-EK2017TU 9Z2V5PA sẽ chỉ có trọng lượng không quá 1.5kg, rất nhẹ để việc mang theo bên người trở nên dễ dàng hơn.

Hiệu năng ổn định với bộ vi xử lý 10 nhân 12 luồng
Sức mạnh xử lý dữ liệu của laptop HP Pavilion X360 14-EK2017TU 9Z2V5PA tới từ con chip Core 5 120U của Intel. Con chip 10 nhân này có khả năng ép xung tối đa lên tới 5GHz để các tác vụ luôn được xử lý trong khoảng thời gian ngắn. HP Pavilion X360 14-EK2017TU 9Z2V5PA còn được trang bị thêm card đồ họa tích hợp Intel Graphics để các tác vụ liên quan tới hình ảnh được xử lý hiệu quả hơn.Hoạt động ổn định với viên pin 3-cell, kết nối có dây, không dây tiện lợi
Năng lượng cung cấp cho laptop Pavilion X360 14-EK2017TU 9Z2V5PA tới từ viên pin 3-cell có dung lượng 43.3Wh. Tuy đây không phải là viên pin có dung lượng quá lớn nhưng nhờ khả năng tối ưu điện năng tiêu thụ hiệu quả của dòng chip Intel U mà laptop Pavilion X360 14-EK2017TU 9Z2V5PA vẫn có thể hoạt động suốt nhiều giờ đồng hồ mà không cần kết nối với nguồn điện.Để hỗ trợ công việc tốt hơn, hai cạnh bên của HP Pavilion X360 14-EK2017TU 9Z2V5PA còn được tích hợp đầy đủ các cổng kết nối phổ biến như USB-A, USB-C hỗ trợ cổng PD và DisplayPort, HDMI, jack audio 3.5mm. Kèm theo đó là công nghệ Bluetooth 5.3 và Wireless 802.11 ax để mang tới sự ổn định trong quá trình kết nối các thiết bị ngoại vi không dây.', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (15, N'Laptop MSI Gaming Thin 15 B12UCX-1419VN', 8, N'CHINA', NULL, CAST(15290000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_31__3_18.png', N'8', N'I5-12450H', N'Laptop MSI Gaming Thin 15 B12UCX-1419VN sử dụng chiếc CPU Intel Core i5-12450H với 8 nhân, 12 luồng, và card đồ họa NVIDIA GeForce RTX 2050 mạnh mẽ. Máy có RAM 8GB DDR4 cùng ổ cứng SSD M.2 PCIe dung lượng 512GB. Máy có màn hình 15.6 inch FHD, tần số quét 144Hz cùng kích thước 359 x 254 x 21.7mm.
Laptop MSI Gaming Thin 15 B12UCX-1419VN - Lựa chọn lý tưởng cho các game thủ hiện đại
Laptop MSI Gaming Thin 15 B12UCX-1419VN là dòng sản phẩm đang được nhiều khách hàng săn đón trong thị trường laptop gaming hiện nay. Với thiết kế mỏng nhẹ và cấu hình mạnh mẽ, mẫu laptop MSI gaming này là một lựa chọn lý tưởng cho game thủ muốn trải nghiệm chơi game mượt mà và xử lý công việc hiệu quả. 

Sử dụng CPU i5-12450H, GPU GeForce RTX 2050 mạnh mẽ
Một trong những yếu tố quan trọng quyết định hiệu năng của laptop MSI Gaming Thin 15 B12UCX-1419VN chính là bộ xử lý và card đồ họa. MSI Gaming Thin 15 B12UCX-1419VN được trang bị bộ vi xử lý Intel Core i5-12450H thế hệ thứ 12 với 8 nhân và 12 luồng, mang lại khả năng xử lý mạnh mẽ. Tốc độ xung nhịp tối thiểu là 2.2 GHz và có thể đạt tới 4.4 GHz khi cần thiết, đảm bảo xử lý mượt mà các tác vụ đa nhiệm và game nặng.Bên cạnh đó, card đồ họa NVIDIA GeForce RTX 2050 cũng là một điểm nhấn quan trọng của chiếc laptop gaming này. Với sức mạnh ấn tượng, thiết bị giúp người dùng có trải nghiệm hình ảnh chân thực, mượt mà khi chơi các tựa game AAA hay làm việc đồ họa. Với sự kết hợp giữa CPU và GPU mạnh mẽ, MSI Gaming Thin 15 B12UCX-1419VN sẽ đáp ứng được nhu cầu của game thủ lẫn những người làm việc liên quan đến đồ họa.
RAM 8GB với bus 3200MHz đi kèm ổ cứng dung lượng 512GB
Laptop MSI Gaming Thin 15 B12UCX-1419VN đi kèm với 8GB RAM DDR4, tốc độ 3200 MHz, giúp xử lý mượt mà các ứng dụng và trò chơi hiện đại. Dung lượng RAM cũng là yếu tố quan trọng góp phần tăng cường khả năng đa nhiệm trên laptop, giảm thiểu các tình trạng giật lag. Máy còn hỗ trợ nâng cấp RAM lên tối đa 64GB với hai khe cắm rời, giúp người dùng dễ dàng nâng cấp khi cần thiết.Về khả năng lưu trữ, sản phẩm được trang bị ổ cứng SSD M.2 PCIe dung lượng 512GB, mang lại tốc độ truy xuất dữ liệu nhanh chóng. Với dung lượng này, máy có khả năng lưu trữ đủ lớn cho các phần mềm hệ thống và những tựa game yêu thích. Chưa hết, chuẩn ổ cứng SSD này không những giúp tăng tốc độ khởi động laptop mà còn tăng cường tốc độ tải game, mở ứng dụng chỉ trong vài giây.
Thiết kế sang trọng, mỏng nhẹ chỉ 359 x 254 x 21.7mm và 1.86 kg
Laptop MSI Gaming Thin 15 B12UCX-1419VN không chỉ nổi bật với hiệu năng mạnh mẽ mà còn gây ấn tượng với thiết kế mỏng nhẹ. Với kích thước 359 x 254 x 21.7mm và khối lượng chỉ 1.86 kg, chiếc laptop này sẽ không làm gánh nặng trong việc di chuyển của người dùng. Dù thuộc dòng laptop gaming, nhưng thiết kế của nó vẫn đảm bảo tính di động cao, đem đến sự tiện lợi cho những khách hàng thường xuyên di chuyển.
Màn hình siêu mượt 144Hz, trang bị pin 52.4 Wh và đa dạng kết nối
Màn hình của laptop MSI Gaming Thin 15 B12UCX-1419VN có kích thước 15.6 inch, độ phân giải Full HD (1920 x 1080 pixels). Tấm nền IPS cùng tần số quét 144Hz giúp người dùng có những trải nghiệm chơi game mượt mà hơn, hạn chế hiện tượng bóng mờ khi chơi các game tốc độ cao. Độ sáng 250 nits và độ phủ màu 45% NTSC là đủ để đáp ứng nhu cầu giải trí, làm việc trong môi trường ánh sáng tự nhiên.
Pin của MSI Gaming Thin 15 B12UCX-1419VN có dung lượng 52.4 Wh, đủ để sử dụng trong thời gian dài mà không cần sạc liên tục. Điều này rất hữu ích cho những ai thường xuyên làm việc di động hoặc không muốn bị gián đoạn trong quá trình chơi game. Bên cạnh đó, máy còn hỗ trợ đa dạng cổng kết nối bao gồm 1 cổng Type-C, 3 cổng USB 3.2 Gen 1 Type-A, cổng HDMI và cổng RJ45, cho khả năng ghép nối linh hoạt', 1)
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [MaThuongHieu], [XuatXu], [GiaNhap], [GiaXuat], [SoLuongTonKho], [HinhAnh], [Ram], [CPU], [MoTa], [TrangThai]) VALUES (16, N'Laptop MSI Prestige 14 AI Studio C1VEG-056VN', 8, N'CHINA', NULL, CAST(32990000.00 AS Decimal(10, 2)), 12, N'https://cdn2.cellphones.com.vn/x/media/catalog/product/t/e/text_ng_n_8__4_128.png', N'32', N'U7-155H', N'Laptop MSI Prestige 14 AI Studio C1VEG-056VN đem lại hiệu suất xử lý siêu mạnh cho các tác vụ sáng tạo với Intel Core Ultra 7-155H gồm 16 lõi và 22 luồng. Bên cạnh đó, máy còn được tích hợp kèm card đồ họa NVIDIA GeForce RTX 4050 6GB GDDR6, cung cấp khả năng xử lý hình ảnh xuất sắc, hỗ trợ tốt các ứng dụng đồ họa chuyên nghiệp và gaming. Đặc biệt, MSI Prestige 14 AI Studio còn sở hữu bộ nhớ RAM DDR5 32GB, hỗ trợ đa nhiệm nhanh chóng và mượt mà cùng lúc nhiều ứng dụng.
Laptop MSI Prestige 14 AI Studio C1VEG-056VN - Cấu hình đột phá, thiết kế hiện đại, sang trọng
Laptop MSI Prestige 14 AI Studio C1VEG-056VN với cấu hình mạnh mẽ đảm bảo đáp ứng tốt các nhu cầu làm việc đa dạng từ sáng tạo nội dung đến giải trí cao cấp. Bên cạnh đó, máy còn được đánh giá cao với kiểu dáng hiện đại, mỏng nhẹ cùng tông màu Xám sang trọng, tạo điểm nhấn về thiết kế và góp phần tăng thêm sức hấp dẫn cho mẫu laptop MSI Prestige này.

Hiệu năng mạnh mẽ cùng khả năng xử lý đồ hoạ mượt mà
Laptop MSI Prestige 14 AI Studio C1VEG-056VN dễ dàng gây ấn tượng với hiệu năng vượt trội nhờ bộ vi xử lý Intel Core Ultra 7-155H bao gồm 16 lõi và 22 luồng, xung nhịp lên đến 4.8GHz. Sức mạnh này cho phép máy xử lý đa nhiệm một cách dễ dàng, từ việc chỉnh sửa video đến lập trình phức tạp. Kết hợp với CPU mạnh mẽ này là khả năng xử lý đồ họa tuyệt vời tới từ GPU NVIDIA GeForce RTX 4050 6GB GDDR6. Thông qua đó, ngay cả các tác vụ nặng như thiết kế đồ họa, render 3D hay chơi game cũng đều có thể được xử lý mượt mà trên MSI Prestige 14 AI Studio với chất lượng hình ảnh sắc nét. 

Chưa dừng lại ở đó, thế hệ laptop MSI Prestige này còn ghi điểm với hệ thống tản nhiệt tối ưu với 2 quạt và 4 khe thoát khí, đảm bảo hoạt động mát mẻ ngay cả khi xử lý các tác vụ nặng.

Đa nhiệm ổn định cùng khả năng lưu trữ dữ liệu cỡ lớn
Khả năng đa nhiệm của MSI Prestige 14 AI Studio C1VEG-056VN cũng không hề khiến người dùng phải thất vọng nhờ sở hữu RAM DDR5 dung lượng 32GB, tốc độ lên đến 5600MHz. Với thông số RAM mạnh mẽ này, MSI Prestige 14 AI Studio cho phép người dùng có thể mở cùng lúc nhiều ứng dụng nặng mà không gặp hiện tượng giật lag, giúp tối ưu hóa hiệu suất làm việc. Về lưu trữ, laptop MSI Prestige được trang bị ổ cứng SSD PCIe Gen4 dung lượng 1TB, cung cấp tốc độ ghi và đọc dữ liệu siêu nhanh chóng. Qua đó, nó không chỉ tăng tốc độ khởi động cho máy và phần mềm, mà còn cung cấp không gian khủng để lưu trữ các tệp lớn như video, hình ảnh chất lượng cao.

Tạo hình hiện đại, sang trọng và cực kỳ bắt mắt với tông màu Xám chủ đạo
Laptop MSI Prestige 14 AI Studio C1VEG-056VN nổi bật với thiết kế hiện đại và tinh tế nhờ chế tác từ hợp kim nhôm cao cấp. Cụ thể, chất liệu nhôm cao cấp này không chỉ giúp laptop MSI Prestige 14 AI Studio này trở nên chắc chắn, bền bỉ mà còn hỗ trợ tản nhiệt tốt hơn, duy trì nhiệt độ ổn định khi làm việc. Với tông màu xám chủ đạo, laptop MSI Prestige cũng đem tới cảm giác sang trọng và chuyên nghiệp, phù hợp với những người dùng làm việc trong môi trường sáng tạo hoặc doanh nhân. Ấn tượng hơn, các đường nét bo tròn mềm mại trên máy khi kết hợp với bản lề mở góc 180 độ, giúp người sử dụng có thể dễ dàng thao tác máy ở nhiều góc độ khác nhau. Cùng với đó là trọng lượng chỉ 1.7kg và độ dày 18.9mm, giúp laptop MSI Prestige 14 AI Studio này dễ dàng được mang theo bên mình, đáp ứng tốt nhu cầu di động mà vẫn duy trì phong cách thẩm mỹ cao cấp.', 1)
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

INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (1, N'ASUS')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (2, N'LENOVO')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (3, N'APPLE')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (4, N'DELL')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (5, N'ACER')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (6, N'LG')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (7, N'HP')
INSERT [dbo].[ThuongHieu] ([MaThuongHieu], [TenThuongHieu]) VALUES (8, N'MSI')
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TaiKhoan__55F68FC06A33D60E]    Script Date: 14/01/2025 4:14:28 CH ******/
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

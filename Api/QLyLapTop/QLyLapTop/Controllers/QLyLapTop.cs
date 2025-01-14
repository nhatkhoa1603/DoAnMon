using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Crypto.Generators;
using QLyLapTop.MyModels;
using System.Threading.Tasks;

namespace QLyLapTop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QLyLapTop : ControllerBase
    {
        KetNoiCSDL dbc;

        public QLyLapTop(KetNoiCSDL dbc_in)
        {
            dbc = dbc_in;
        }

        //------------------- San Pham ------------------------//

        [HttpGet]
        [Route("/sanPham/danhSach")]
        public IActionResult danhSachSanPham()
        {
            var danhsach = dbc.SanPhams.ToList();
            return Ok(new { success = true, data = danhsach });
        }

        [HttpGet]
        [Route("/sanPham/chiTietSanPham/{id}")]
        public async Task<ActionResult<IEnumerable<SanPham>>> thongTinSanPham(int id)
        {
            var sanPhams = await dbc.SanPhams
                .Where(sp => sp.MaSanPham == id)
                .ToListAsync();

            if (sanPhams == null || !sanPhams.Any())
            {
                return NotFound(new { Message = "Không tìm thấy sản phẩm nào cho thương hiệu này." });
            }

            return Ok(sanPhams);
        }

        [HttpGet]
        [Route("/sanPham/locTheoDanhMuc/{maThuongHieu}")]
        public async Task<ActionResult<IEnumerable<SanPham>>> locDanhMuc(int maThuongHieu)
        {
            var sanPhams = await dbc.SanPhams
                .Where(sp => sp.MaThuongHieu == maThuongHieu)
                .ToListAsync();

            if (sanPhams == null || !sanPhams.Any())
            {
                return NotFound(new { Message = "Không tìm thấy sản phẩm nào cho thương hiệu này." });
            }

            return Ok(sanPhams);
        }

        [HttpGet]
        [Route("/sanPham/timkiem/Ten")]
        public ActionResult timKiemTheoTen([FromQuery] string name)
        {
            var timKiem = dbc.SanPhams.Where(t => t.TenSanPham.Contains(name)).ToList();
            return Ok(new { success = true, data = timKiem });
        }

        //------------------- Thong tin khach hang ------------------------//
        [HttpGet]
        [Route("/khachHang/{id}")]
        public IActionResult LayThongTinKhachHang(int id)
        {
            var tasks = dbc.KhachHangs.Find(id);
            if (tasks == null)
            {
                return NotFound(new { success = false, message = $"Không tìm Thấy khách hàng với ID: {id}!" });
            }
            return Ok(new { success = true, data = tasks });
        }

        [HttpPut]
        [Route("/khachHang/Sua/{id}")]
        public ActionResult Update(int id, KhachHang obj)
        {
            var ktra = dbc.KhachHangs.Find(id);
            if (ktra == null)
            {
                return NotFound(new { success = false, message = $"Không tìm Thấy khách hàng với ID: {id}!" });
            }

            ktra.TenKhachHang = obj.TenKhachHang;
            ktra.GioiTinh = obj.GioiTinh;
            ktra.DiaChi = obj.DiaChi;
            ktra.SoDienThoai = obj.SoDienThoai;
            ktra.Email = obj.Email;
            ktra.TrangThai = 1;
            dbc.SaveChanges();

            return Ok(new { success = true, message = "Cập nhật Thông tin khách hàng thành công!" });
        }

        [HttpPost]
        [Route("/khachHang/Them")]
        public IActionResult ThemKhachHang(KhachHang obj)
        {
            try
            {
                var ktraEmail = dbc.KhachHangs.Where(kt => kt.Email == obj.Email).ToList();
                var ktraSDT = dbc.KhachHangs.Where(kt => kt.SoDienThoai == obj.SoDienThoai).ToList();

                if (ktraEmail.Count >0)
                {
                    return NotFound(new { success = false, message = $"Trùng Email!" });
                }
                if (ktraSDT.Count >0)
                {
                    return NotFound(new { success = false, message = $"Trùng SĐT!" });
                }
                //obj.TrangThai = 1; // Gán trạng thái cho giỏ hàng (ví dụ: 1 = Đang xử lý)
                dbc.KhachHangs.Add(obj);

                dbc.SaveChanges();

                return Ok(new { success = true, message = "Thêm khach hang thành công!" });

            }
            catch (Exception ex)
            {
                return StatusCode(500, "Có lỗi xảy ra khi lưu thay đổi. Vui lòng kiểm tra lại dữ liệu.");
            }
  
        }

        //------------------- Tai Khoan ------------------------//
        [HttpPost]
        [Route("/taiKhoan/Them")]
        public IActionResult ThemTaiKhoan(String tenDangNhap,TaiKhoan obj)
        {
            try
            {
                var ktra = dbc.TaiKhoans.Where(kt => kt.TenDangNhap == obj.TenDangNhap).ToList();

                if (ktra.Count > 0)
                {
                    return NotFound(new { success = false, message = $"Ten Dang nhap da ton tai!" });
                }

                dbc.TaiKhoans.Add(obj);

                dbc.SaveChanges();

                return Ok(new { success = true, message = "Thêm tai khoan thành công!" });

            }
            catch (Exception ex)
            {
                return StatusCode(500, "Có lỗi xảy ra khi lưu thay đổi. Vui lòng kiểm tra lại dữ liệu.");
            }
        }

        [HttpPost]
        [Route("/taiKhoan/DangNhap")]
        public async Task<IActionResult> DangNhap( TaiKhoan obj)
        {
            var taiKhoan = await dbc.TaiKhoans
                .FirstOrDefaultAsync(t => t.TenDangNhap == obj.TenDangNhap && t.MatKhau == obj.MatKhau && t.TrangThai);

            if (taiKhoan == null )
            {
                return Unauthorized(new { Message = "Tên đăng nhập hoặc mật khẩu không đúng." });
            }

            return Ok(new { Message = "Đăng nhập thành công!", data = taiKhoan });
        }


        [HttpPost]
        [Route("/taiKhoan/doiMatKhau/{id}")]
        public async Task<IActionResult> DangNhap(int id,String mkcu, TaiKhoan obj)
        {
            var taiKhoan = await dbc.TaiKhoans
                .FirstOrDefaultAsync(t => t.MaTaiKhoan == id && t.TrangThai);
            var ktraMK = await dbc.TaiKhoans
                .FirstOrDefaultAsync(t => t.MatKhau == mkcu && t.TrangThai);

            if (taiKhoan == null)
            {
                return NotFound(new { success = false,Message = "Khong tim thay ID" });
            }

            if (ktraMK == null)
            {
                return NotFound(new { success = false, Message = "mk cu khong khop" });
            }
            taiKhoan.MatKhau = obj.MatKhau;
            dbc.SaveChanges();
            return Ok(new { success = true, message = $"Doi mat khau thanh cong!" });
        }
        //------------------- hoa Don ------------------------//

        [HttpGet]
        [Route("/hoaDon/locTheotrangthai/{trangthai}")]
        public ActionResult loctheotrangthai(int trangthai)
        {
            var hoadon = dbc.HoaDons
                .Where(sp => sp.TrangThai == trangthai).ToList();
            if(hoadon == null)
            {
                return NotFound(new { success = false, message = $"khong tim thay trang thai: {trangthai}!" });
            }
            return Ok(new { success = true, data = hoadon });
        }

        [HttpGet]
        [Route("/hoaDon/danhSach")]
        public async Task<IActionResult> danhSachHoaDon()
        {
            try
            {
                var hoaDons = await dbc.HoaDons
                    .Join(
                        dbc.KhachHangs,
                        hd => hd.MaKhachHang,
                        kh => kh.MaKhachHang,
                        (hd, kh) => new
                        {
                            hd.MaDonHang,
                            NgayDatHang = hd.NgayDatHang.HasValue
                        ? hd.NgayDatHang.Value.ToString("yyyy-MM-dd") // Chỉ lấy ngày, tháng, năm
                        : null,
                            hd.PhiVanChuyen,
                            hd.TrangThai,
                            hd.TongTien,
                            TenKhachHang = kh.TenKhachHang,
                            soDienThoai = kh.SoDienThoai
                        }
                    )
                    .ToListAsync();

                if (!hoaDons.Any())
                {
                    return NotFound(new { message = "Không tìm thấy hóa đơn." });
                }

                return Ok(new { success = true, data = hoaDons });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }


        [HttpPut]
        [Route("/hoaDon/huyDon/{id}")]
        public ActionResult huyDon(int id)
        {
            var hoadon = dbc.HoaDons.Find(id);
            if (hoadon == null)
            {
                return NotFound(new { success = false, message = $"khong tim thay don hang voi ID: {id}!" });
            }

            hoadon.TrangThai = 0;
            dbc.SaveChanges();

            return Ok(new { success = true, message = "huy don thanh cong!" });
        }

        //------------------- Chi tiet don hang ------------------------//

        [HttpGet]
        [Route("/chiTietHoaDon/danhSach/{maHoaDon}")]
        public async Task<IActionResult> GetChiTietHoaDonWithTenSanPham(int maHoaDon)
        {
            try
            {
                var hoadon = dbc.ChiTietHoaDons
                .Where(sp => sp.MaHoaDon == maHoaDon).ToList();
                var chiTietHoaDons = await dbc.ChiTietHoaDons
                    .Join(
                        dbc.SanPhams,
                        cthd => cthd.MaSanPham,
                        sp => sp.MaSanPham,
                        (cthd, sp) => new
                        {
                            cthd.MaHoaDon,
                            cthd.MaSanPham,
                            sp.TenSanPham,
                            sp.GiaXuat,
                            cthd.SoLuong,
                            cthd.GiaBan,
                            cthd.GiamGia,
                            cthd.ThanhTien
                        }
                    )
                    .ToListAsync();

                if (!chiTietHoaDons.Any())
                {
                    return NotFound(new { message = "Không tìm thấy chi tiết hóa đơn." });
                }

                return Ok(chiTietHoaDons);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        [HttpPut]
        [Route("/chiTietHoaDon/Sua/soLuong")]
        public async Task<IActionResult> UpdateSoLuong(int maHoaDon, int maSanPham, int soLuongMoi)
        {
            if (soLuongMoi <= 0)
            {
                return BadRequest(new { message = "Số lượng phải lớn hơn 0." });
            }

            try
            {
                var chiTietHoaDon = await dbc.ChiTietHoaDons
                    .FirstOrDefaultAsync(cthd => cthd.MaHoaDon == maHoaDon && cthd.MaSanPham == maSanPham);

                if (chiTietHoaDon == null)
                {
                    return NotFound(new { message = "Chi tiết hóa đơn không tồn tại." });
                }

                // Cập nhật số lượng và tính lại thành tiền nếu cần
                chiTietHoaDon.SoLuong = soLuongMoi;

                await dbc.SaveChangesAsync();

                return Ok(new { message = "Cập nhật số lượng thành công."});
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }


        //------------------- gio hang ------------------------//

        [HttpGet]
        [Route("/gioHang/danhSach/{maKhachHang}")]
        public async Task<ActionResult<IEnumerable<GioHang>>> GetGioHangByMaKhachHang(int maKhachHang)
        {
            var gioHangs = await dbc.GioHangs
                .Where(g => g.MaKhachHang == maKhachHang)
                .ToListAsync();

            if (gioHangs == null || gioHangs.Count == 0)
            {
                return NotFound(); // Trả về 404 nếu không tìm thấy dữ liệu
            }

            return Ok(gioHangs); // Trả về dữ liệu nếu tìm thấy
        }

        [HttpPost]
        [Route("/gioHang/Them")]
        public IActionResult ThemVaoGioHang(GioHang obj)
        {
            try
            {
                // Kiểm tra xem khách hàng và sản phẩm có tồn tại trong giỏ hàng hay chưa
                var existingItem = dbc.GioHangs
                    .FirstOrDefault(g => g.MaKhachHang == obj.MaKhachHang && g.MaSanPham == obj.MaSanPham);

                if (existingItem != null)
                {
                    return NotFound(new { success = false, message = $"San pham da co trong cua hang!" });
                }
                else
                {
                    // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới vào giỏ hàng
                    obj.TrangThai = 1; // Gán trạng thái cho giỏ hàng (ví dụ: 1 = Đang xử lý)
                    dbc.GioHangs.Add(obj);

                    // Lưu thay đổi vào cơ sở dữ liệu
                    dbc.SaveChanges();

                    return Ok(new { success = true, message = "Thêm vào giỏ hàng thành công!" });
                }
            }
            catch (Exception ex)
            {
                // Log error details (optional)
                Console.WriteLine($"Error: {ex.Message}");
                if (ex.InnerException != null)
                {
                    Console.WriteLine($"Inner exception: {ex.InnerException.Message}");
                }
                return StatusCode(500, "Có lỗi xảy ra khi lưu thay đổi. Vui lòng kiểm tra lại dữ liệu.");
            }
        }


        [HttpPut]
        [Route("/gioHang/suaSoLuong/{maKhachHang} & {maSP}")]
        public async Task<ActionResult<IEnumerable<GioHang>>> suaSoLuong(int maKhachHang, int maSP, GioHang obj)
        {
            var gioHang = await dbc.GioHangs
                .FirstOrDefaultAsync(g => g.MaKhachHang == maKhachHang && g.MaSanPham == maSP);


            if (gioHang == null)
            {
                return NotFound(new { success = false, message = $"khong tim thay san pham voi ID: {maSP}!" }); // Trả về 404 nếu không tìm thấy dữ liệu
            }

            gioHang.SoLuong = obj.SoLuong;
            gioHang.ThanhTien = obj.ThanhTien;
            dbc.SaveChanges();

            return Ok(new { success = true, message = "sua so luong thanh cong!" });
        }

        [HttpPut]
        [Route("/gioHang/Xoa/{maKhachHang} & {maSP}")]
        public async Task<ActionResult<IEnumerable<GioHang>>> XoaKhoiGioHang(int maKhachHang, int maSP)
        {
            var gioHang = await dbc.GioHangs
                .FirstOrDefaultAsync(g => g.MaKhachHang == maKhachHang && g.MaSanPham == maSP);


            if (gioHang == null)
            {
                return NotFound(new { success = false, message = $"khong tim thay san pham voi ID: {maSP}!" }); // Trả về 404 nếu không tìm thấy dữ liệu
            }

            gioHang.TrangThai = 0;
            dbc.SaveChanges();

            return Ok(new { success = true, message = "sua so luong thanh cong!" });
        }
    }
}


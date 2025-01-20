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
        [Route("/khachHang/{id:int}")]
        public async Task<IActionResult> LayThongTinKhachHang(int id)
        {
            var tasks = await dbc.KhachHangs.FirstOrDefaultAsync(u => u.MaKhachHang == id);
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
                var errors = new List<string>();

                if (obj == null)
                {
                    return BadRequest(new { success = false, message = "Đăng ký thất bại", errors = new[] { "Dữ liệu khách hàng không được để trống!" } });
                }

                if (string.IsNullOrWhiteSpace(obj.TenKhachHang))
                {
                    errors.Add("Tên khách hàng không được để trống!");
                }

                if (string.IsNullOrWhiteSpace(obj.Email))
                {
                    errors.Add("Email không được để trống!");
                }

                if (string.IsNullOrWhiteSpace(obj.SoDienThoai))
                {
                    errors.Add("Số điện thoại không được để trống!");
                }

                if (!string.IsNullOrWhiteSpace(obj.Email))
                {
                    var emailRegex = new System.Text.RegularExpressions.Regex(@"^[^\s@]+@[^\s@]+\.[^\s@]+$");
                    if (!emailRegex.IsMatch(obj.Email))
                    {
                        errors.Add("Email không hợp lệ!");
                    }
                    else if (dbc.KhachHangs.Any(kt => kt.Email == obj.Email))
                    {
                        errors.Add("Email đã tồn tại trong hệ thống!");
                    }
                }

                if (!string.IsNullOrWhiteSpace(obj.SoDienThoai))
                {
                    if (!System.Text.RegularExpressions.Regex.IsMatch(obj.SoDienThoai, @"^\d+$"))
                    {
                        errors.Add("Số điện thoại phải là chuỗi số hợp lệ!");
                    }
                    else if (dbc.KhachHangs.Any(kt => kt.SoDienThoai == obj.SoDienThoai))
                    {
                        errors.Add("Số điện thoại đã tồn tại trong hệ thống!");
                    }
                }

                if (errors.Any())
                {
                    return BadRequest(new { success = false, message = "Đăng ký thất bại", errors });
                }

                obj.GioiTinh ??= "Không xác định";
                obj.TrangThai ??= 1;

                dbc.KhachHangs.Add(obj);
                dbc.SaveChanges();

                return Ok(new { success = true, message = "Đăng ký thành công!" });
            }
            catch (Exception ex)
            {
                var innerException = ex.InnerException?.Message ?? ex.Message;
                return StatusCode(500, new
                {
                    success = false,
                    message = "Đăng ký thất bại",
                    errors = new[] { "Có lỗi xảy ra khi lưu thay đổi" },
                    error = innerException
                });
            }
        }

        [HttpPost]
        [Route("/taiKhoan/Them")]
        public IActionResult ThemTaiKhoan(TaiKhoan obj)
        {
            try
            {
                var errors = new List<string>();

                if (obj == null)
                {
                    return BadRequest(new { success = false, message = "Đăng ký thất bại", errors = new[] { "Dữ liệu tài khoản không được để trống!" } });
                }

                if (string.IsNullOrWhiteSpace(obj.TenDangNhap))
                {
                    errors.Add("Tên đăng nhập không được để trống!");
                }

                if (string.IsNullOrWhiteSpace(obj.MatKhau))
                {
                    errors.Add("Mật khẩu không được để trống!");
                }
                else if (obj.MatKhau.Length < 6)
                {
                    errors.Add("Mật khẩu phải có ít nhất 6 ký tự!");
                }

                if (!string.IsNullOrWhiteSpace(obj.TenDangNhap) && dbc.TaiKhoans.Any(kt => kt.TenDangNhap == obj.TenDangNhap))
                {
                    errors.Add("Tên đăng nhập đã tồn tại!");
                }

                if (errors.Any())
                {
                    return BadRequest(new { success = false, message = "Đăng ký thất bại", errors });
                }

                obj.TrangThai ??= 1;
                dbc.TaiKhoans.Add(obj);
                dbc.SaveChanges();

                return Ok(new { success = true, message = "Đăng ký thành công!" });
            }
            catch (Exception ex)
            {
                var innerException = ex.InnerException?.Message ?? ex.Message;
                return StatusCode(500, new
                {
                    success = false,
                    message = "Đăng ký thất bại",
                    errors = new[] { "Có lỗi xảy ra khi lưu thay đổi" },
                    error = innerException
                });
            }
        }


        [HttpPost]
        [Route("/taiKhoan/DangNhap")]
        public async Task<IActionResult> DangNhap(TaiKhoan obj)
        {

            var taiKhoan = await dbc.TaiKhoans
                .FirstOrDefaultAsync(t => t.TenDangNhap == obj.TenDangNhap && t.MatKhau == obj.MatKhau);

            if (taiKhoan == null)
            {
                return Unauthorized(new { success = false, message = "Tên đăng nhập hoặc mật khẩu không hợp lệ." });
            }

            if (taiKhoan.TrangThai == null || taiKhoan.TrangThai == 0)
            {
                return Unauthorized(new { success = false, message = "Tài khoản của bạn đã bị vô hiệu hóa." });
            }

            return Ok(new
            {
                success = true,
                message = "Đăng nhập thành công!",
                maTaiKhoan = taiKhoan.MaTaiKhoan,
                taiKhoan = new
                {
                    taiKhoan.MaTaiKhoan,
                    taiKhoan.TenDangNhap,
                    taiKhoan.MatKhau,
                    taiKhoan.TrangThai,
                    taiKhoan.LoaiTaiKhoan

                }
            });
        }


        [HttpPost]
        [Route("/taiKhoan/doiMatKhau/{id}")]
        public async Task<IActionResult> DangNhap(int id, string mkcu, TaiKhoan obj)
        {

            var taiKhoan = await dbc.TaiKhoans.FirstOrDefaultAsync(t => t.MaTaiKhoan == id);
            if (taiKhoan == null)
            {
                return NotFound(new { success = false, Message = "Không tìm thấy tài khoản với ID này" });
            }
            if (taiKhoan.MatKhau != mkcu)
            {
                return BadRequest(new { success = false, Message = "Mật khẩu cũ không chính xác" });
            }
            if (string.IsNullOrWhiteSpace(obj.MatKhau) || obj.MatKhau.Length < 6)
            {
                return BadRequest(new { success = false, Message = "Mật khẩu mới phải chứa ít nhất 6 ký tự" });
            }
            if (obj.MatKhau.Contains(" "))
            {
                return BadRequest(new { success = false, Message = "Mật khẩu mới không được chứa khoảng trắng" });
            }
            taiKhoan.MatKhau = obj.MatKhau;
            await dbc.SaveChangesAsync();

            return Ok(new { success = true, Message = "Đổi mật khẩu thành công!" });
        }
        //------------------- hoa Don ------------------------//

        [HttpPost]
        [Route("/hoaDon/Them")]
        public ActionResult ThemHoaDon(HoaDon obj)
        {
            obj.MaDiaChiGiao = 1;
            obj.TrangThai = 1;
            obj.MaKhuyenMai = null;
            obj.NgayDatHang = DateTime.Now;
            dbc.HoaDons.Add(obj);
            dbc.SaveChanges();

            return Ok(new { success = true, data = obj, message = "Tạo hóa đơn thành công!" });
        }

        [HttpGet]
        [Route("/hoaDon/locTheotrangthai/{trangthai}")]
        public ActionResult loctheotrangthai(int trangthai)
        {
            var hoadon = dbc.HoaDons
                .Where(sp => sp.TrangThai == trangthai).Join(
                        dbc.KhachHangs,
                        hd => hd.MaKhachHang,
                        kh => kh.MaKhachHang,
                        (hd, kh) => new
                        {
                            hd.MaDonHang,
                            NgayDatHang = hd.NgayDatHang.HasValue
                        ? hd.NgayDatHang.Value.ToString("yyyy-MM-dd") 
                        : null,
                            hd.PhiVanChuyen,
                            hd.TrangThai,
                            hd.TongTien,
                            TenKhachHang = kh.TenKhachHang,
                            soDienThoai = kh.SoDienThoai
                        }
                    ).ToList();
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
                        ? hd.NgayDatHang.Value.ToString("yyyy-MM-dd") 
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

        [HttpGet]
        [Route("/hoaDonKhachHang/danhSach/{makhachHang}")]
        public async Task<IActionResult> danhSachHoaDonKhachHang(int makhachHang)
        {
            try
            {
                var hoadon = await dbc.HoaDons
                .Where(sp => sp.MaKhachHang ==  makhachHang).ToListAsync();
                if (hoadon == null)
                {
                    return NotFound(new { success = false, message = $"khong tim thay trang thai: {makhachHang}!" });
                }

                return Ok(new { success = true, data = hoadon });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        [HttpGet]
        [Route("/hoaDon/locTheotrangthaiKhachHang/{trangthai} & {maKhachHang}")]
        public ActionResult loctheotrangthaiKhachHang(int trangthai,int maKhachHang)
        {
            try
            {
                var hoadon = dbc.HoaDons
                .Where(sp => sp.MaKhachHang == maKhachHang && sp.TrangThai == trangthai).ToList();
                if (hoadon == null)
                {
                    return NotFound(new { success = false, message = $"khong tim thay trang thai thong tin!" });
                }

                return Ok(new { success = true, data = hoadon });
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

        [HttpPut]
        [Route("/hoaDon/capNhat/{id}")]
        public ActionResult capNhatHoaDon(int id)
        {
            var hoadon = dbc.HoaDons.Find(id);
            if (hoadon == null)
            {
                return NotFound(new { success = false, message = $"khong tim thay don hang voi ID: {id}!" });
            }
            if(hoadon.TrangThai < 3)
            {
                hoadon.TrangThai += 1;
            }
           
            dbc.SaveChanges();

            return Ok(new { success = true,message = "Cap nhat thanh cong!" });
        }

        //------------------- Chi tiet don hang ------------------------//

        [HttpGet]
        [Route("/chiTietHoaDon/danhSach/{maHoaDon}")]
        public async Task<IActionResult> GetChiTietHoaDonWithTenSanPham(int maHoaDon)
        {
            try
            {
                var chiTietHoaDons = await dbc.ChiTietHoaDons.Where(sp => sp.MaHoaDon == maHoaDon)
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
                            sp.HinhAnh,
                            cthd.SoLuong,
                            cthd.GiaBan,
                            cthd.GiamGia,
                            cthd.ThanhTien
                        }
                    )
                    .ToListAsync();

                if (!chiTietHoaDons.Any())
                {
                    return NotFound(new { success = false, message = "Không tìm thấy chi tiết hóa đơn." });
                }

                return Ok( new { success = true, data = chiTietHoaDons });
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

                chiTietHoaDon.SoLuong = soLuongMoi;

                await dbc.SaveChangesAsync();

                return Ok(new { message = "Cập nhật số lượng thành công."});
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }

        [HttpPost]
        [Route("/chiTietHoaDon/Them")]
        public ActionResult themChiTietHoaDon(ChiTietHoaDon obj)
        {
            obj.GiaBan = 0;
            dbc.ChiTietHoaDons.Add(obj);
            dbc.SaveChanges();

            return Ok(new { success = true, message = "Thêm chi tiết hóa đơn thành công!" });
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
                return NotFound(); 
            }

            return Ok(gioHangs); 
        }

        [HttpPost]
        [Route("/gioHang/Them")]
        public IActionResult ThemVaoGioHang(GioHang obj)
        {
            try
            {
                
                var existingItem = dbc.GioHangs
                    .FirstOrDefault(g => g.MaKhachHang == obj.MaKhachHang && g.MaSanPham == obj.MaSanPham);

                if (existingItem != null)
                {
                    return NotFound(new { success = false, message = $"San pham da co trong cua hang!" });
                }
                else
                {
                   
                    obj.TrangThai = 1; 
                    dbc.GioHangs.Add(obj);
                    dbc.SaveChanges();

                    return Ok(new { success = true, message = "Thêm vào giỏ hàng thành công!" });
                }
            }
            catch (Exception ex)
            {
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
                return NotFound(new { success = false, message = $"khong tim thay san pham voi ID: {maSP}!" }); 
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
                return NotFound(new { success = false, message = $"khong tim thay san pham voi ID: {maSP}!" }); 
            }

            gioHang.TrangThai = 0;
            dbc.SaveChanges();

            return Ok(new { success = true, message = "sua so luong thanh cong!" });
        }

        [HttpGet]
        [Route("/gioHang/danhSachChiTiet/{maKhachHang}")]
        public async Task<IActionResult> ChiTietGioHang(int maKhachHang)
        {
            try
            {
                var chiTietHoaDons = await dbc.GioHangs.Where(sp => sp.MaKhachHang == maKhachHang)
                    .Join(
                        dbc.SanPhams,
                        gh => gh.MaSanPham,
                        sp => sp.MaSanPham,
                        (gh, sp) => new
                        {
                            gh.MaSanPham,
                            gh.MaKhachHang,
                            sp.TenSanPham,
                            sp.GiaXuat,
                            sp.HinhAnh,
                            gh.SoLuong,
                            
                        }
                    )
                    .ToListAsync();

                if (!chiTietHoaDons.Any())
                {
                    return NotFound(new { success = false, message = "Không tìm thấy chi tiết hóa đơn." });
                }

                return Ok(new { success = true, data = chiTietHoaDons });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = ex.Message });
            }
        }
    }
}


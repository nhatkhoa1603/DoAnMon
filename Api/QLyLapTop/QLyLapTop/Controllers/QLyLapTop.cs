using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
        [Route("/sanPham/timkiem/{id}")]
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
        public IActionResult danhSachHoaDon()
        {
            var danhsach = dbc.HoaDons.ToList();
            return Ok(new { success = true, data = danhsach });
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

        /* [HttpPost]
         [Route("/todo")]
         public ActionResult themHoaDon(HoaDon obj)
         {
             // Gán giá trị cho các trường thời gian khi tạo mới
             obj.CreatedAt = DateTime.Now;
             obj.UpdatedAt = DateTime.Now;
             obj.DeletedAt = null;

             dbc.Tasks.Add(obj);
             dbc.SaveChanges();

             return Ok(new { success = true, message = "Create new task successfully!" });
         }*/

        //------------------- gio hang ------------------------//

        [HttpGet]
        [Route("/gioHang/danhSach/{id}")]
        public IActionResult danhSachgioHang(int id)
        {
            var danhsach = dbc.HoaDons.Where(gh => gh.MaKhachHang == id).ToList();
            if (danhsach == null)
            {
                return NotFound(new { success = false, message = $"khong tim thay gio hang voi ID: {id}!" });
            }
            return Ok(new { success = true, data = danhsach });
        }

        [HttpPost]
        [Route("/gioHang/Them")]
        public ActionResult ThemVaoGioHang(GioHang obj)
        {
         // Gán giá trị cho các trường thời gian khi tạo mới
            obj.TrangThai = 1;

            dbc.GioHangs.Add(obj);
            dbc.SaveChanges();

            return Ok(new { success = true, message = "Thêm vào giỏ hàng thành công!" });
        }

         
    }
}


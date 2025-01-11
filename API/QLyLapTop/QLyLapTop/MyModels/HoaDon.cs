using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("HoaDon")]
public partial class HoaDon
{
    [Key]
    public int MaDonHang { get; set; }

    public int MaKhachHang { get; set; }

    public int? MaDiaChiGiao { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? NgayDatHang { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal? PhiVanChuyen { get; set; }

    public int? MaKhuyenMai { get; set; }

    public int? TrangThai { get; set; }
    public int? TongTien { get; set; }

}

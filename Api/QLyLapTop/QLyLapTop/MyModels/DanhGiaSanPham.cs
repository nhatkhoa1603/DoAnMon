using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("DanhGiaSanPham")]
public partial class DanhGiaSanPham
{
    [Key]
    public int MaDanhGia { get; set; }

    public int MaSanPham { get; set; }

    public int MaKhachHang { get; set; }

    public int? SoSao { get; set; }

    public string? MoTa { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? NgayDanhGia { get; set; }

    public bool TrangThai { get; set; }
}

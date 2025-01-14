using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("GioHang")]
public partial class GioHang
{
    [Key]
    public int MaKhachHang { get; set; }
    [Key]
    public int MaSanPham { get; set; }

    public int SoLuong { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal ThanhTien { get; set; }

    public int TrangThai { get; set; }

}

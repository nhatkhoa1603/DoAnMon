using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[PrimaryKey("MaHoaDon", "MaSanPham")]
[Table("ChiTietHoaDon")]
public partial class ChiTietHoaDon
{
    [Key]
    public int MaHoaDon { get; set; }

    [Key]
    public int MaSanPham { get; set; }

    public int SoLuong { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal GiaBan { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal? GiamGia { get; set; }

    [Column(TypeName = "decimal(22, 2)")]
    public decimal? ThanhTien { get; set; }

}

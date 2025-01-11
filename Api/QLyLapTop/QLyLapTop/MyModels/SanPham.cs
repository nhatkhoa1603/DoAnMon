using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("SanPham")]
public partial class SanPham
{
    [Key]
    public int MaSanPham { get; set; }

    [StringLength(255)]
    public string TenSanPham { get; set; } = null!;

    public int? MaThuongHieu { get; set; }

    [StringLength(255)]
    public string? XuatXu { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal? GiaNhap { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal? GiaXuat { get; set; }

    public int? SoLuongTonKho { get; set; }

    [StringLength(255)]
    public string? KhuVucKho { get; set; }

    [StringLength(255)]
    public string? HinhAnh { get; set; }

    [StringLength(255)]
    public string? Ram { get; set; }

    [Column("CPU")]
    [StringLength(255)]
    public string? Cpu { get; set; }

    public string? MoTa { get; set; }

    public int? TrangThai { get; set; }

   
}

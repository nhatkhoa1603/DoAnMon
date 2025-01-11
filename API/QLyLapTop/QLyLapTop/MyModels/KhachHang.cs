using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("KhachHang")]
public partial class KhachHang
{
    [Key]
    public int MaKhachHang { get; set; }

    [StringLength(255)]
    public string TenKhachHang { get; set; } = null!;

    [StringLength(10)]
    public string? GioiTinh { get; set; }

    [StringLength(255)]
    public string? DiaChi { get; set; }

    [StringLength(20)]
    [Unicode(false)]
    public string SoDienThoai { get; set; } = null!;

    [StringLength(255)]
    [Unicode(false)]
    public string Email { get; set; } = null!;

    public int? TrangThai { get; set; }

  
}

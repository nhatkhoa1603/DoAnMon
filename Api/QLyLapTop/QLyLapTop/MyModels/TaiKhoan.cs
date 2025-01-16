using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("TaiKhoan")]
[Index("TenDangNhap", Name = "UQ__TaiKhoan__55F68FC06A33D60E", IsUnique = true)]
public partial class TaiKhoan
{
    [Key]
    public int MaTaiKhoan { get; set; }

    [StringLength(50)]
    [Unicode(false)]
    public string TenDangNhap { get; set; } = null!;

    [StringLength(255)]
    [Unicode(false)]
    public string MatKhau { get; set; } = null!;

    [StringLength(20)]
    public string? LoaiTaiKhoan { get; set; }

    public int? TrangThai { get; set; } = 1;
}

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("KhuyenMai")]
public partial class KhuyenMai
{
    [Key]
    public int MaKhuyenMai { get; set; }

    [StringLength(255)]
    public string TenKhuyenMai { get; set; } = null!;

    public DateOnly? NgayBatDau { get; set; }

    public DateOnly? NgayKetThuc { get; set; }

    public int? PhanTramGiam { get; set; }

    public string? MoTaKhuyenMai { get; set; }

    public int? TrangThai { get; set; }

}

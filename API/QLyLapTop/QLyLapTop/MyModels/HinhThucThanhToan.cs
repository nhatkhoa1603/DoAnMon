using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("HinhThucThanhToan")]
public partial class HinhThucThanhToan
{
    [Key]
    public int MaHinhThucThanhToan { get; set; }

    [StringLength(255)]
    public string TenHinhThucThanhToan { get; set; } = null!;

    public string? MoTa { get; set; }

    public int? TrangThai { get; set; }

}

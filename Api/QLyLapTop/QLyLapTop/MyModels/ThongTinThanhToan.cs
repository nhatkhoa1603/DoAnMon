using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("ThongTinThanhToan")]
public partial class ThongTinThanhToan
{
    [Key]
    public int MaThanhToan { get; set; }

    public int MaHoaDon { get; set; }

    public int MaHinhThucThanhToan { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? NgayThanhToan { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal SoTien { get; set; }
    public int TrangThai { get; set; }

}

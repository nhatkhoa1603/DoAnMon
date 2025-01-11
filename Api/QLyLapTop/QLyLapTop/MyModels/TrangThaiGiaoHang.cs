using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("TrangThaiGiaoHang")]
public partial class TrangThaiGiaoHang
{
    [Key]
    public int MaTrangThai { get; set; }

    public int MaHoaDon { get; set; }

    [StringLength(50)]
    public string TrangThai { get; set; } = null!;

    [Column(TypeName = "datetime")]
    public DateTime? ThoiGian { get; set; }

}

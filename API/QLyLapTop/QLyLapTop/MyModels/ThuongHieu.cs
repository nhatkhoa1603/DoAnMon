using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("ThuongHieu")]
public partial class ThuongHieu
{
    [Key]
    public int MaThuongHieu { get; set; }

    [StringLength(255)]
    public string TenThuongHieu { get; set; } = null!;

}

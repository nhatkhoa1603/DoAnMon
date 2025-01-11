using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

[Table("DiaChiGiaoHang")]
public partial class DiaChiGiaoHang
{
    [Key]
    public int MaDiaChi { get; set; }

    public int MaKhachHang { get; set; }

    [StringLength(255)]
    public string TenNguoiNhan { get; set; } = null!;

    [StringLength(20)]
    [Unicode(false)]
    public string SoDienThoai { get; set; } = null!;

    [StringLength(255)]
    public string DiaChi { get; set; } = null!;

    [Column("Tinh_ThanhPho")]
    [StringLength(100)]
    public string TinhThanhPho { get; set; } = null!;

    [Column("Quan_Huyen")]
    [StringLength(100)]
    public string QuanHuyen { get; set; } = null!;

    [Column("Phuong_Xa")]
    [StringLength(100)]
    public string PhuongXa { get; set; } = null!;

    public bool? MacDinh { get; set; }

    public int? TrangThai { get; set; }

}

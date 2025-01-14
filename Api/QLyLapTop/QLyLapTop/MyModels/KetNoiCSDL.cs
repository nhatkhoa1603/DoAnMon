using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace QLyLapTop.MyModels;

public partial class KetNoiCSDL : DbContext
{
    public KetNoiCSDL()
    {
    }

    public KetNoiCSDL(DbContextOptions<KetNoiCSDL> options)
        : base(options)
    {
    }

    public virtual DbSet<ChiTietHoaDon> ChiTietHoaDons { get; set; }

    public virtual DbSet<DanhGiaSanPham> DanhGiaSanPhams { get; set; }

    public virtual DbSet<DiaChiGiaoHang> DiaChiGiaoHangs { get; set; }

    public virtual DbSet<GioHang> GioHangs { get; set; }

    public virtual DbSet<HinhThucThanhToan> HinhThucThanhToans { get; set; }

    public virtual DbSet<HoaDon> HoaDons { get; set; }

    public virtual DbSet<KhachHang> KhachHangs { get; set; }

    public virtual DbSet<KhuyenMai> KhuyenMais { get; set; }

    public virtual DbSet<SanPham> SanPhams { get; set; }

    public virtual DbSet<TaiKhoan> TaiKhoans { get; set; }

    public virtual DbSet<ThongTinThanhToan> ThongTinThanhToans { get; set; }

    public virtual DbSet<ThuongHieu> ThuongHieus { get; set; }

    public virtual DbSet<TrangThaiGiaoHang> TrangThaiGiaoHangs { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {

        OnModelCreatingPartial(modelBuilder);

        modelBuilder.Entity<GioHang>()
           .HasKey(g => new { g.MaKhachHang, g.MaSanPham });
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

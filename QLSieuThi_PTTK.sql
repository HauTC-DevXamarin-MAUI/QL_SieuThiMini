create database QLSieuThi_PTTK
use QLSieuThi_PTTK
drop database QLSieuThi_PTTK
create table LoaiKH
(
 MaLKH char(5) primary key,
 TenLKH nvarchar(20)
)

create table KhachHang
(
 MaKH char(5) primary key,
 HoTen nvarchar(20),
 DiaChi nvarchar(30),
 SDT int,
 QueQuan nvarchar(20),
 DTL int,
 MaLKH char(5) foreign key references LoaiKH(MaLKH)
)

create table ChucVu
(
 MaCV char(5) primary key,
 TenCV nvarchar(20)
)

create table NhanVien
(
 MaNV char(5) primary key,
 HoTen nvarchar(20),
 DiaChi nvarchar(30),
 SDT int,
 QueQuan nvarchar(20),
 NgaySinh date,
 NgayVao date,
 Email char(30),
 MaCV char(5) foreign key references ChucVu(MaCV)
)

create table NhaCC
(
 MaNCC char(6) primary key,
 TenNCC nvarchar(20),
 DiaChi nvarchar(30)
)

create table LoaiSP
(
 MaLSP char(6) primary key,
 TenLSP nvarchar(20)
)

create table SanPham
(
 MaSP char(5) primary key,
 TenSP nvarchar(20),
 SL int,
 GiaSP int,
 GiaSP_Nhap int,
 MaLSP char(6) foreign key references LoaiSP(MaLSP)
)

create table HoaDon
(
 MaHD int primary key,
 NgayLap date,
 MaKH char(5) foreign key references KhachHang(MaKH),
 MaNV char(5) foreign key references NhanVien(MaNV),
 ThanhTien int
)

create table CTHD
(
 MaHD int foreign key references HoaDon(MaHD),
 MaSP char(5) foreign key references SanPham(MaSP),
 SL int,
 Tong int,
 constraint pk_CTHD primary key (MaHD,MaSP)
)

create table PhieuNhap
(
 MaPN int primary key,
 NgayNhap date,
 MaNCC char(6) foreign key references NhaCC(MaNCC),
 MaNV char(5) foreign key references NhanVien(MaNV),
 ThanhTien int
)

create table CT_PN
(
 MaPN int foreign key references PhieuNhap(MaPN),
 MaSP char(5) foreign key references SanPham(MaSP),
 SL int,
 Tong int,
 constraint fk_CTPN primary key (MaPN,MaSP)
)


select * from LoaiKH
insert into LoaiKH values
('LKH01',N'Thân thiết'),
('LKH02',N'Phổ thông')

select * from LoaiSP
insert into LoaiSP values
('LSP001',N'Đồ dùng gia đình'),
('LSP002',N'Thực phẩm'),
('LSP003',N'Thức ăn'),
('LSP004',N'Trang phục')

select * from ChucVu
insert into ChucVu values
('CV001',N'Thu ngân'),
('CV002',N'Kiểm hàng'),
('CV003',N'Kiểm Kho'),
('CV004',N'Quản lý')

select * from NhaCC
insert into NhaCC values
('NCC001',N'Nhà cung cấp 1',N'Tân Bình'),
('NCC002',N'Nhà cung cấp 2',N'Phú Nhuận'),
('NCC003',N'Nhà cung cấp 3',N'Tân Phú'),
('NCC004',N'Nhà cung cấp 4',N'Gò Vấp'),
('NCC005',N'Nhà cung cấp 5',N'Bình Thạnh')

select * from KhachHang
insert into KhachHang values
('KH001',N'Nguyễn Hữu Minh Mẫn',N'Phú Nhuận',123456789,N'Sài Gòn',0,'LKH02'),
('KH002',N'Hoàng Minh Nhật',N'Bình Tân',456789123,N'Sài Gòn',0,'LKH01'),
('KH003',N'Phạm Hồng Quân',N'Quận 11',789123456,N'Biên Hòa',0,'LKH02'),
('KH004',N'Đỗ Đình Tuấn Phát',N'Bình Tân',234567890,N'Long An',0,'LKH01'),
('KH005',N'Nguyễn Minh Hữu Tài',N'Tân Phú',567890234,N'Sài Gòn',0,'LKH02')

select* from NhanVien
insert into NhanVien values
('NV001',N'Nguyễn Trung Hiếu',N'Gò Vấp',0344558371,N'Sài Gòn','1-1-2000','3-3-2019','bcd@gmail.com','CV003'),
('NV002',N'Đoàn Minh Khoa',N'Quận 12',0462857395,N'Sài Gòn','2-2-2000','3-3-2019','abc@gmail.com','CV001'),
('NV003',N'Trần Ngọc Khách',N'Gò Vấp',0375839562,N'Sài Gòn','3-3-2000','3-3-2019','def@gmail.com','CV002'),
('NV004',N'Trần Đông Anh',N'Phú Nhuận',0386957386,N'Sài Gòn','4-4-2000','3-3-2019','efg@gmail.com','CV004'),
('NV005',N'Đinh Ngọc Trí',N'Bình Thạnh',0593857629,N'Sài Gòn','5-5-2000','3-3-2019','fgh@gmail.com','CV001')

select * from SanPham
insert into SanPham values
('SP001',N'Bột giặt',100,200000,200000*0.7,'LSP001'),
('SP002',N'Gà nguyên con',100,220000,220000*0.7,'LSP003'),
('SP003',N'Áo thun nữ',100,130000,130000*0.7,'LSP004'),
('SP004',N'Rau cải',100,20000,20000*0.7,'LSP002'),
('SP005',N'Thịt heo',100,150000,150000*0.7,'LSP003')

select count(*) from HoaDon
alter PROC InHoaDon @MaHD int
AS BEGIN
	SELECT HD.MaHD,HD.NgayLap,NV.HoTen,KH.HoTen,CTHD.MaSP,SP.TenSP,CTHD.SL,SP.GiaSP,CTHD.Tong,HD.ThanhTien
	FROM HOADON HD,CTHD CTHD,SANPHAM SP,NHANVIEN NV,KhachHang KH
	WHERE HD.MaHD = CTHD.MaHD
	AND CTHD.MaSP = SP.MaSP
	AND HD.MaNV = NV.MaNV
	AND HD.MaKH=KH.MaKH
	AND HD.MaHD = @MaHD
ENd

alter PROC InPN @MaPN int
AS BEGIN
	SELECT PN.MaPN,PN.NgayNhap,NV.HoTen,NC.TenNCC,CT.MaSP,SP.TenSP,CT.SL,SP.GiaSP_Nhap,CT.Tong,PN.ThanhTien
	FROM PhieuNhap PN,CT_PN CT,SANPHAM SP,NHANVIEN NV,NhaCC NC
	WHERE PN.MaPN = CT.MaPN
	AND CT.MaSP = SP.MaSP
	AND PN.MaNV = NV.MaNV
	AND PN.MaNCC=NC.MaNCC
	AND PN.MaPN = @MaPN
ENd
delete from HoaDon where MaHD=2


alter trigger Up_Sl_TT on CTHD
for insert
as
begin
   update SanPham
   set SL=SanPham.SL-inserted.SL
   from inserted
   where inserted.MaSP=SanPham.MaSP

   UPDATE KhachHang
   set DTL=DTL+0.01*inserted.Tong
   from inserted,HoaDon
   where inserted.MaHD=HoaDon.MaHD
   and KhachHang.MaKH=HoaDon.MaKH
   
end

create trigger Up_Sl_PN on CT_PN
for insert
as
begin
   update SanPham
   set SL=SanPham.SL+inserted.SL
   from inserted
   where inserted.MaSP=SanPham.MaSP
   
end


select * from HoaDon
select * from CT_PN
select * from PhieuNhap
delete from PhieuNhap


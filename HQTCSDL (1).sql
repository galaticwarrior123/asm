CREATE DATABASE QLCAFE
GO

USE QLCAFE
GO

CREATE TABLE NHAN_VIEN(
	MaNV char(5) primary key, --MaNV được lấy làm Tài khoản đăng nhập
	HoTen nvarchar(30) not null, 
	NgaySinh date not null,
	GioiTinh nvarchar(5) not null,
	SDT char(11) check (len(SDT)=10) not null,
	DiaChi nvarchar(30) not null,
	PhanQuyen bit,
	MatKhau char(30) not null check(len(MatKhau)>=6),
)
GO

CREATE TABLE CA_LAM_VIEC(
	MaCa char(5) primary key,
	TenCa nvarchar(20) not null,
	GioBatDau time not null,
	GioKetThuc time not null,
	Luong int not null
)
GO

CREATE TABLE LICH_LAM_VIEC(
	MaCa char(5) references CA_LAM_VIEC(MaCa),
	MaNV char(5) references NHAN_VIEN(MaNV),
	NgayLam date not null, 
	TGChamCong time,
	unique(MaCa,MaNV,NgayLam)
)
GO

CREATE TABLE VI_PHAM(
	MaNV char(5) references NHAN_VIEN(MaNV),
	Ngay date,
	NoiDung nvarchar(100),
	LuongBiTru int,
)
GO

CREATE TABLE LOAI_THANH_VIEN(
	MaLoai char(5) primary key,
	TenLoai nvarchar(15) not null,
	KhuyenMai int not null,
)
GO

CREATE TABLE KHACH_HANG(
	MaKH char(5) primary key,
	HoTen nvarchar(30) not null,
	SDT char(11) check (len(SDT)=10) not null,
	DiaChi nvarchar(30) not null,
	DiemTV int,
	LoaiTV char(5) references LOAI_THANH_VIEN(MaLoai)
)
GO

CREATE TABLE HOA_DON(
	MaHD char(5) primary key,
	ThoiGianIn datetime not null,
	MaNV char(5) references NHAN_VIEN(MaNV),
	MaKH char(5) references KHACH_HANG(MaKH),
	TongTien int,
	ChiPhiPhatSinh int,
	GiamGia int,
	TruDiemVIP int,
	TienPhaiTra int,
	PTTT nvarchar(30) not null,
)
GO

CREATE TABLE MON(
	MaMon char(5) primary key,
	TenMon nvarchar(30) not null,
	Gia int not null,
	AnhMon image,
	TinhTrang bit,
)
GO

CREATE TABLE CHI_TIET_HOA_DON(
	MaHD char(5) references HOA_DON(MaHD),
	MaMon char(5) references MON(MaMon),
	SoLuong int not null,
	ThanhTien int not null,
	unique(MaHD,MaMon)
)
GO

CREATE TABLE NGUYEN_LIEU(
	MaNL char(5) primary key,
	TenNL nvarchar(30) not null,
	NhomNL nvarchar(30) not null,
	DonViTinh nvarchar(10) not null,
	SoLuongTon int not null
)
GO

CREATE TABLE THANH_PHAN_NGUYEN_LIEU(
	MaMon char(5) references MON(MaMon),
	MaNL char(5) references NGUYEN_LIEU(MaNL),
	SoLuong int,
	unique(MaMon,MaNL)
)
GO

CREATE TABLE NHA_CUNG_CAP(
	MaNCC char(5) primary key,
	TenNCC nvarchar(30) not null,
	DiaChi nvarchar(30) not null,
	SDT char(11) check (len(SDT)=10) not null 
)
GO

CREATE TABLE PHIEU_NHAP(
	MaDonHang char(5) primary key,
	MaNCC char(5) references NHA_CUNG_CAP(MaNCC),
	TongTien int not null,
	NgayGiao date
)
GO

CREATE TABLE CHI_TIET_PHIEU_NHAP(
	MaDonHang char(5) references PHIEU_NHAP(MaDonHang),
	MaNL char(5) references NGUYEN_LIEU(MaNL),
	DonViTinh nvarchar(10) not null,
	DonGia int not null,
	SoLuong int not null,
	ThanhTien int not null,
	unique(MaDonHang,MaNL)
)
GO

--Nhap du lieu cho NHAN_VIEN
Insert into NHAN_VIEN Values ('NV01',N'Triệu Nhật Nam','2003-05-10','Nam','0123456789',N'1 Võ Văn Ngân', 1,'123456')
Insert into NHAN_VIEN Values ('NV02',N'Phạm Ngọc Thạch','2001-07-23','Nam','0223456789',N'13 Lý Chính Thắng', 0,'123456')
Insert into NHAN_VIEN Values ('NV03',N'Nguyễn Thế Thành','2003-2-13','Nam','0323456789',N'253 Chu Văn An', 0,'123456')
Insert into NHAN_VIEN Values ('NV04',N'Nguyễn Trọng Phúc','2003-8-26','Nam','0423456789',N'123 Kha Vạn Cân', 0,'123456')
Insert into NHAN_VIEN Values ('NV05',N'Ngô Bảo Đại','2003-3-31','Nam','0153456789',N'67 Lê Văn Duyệt', 0,'123456')
Insert into NHAN_VIEN Values ('NV06',N'Lê Đức Minh','2003-11-19','Nam','0163456789',N'24 Hai Bà Trưng', 0,'123456')
Insert into NHAN_VIEN Values ('NV07',N'Phạm Ngọc Tèo','2003-2-25','Nam','0173456789',N'15 Nguyễn Văn Đậu', 0,'123456')
Insert into NHAN_VIEN Values ('NV08',N'Trần Anh Duy','2003-6-26','Nam','0183456789',N'167 Vạn Kiếp', 0,'123456')
Insert into NHAN_VIEN Values ('NV09',N'Nguyễn Ngọc Uyên','2003-4-15',N'Nữ','0193456789',N'244 Hoàng Hoa Thám', 0,'123456')
Insert into NHAN_VIEN Values ('NV10',N'Vũ Ngọc An','2003-12-3',N'Nữ','0203456789',N'211 Võ Trường Toản', 0,'123456')
GO

--Nhap du lieu cho CA_LAM_VIEC
Insert into CA_LAM_VIEC Values ('CS',N'Ca Sáng','6:30:00','11:30:00', 90000)
Insert into CA_LAM_VIEC Values ('CG',N'Ca Giữa','9:30:00','14:30:00', 90000)
Insert into CA_LAM_VIEC Values ('CC',N'Ca Chiều','12:30:00','17:30:00', 90000)
Insert into CA_LAM_VIEC Values ('CT',N'Ca Tối','17:30:00','22:30:00', 90000)
GO

--Nhap du lieu cho LICH_LAM_VIEC
Insert into LICH_LAM_VIEC Values ('CS','NV02','2023-3-3','6:20:00')
Insert into LICH_LAM_VIEC Values ('CC','NV02','2023-3-3','12:20:00')
Insert into LICH_LAM_VIEC Values ('CS','NV10','2023-3-3','6:15:00')
Insert into LICH_LAM_VIEC Values ('CT','NV10','2023-3-3','17:10:00')
Insert into LICH_LAM_VIEC Values ('CS','NV06','2023-3-4','6:20:00')
Insert into LICH_LAM_VIEC Values ('CC','NV06','2023-3-4','12:20:00')
Insert into LICH_LAM_VIEC Values ('CT','NV07','2023-3-4','17:20:00')
GO

--Nhap du lieu cho LOAI_THANH_VIEN
Insert into LOAI_THANH_VIEN Values ('TV1',N'Thành Viên',0)
Insert into LOAI_THANH_VIEN Values ('TV2',N'Thân Thiết',5)
Insert into LOAI_THANH_VIEN Values ('TV3',N'VIP',15)
GO

--Nhap du lieu cho KHACH_HANG
Insert into KHACH_HANG Values ('KH01',N'Lê Anh Dũng','0213456789',N'44 Trường Sa', 0,'TV1')
Insert into KHACH_HANG Values ('KH02',N'Phạm Minh Tân','0223456789',N'126 Trần Hưng Đạo', 0,'TV3')
Insert into KHACH_HANG Values ('KH03',N'Nguyễn Ngọc Thảo','0233456789',N'32 Cách Mạng Tháng 8', 0,'TV2')
Insert into KHACH_HANG Values ('KH04',N'Huỳnh Gia Phú','1243456789',N'156 Võ Thị Sáu', 0,'TV1')
Insert into KHACH_HANG Values ('KH06',N'Lý Minh Tâm','1253456789',N'90 Phan Đăng Lưu', 0,'TV1')
Insert into KHACH_HANG Values ('KH07',N'Nguyễn Minh Triết','0353456789',N'90 Phan Đăng Lưu', 0,'TV2')
Insert into KHACH_HANG Values ('KH08',N'Ngô Minh Thuận','0453456789',N'90 Phan Đăng Lưu', 0,'TV2')
Insert into KHACH_HANG Values ('KH09',N'Đinh Thanh Tùng','0553456789',N'90 Phan Đăng Lưu', 0,'TV3')
Insert into KHACH_HANG Values ('KH10',N'Trần Hữu Thiện','0653456789',N'90 Phan Đăng Lưu', 0,'TV1')
Insert into KHACH_HANG Values ('KH11',N'Lê Uy Vũ','0753456789',N'90 Phan Đăng Lưu', 0,'TV1')
Insert into KHACH_HANG Values ('KH12',N'Nguyễn Bảo Bình','0853456789',N'90 Phan Đăng Lưu', 0,'TV1')
GO

--Nhap du lieu cho MON
Insert into MON Values ('M01',N'Cà phê đen đá',20000,null,null)
Insert into MON Values ('M02',N'Cà phê đen nóng',25000,null,null)
Insert into MON Values ('M03',N'Cà phê sữa đá',20000,null,null)
Insert into MON Values ('M04',N'Cà phê sữa nóng',25000,null,null)
Insert into MON Values ('M05',N'Bạc xỉu đá',20000,null,null)
Insert into MON Values ('M06',N'Bạc xỉu nóng',25000,null,null)
Insert into MON Values ('M07',N'Latte đá',30000,null,null)
Insert into MON Values ('M08',N'Latte nóng',30000,null,null)
Insert into MON Values ('M09',N'Cappuccino đá',20000,null,null)
Insert into MON Values ('M10',N'Cappuccino nóng',20000,null,null)
GO

--Nhap du lieu cho NGUYEN_LIEU
Insert into NGUYEN_LIEU Values ('NL01',N'Cà phê',N'Nguyên liệu','g',5000)
Insert into NGUYEN_LIEU Values ('NL02',N'Sữa đặc',N'Nguyên liệu','g',2000)
Insert into NGUYEN_LIEU Values ('NL03',N'Sữa tươi',N'Nguyên liệu','g',3000)
Insert into NGUYEN_LIEU Values ('NL04',N'Bột Trà Xanh',N'Nguyên liệu','g',3000)
Insert into NGUYEN_LIEU Values ('NL05',N'Bột Hồng trà',N'Nguyên liệu','g',3000)
Insert into NGUYEN_LIEU Values ('NL06',N'Đường',N'Nguyên liệu','g',2000)
Insert into NGUYEN_LIEU Values ('NL07',N'Bột cacao',N'Nguyên liệu','g',5000)
GO

--Nhap du lieu cho THANH_PHAN_NGUYEN_LIEU
--Mon 1
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M01','NL01',25)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M01','NL06',5)
--Mon 2
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M02','NL01',25)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M02','NL06',5)
--Mon 3
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M03','NL01',25)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M03','NL02',5)
--Mon 4
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M04','NL01',25)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M04','NL02',5)
--Mon 5
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M05','NL01',20)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M05','NL02',50)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M05','NL03',30)
--Mon 6
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M06','NL01',20)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M06','NL02',50)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M06','NL03',30)
--Mon 7
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M07','NL01',10)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M07','NL03',175)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M07','NL06',20)
--Mon 8
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M08','NL01',10)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M08','NL03',200)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M08','NL06',20)
--Mon 9
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M09','NL01',25)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M09','NL03',150)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M09','NL06',10)
--Mon 10
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M10','NL01',25)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M10','NL03',125)
Insert into THANH_PHAN_NGUYEN_LIEU Values ('M10','NL06',10)
GO

--Nhap du lieu cho HOA_DON
Insert into HOA_DON Values ('HD01','2023-3-3 9:40:20','NV02','KH01',null,null,null,20000,N'Tiền Mặt')
Insert into HOA_DON Values ('HD02','2023-3-3 10:40:20','NV02','KH04',null,null,null,55000,N'Tiền Mặt') 
Insert into HOA_DON Values ('HD03','2023-3-4 19:40:20','NV07','KH06',null,null,null,40000,N'Tiền Mặt')
GO

--Nhap du lieu cho CHI_TIET_HOA_DON
Insert into CHI_TIET_HOA_DON Values ('HD01','M01',1,20000)
Insert into CHI_TIET_HOA_DON Values ('HD02','M04',1,25000)
Insert into CHI_TIET_HOA_DON Values ('HD02','M07',1,30000)
Insert into CHI_TIET_HOA_DON Values ('HD03','M03',1,20000)
Insert into CHI_TIET_HOA_DON Values ('HD03','M05',1,20000)
GO

--Nhap du lieu cho NHA_CUNG_CAP
Insert into NHA_CUNG_CAP Values ('N01',N'Cà phê wibu', N'234 Nơ Trang Long','0942132131')
Insert into NHA_CUNG_CAP Values ('N02',N'Tạp hóa đa năng', N'234 Nơ Trang Long','0942132131')
GO

--Nhap du lieu cho NHA_CUNG_CAP
Insert into PHIEU_NHAP Values ('DH01','N01',725000,'2023-3-1')
Insert into PHIEU_NHAP Values ('DH02','N02',180000,'2023-3-1')

--Nhap du lieu cho CHI_TIET_PHIEU_NHAP
Insert into CHI_TIET_PHIEU_NHAP Values ('DH01', 'NL01', 'Kg', 50000, 5, 250000)
Insert into CHI_TIET_PHIEU_NHAP Values ('DH01', 'NL04', 'Kg', 30000, 3, 150000)
Insert into CHI_TIET_PHIEU_NHAP Values ('DH01', 'NL05', 'Kg', 30000, 3, 150000)
Insert into CHI_TIET_PHIEU_NHAP Values ('DH01', 'NL07', 'Kg', 35000, 5, 175000)
Insert into CHI_TIET_PHIEU_NHAP Values ('DH02', 'NL02', 'Kg', 25000, 2, 50000)
Insert into CHI_TIET_PHIEU_NHAP Values ('DH02', 'NL03', 'Kg', 30000, 3, 90000)
Insert into CHI_TIET_PHIEU_NHAP Values ('DH02', 'NL06', 'Kg', 20000, 2, 40000)
GO





/*CREATE FUNCTION LAY_DSNHANVIEN()
RETURNS TABLE
AS
RETURN SELECT LICH_LAM_VIEC.MaCa,LICH_LAM_VIEC.NgayLam,NHAN_VIEN.MaNV,NHAN_VIEN.HoTen
		FROM NHAN_VIEN, LICH_LAM_VIEC 
		WHERE NHAN_VIEN.MaNV=LICH_LAM_VIEC.MaNV 
GO

CREATE PROCEDURE SuathongtinNV (@maNV char (5),@maDangnhap char(30), @matKhau char(10))
AS
BEGIN
		UPDATE NHAN_VIEN
		SET MaDangNhap=@maDangnhap, MatKhau=@matKhau	
		where MaNV=@maNV
END
GO*/



 
 --trigger cau 8
Create trigger Xoa_mon_an on MON
instead of delete
as
declare @Ma_mon char(5)
select @Ma_mon=n1.MaMon 
from deleted n1
BEGIN Tran
	begin try
		update MON set MaMon= null where MaMon=@Ma_mon
		 
		-- Xóa món ra khỏi phân nhóm
		Delete From MON where MaMon=@Ma_mon

		-- Xóa thành phần nguyên nguyên liệu của món đó ra khỏi phân nhóm
		Delete From THANH_PHAN_NGUYEN_LIEU where MaMon=@Ma_mon

		Commit tran
	end try
	begin catch
			rollback
	end catch
GO

--trigger cau 6
Create trigger Tao_user_nhan_vien on NHAN_VIEN
after insert 
as
declare @dang_nhap nvarchar(30), @mat_khau varchar(20)
select @dang_nhap=n1.MaDangNhap, @mat_khau=n1.MatKhau
from inserted n1
begin 
	declare @sqlString nvarchar(2000)

	set @sqlString='Create login['+@dang_nhap+'] with mat khau='''+@mat_khau
	exec(@sqlString)


	set @sqlString='Create user' +@dang_nhap+'for login'+@dang_nhap
	exec(@sqlString)
end
go


-- trigger cau 9
Create trigger tinh_trang_mon on MON 
after update
as
declare @ma_mon char(5), @soLuongHoaDon int, @soLuongnguyenlieu int, @soLuonghangton int, @tinhTrang bit
select @ma_mon=n1.MaMon, @soLuongHoaDon=cthd.SoLuong,@soLuongnguyenlieu=tpnl.SoLuong, @soLuonghangton=nl.SoLuongTon, @tinhTrang=n1.TinhTrang
	from inserted n1 inner join THANH_PHAN_NGUYEN_LIEU tpnl on n1.MaMon=tpnl.MaMon
			inner join NGUYEN_LIEU nl on nl.MaNL = tpnl.MaNL 
			inner join CHI_TIET_HOA_DON cthd on cthd.MaMon=n1.MaMon
begin
	declare @soLuong int
	set @soLuong=@soLuongHoaDon*@soLuongnguyenlieu
	if(@soLuong>@soLuonghangton)
		update	MON set @tinhTrang=1 where MaMon=@ma_mon
end


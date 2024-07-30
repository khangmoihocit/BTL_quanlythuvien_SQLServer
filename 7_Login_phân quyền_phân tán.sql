create login khangbtl with password = '123';
use quanlythuvien;
create user khangbtl for login khangbtl;
grant select on docgia to khangbtl
grant insert, update, delete, select on Sach to khangbtl

--phân tán (login: khangpham, user: khang)
create database quanlythuvien1;
use quanlythuvien1;
create user khang for login khangpham;

create table quanlythuvien1.dbo.Sach (
    iMaSach int primary key,
    sTenSach nvarchar(200) not null,
    iMaNXB int not null,
    iMaTacGia int not null,
    dNgayXuatBan date,
    iSoLuong int not null,
    sMoTa nvarchar(225),
	sTheLoaiSach nvarchar(30)
);
--thủ tục thêm dữ liệu Sách vào trạm phù hợp:
-- -trạm 1: Sách có thể loại là N'truyện'.
-- -trạm 2: Sách có thể loại khác.
use quanlythuvien;
create procedure insert_Sach_theloai
	@iMaSach int,
    @sTenSach nvarchar(200),
    @iMaNXB int ,
    @iMaTacGia int ,
    @dNgayXuatBan date,
    @iSoLuong int ,
    @sMoTa nvarchar(225),
	@sTheLoaiSach nvarchar(30)
as
if @sTheLoaiSach = N'Truyện'
begin
	insert into quanlythuvien1.dbo.Sach(iMaSach ,sTenSach,iMaNXB,iMaTacGia,dNgayXuatBan ,iSoLuong ,sMoTa,sTheLoaiSach)
	values (@iMaSach ,@sTenSach,@iMaNXB,@iMaTacGia,@dNgayXuatBan ,@iSoLuong ,@sMoTa,@sTheLoaiSach)
end
else
begin
	insert into linkmayao.quanlythuvien2.dbo.Sach(iMaSach ,sTenSach,iMaNXB,iMaTacGia,dNgayXuatBan ,iSoLuong ,sMoTa,sTheLoaiSach)
	values (@iMaSach ,@sTenSach,@iMaNXB,@iMaTacGia,@dNgayXuatBan ,@iSoLuong ,@sMoTa,@sTheLoaiSach)
end

--thủ tục phân tán dữ liệu cho bảng Sách
use quanlythuvien;
create procedure phantan_sach
as
begin
	declare @iMaSach int,@sTenSach nvarchar(200),@iMaNXB int ,@iMaTacGia int ,@dNgayXuatBan date,@iSoLuong int 
	,@sMoTa nvarchar(225),@sTheLoaiSach nvarchar(30)
	declare SachCursor cursor for select * from quanlythuvien.dbo.Sach

	open SachCursor
	
	fetch next from SachCursor into @iMaSach ,@sTenSach,@iMaNXB,@iMaTacGia,@dNgayXuatBan ,
	@iSoLuong ,@sMoTa,@sTheLoaiSach

	while @@FETCH_STATUS = 0
	begin
		exec insert_Sach_theloai @imasach, @sTenSach,@iMaNXB,@iMaTacGia,@dNgayXuatBan ,@iSoLuong ,@sMoTa,@sTheLoaiSach
	
		fetch next from SachCursor into @iMaSach ,@sTenSach,@iMaNXB,@iMaTacGia,@dNgayXuatBan ,
		@iSoLuong ,@sMoTa,@sTheLoaiSach
	end
end

use quanlythuvien
exec phantan_sach;

select * from quanlythuvien.dbo.Sach;
select * from quanlythuvien1.dbo.Sach;
select * from linkmayao.quanlythuvien2.dbo.Sach;

-- phân tán dọc
--máy chủ
use quanlythuvien_1

create table quanlythuvien1.dbo.ChiTietMuonSach 
(
	iMaMuonSach int not null,
	iMaSach int
)
use quanlythuvien;
create proc nhapdl_chitietmuonsach
	@iMaMuonSach int ,
	@iMaSach int ,
	@iSoLuong int
as
begin
	insert into quanlythuvien1.dbo.ChiTietMuonSach values(@iMaMuonSach,@iMaSach)
	insert into linkmayao.quanlythuvien2.dbo.ChiTietMuonSach values(@iMaMuonSach,@iSoLuong)
end
--
exec nhapdl_chitietmuonsach 10000,1000,10

select * from quanlythuvien1.dbo.ChiTietMuonSach
select * from linkmayao.quanlythuvien2.dbo.ChiTietMuonSach 
select * from dbo.ChiTietMuonSach

select s1.imamuonsach, s1.imasach, s2.isoluong
from quanlythuvien1.dbo.ChiTietMuonSach s1 inner join linkmayao.quanlythuvien2.dbo.ChiTietMuonSach s2
		on s1.imamuonsach = s2.imamuonsach

create proc pt_chitietmuonsach
as
begin
	declare @iMaMuonSach int ,
			@iMaSach int ,
			@iSoLuong int
	declare ChiTietMuonSachCursor cursor for select * from dbo.ChiTietMuonSach
	open ChiTietMuonSachCursor 
	fetch next from ChiTietMuonSachcursor into @iMaMuonSach ,@iMaSach ,@iSoLuong
	while @@FETCH_STATUS=0
		begin
			exec nhapdl_chitietmuonsach @iMaMuonSach ,@iMaSach ,@iSoLuong
			fetch next from ChiTietMuonSachcursor into @iMaMuonSach ,@iMaSach ,@iSoLuong
		end
end

exec pt_chitietmuonsach

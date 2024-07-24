--tạo view hiện dl
use quanlythuvien;
--1 Hiện thị ds sách có số lượng lớn hơn 30
create view vwslsach
as
	select iMaSach , sTenSach
	from Sach
	where iSoLuong > 30

select * from vwslsach

--2 hiển thị các sách có điểm đánh giá > =4
create view vwdanhgia
as
	select DanhGia.iMaSach , sTenSach
	from DanhGia join Sach on DanhGia.iMaSach= Sach.iMaSach
	where DanhGia.fDiemDanhGia >=4

select * from vwdanhgia

-- 3 . Cho biết Tên sách mượn của từng phiếu mượn
create view vwphieumuon
as
	select MuonSach.iMaMuonSach , ChiTietMuonSach.iMaSach ,sTenSach
	from MuonSach join ChiTietMuonSach on MuonSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
				join Sach on ChiTietMuonSach.iMaSach=Sach.iMaSach

select * from vwphieumuon

--4 . Cho biết Tên độc giả và số lần mượn sách của anh ta
create view vwDocGia
as
	select sTenDocGia , count(MuonSach.iMaDocGia) as slmuon
	from MuonSach join ChiTietMuonSach on MuonSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
				join DocGia on MuonSach.iMaDocGia=DocGia.iMaDocGia
	group by sTenDocGia

-- 5. cho biết tên nhà xb và tên sách mà họ xb
create view vwxuatban
as
	select sTenNXB , sTenSach 
	from NhaXuatBan join Sach on NhaXuatBan.iMaNXB=Sach.iMaNXB

--6 . cho biết mã sách và tổng số sách được mượn 
create view vwtongsach
as
	select iMaSach , sum(iSoLuong) as tongsach
	from ChiTietMuonSach
	group by iMaSach

--7.
select * from MuonSach
select * from TraSach
select * from PhieuPhat
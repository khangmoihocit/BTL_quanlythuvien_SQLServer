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
	0

--7.  tạo view cho biết Số lượng sách được mượn trong từng tháng năm 2023.
create view vwslsachmuontrongtungthangnam2023
as 
	select sum(ChiTietMuonSach.iSoLuong) as [số lượng được mượn sách ],
		   month(Muonsach.dNgayMuon) as [tháng (năm 2023)]
	from MuonSach join ChiTietMuonSach on MuonSach.iMaMuonSach = ChiTietMuonSach. iMaMuonSach
	where year(Muonsach.dNgayMuon) = 2023
	group by month(Muonsach.dNgayMuon)
select * from vwslsachmuontrongtungthangnam2023
--8. tạo view cho biết Sách đc mượn 1 lần vào năm 2023.
create view vwtensachmuonmotlanvaonam2023
as
	select Sach.iMaSach, sTenSach, count(Sach.iMaSach) as [số lần mượn ]
	from ChiTietMuonSach join MuonSach on ChiTietMuonSach.iMaMuonSach = MuonSach.iMaMuonSach
				join Sach on ChiTietMuonSach.iMaSach = Sach.iMaSach
	where year(dNgayMuon) = 2023
	group by Sach.iMaSach, sTenSach
	having count(MuonSach.iMaMuonSach) = 1
select * from vwtensachmuonmotlanvaonam2023
--9. tạo view Tính tổng số tiền phạt của từng độc giả
create view vwtongtienphatcuatungnguoi AS
select  DocGia.iMaDocGia, DocGia.sTenDocGia, sum(PhieuPhat.fSoTienPhat) as [ TongSoTienPhat ]
from  DocGia, MuonSach, TraSach, PhieuPhat
where DocGia.iMaDocGia = MuonSach.iMaDocGia 
	and MuonSach.iMaMuonSach = TraSach.iMaMuonSach 
	and TraSach.iMaTraSach = PhieuPhat.iMaTraSach
group by 
    DocGia.iMaDocGia,
    DocGia.sTenDocGia;

select * from vwtongtienphatcuatungnguoi

select * from DocGia
select * from MuonSach
select * from TraSach
select * from PhieuPhat

--10.Tạo view cho biết tên và số lượng mượn của từng loại duoc cho muon trong năm 2023
create view vwtsoluong2023
as
select sTenSach, sum(ChiTietMuonSach.iSoLuong)as SoLuongMuon
from Sach  join  ChiTietMuonSach on Sach.iMaSach = ChiTietMuonSach.iMaSach 
join MuonSach on ChiTietMuonSach.iMaMuonSach = MuonSach.iMaMuonSach
where (year(dNgayMuon) = 2023)
group by Sach.sTenSach
drop view vwtsoluong2023
select * from vwtsoluong2023
--11. Tạo view top 3 cuốn sách được mượn nhiều nhất trong tháng này
create view vw3sach
as
select  top 3 sTenSach, sum(ChiTietMuonSach.iSoLuong)as SoLuongMuon
from Sach  join  ChiTietMuonSach on Sach.iMaSach = ChiTietMuonSach.iMaSach 
join MuonSach on ChiTietMuonSach.iMaMuonSach = MuonSach.iMaMuonSach
where (month(dNgayMuon) = month(getdate()) and year(dNgayMuon) = year(getdate()))
group by Sach.sTenSach
order by SoLuongMuon desc
use quanlythuvien;
-- 1.cho biết thông tin sách có sl trên 25 sách
select * from Sach where Sach.iSoLuong>25
-- 2.lấy thông tin độc giả có giới tính nam
select * from DocGia where DocGia.sGioiTinh=N'nam'
-- 3.lấy ra những mã sách có điểm đánh giá > 4
select iMaSach , fDiemDanhGia from DanhGia where fDiemDanhGia > 4 
-- 4.lấy ra thông tin tác giả có quốc tịch VN
select * from TacGia where TacGia.sQuocTich=N'VietNam'
-- 5.lấy ra thông tin nhân viên có hsl >2
select * from NhanVien where NhanVien.fHeSoLuong >2

-- 6.cho biết mã đọc giả , mã sách mượn và số lượng sách mượn
select iMaDocGia,iMaSach,iSoLuong from MuonSach join ChiTietMuonSach on MuonSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
-- 7.cho biết iMaDocGia = 1000 mượn tổng bn sách
select sum(iSoLuong) as tongslsachmuon
from MuonSach join ChiTietMuonSach on MuonSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
where iMaDocGia = 1000
-- 8.cho biết tt sách có điểm đánh giá > 4
select Sach.iMaSach,Sach.sTenSach , fDiemDanhGia
from DanhGia join Sach on DanhGia.iMaSach=Sach.iMaSach
where fDiemDanhGia >4
-- 9.cho biết nhân viên  cho mượn được ít sách nhất
select top 1 NhanVien.iMaNV , sTenNV , sum(iSoLuong) as slsachchomuon
from NhanVien join MuonSach on NhanVien.iMaNV=MuonSach.iMaNV
				join ChiTietMuonSach on MuonSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
group by NhanVien.iMaNV , sTenNV
order by slsachchomuon asc
-- 10.cho biết lượng đầu sách do  nxb Kim Đồng xb 
select sum(iSoLuong) as sldausach from Sach join NhaXuatBan on Sach.iMaNXB=NhaXuatBan.iMaNXB
where NhaXuatBan.sTenNXB=N'NXB Kim Đồng';

--11. Cho biết Số lượng sách được mượn trong từng tháng năm 2023
select month(MuonSach.dNgayMuon) as [tháng (năm 2023)], 
	   sum(ChiTietMuonSach.iSoLuong) as [số lượng được sách mượn]
from ChiTietMuonSach inner join Sach on ChiTietMuonSach.iMaSach = Sach.iMaSach
					 inner join MuonSach on ChiTietMuonSach.iMaMuonSach = MuonSach.iMaMuonSach
where year(MuonSach.dNgayMuon) = 2023
group by month(MuonSach.dNgayMuon)
--12. Cho biết số lượng sách đã đc mượn của từng nhà xuất bản từ tháng 6 năm 2023 đến nay
select * from MuonSach;
select * from ChiTietMuonSach;
select * from Sach;
select * from NhaXuatBan;
-- số lượng từng loại sách được mượn từ tháng 5 năm 2023
create view soluong_sach_muon_5_2023
as
select Sach.iMaSach, Sach.sTenSach, sum(ChiTietMuonSach.iSoLuong) as [sl sách đc mượn]
from ChiTietMuonSach inner join Sach on ChiTietMuonSach.iMaSach = Sach.iMaSach
					 inner join MuonSach on ChiTietMuonSach.iMaMuonSach = MuonSach.iMaMuonSach
where year(MuonSach.dNgayMuon) >= 2023 and month(MuonSach.dNgayMuon) >= 5
group by Sach.iMaSach, Sach.sTenSach

--sl sách được mượn của từng nhà xuất bản
select NhaXuatBan.sTenNXB, sum(soluong_sach_muon_5_2023.[sl sách đc mượn])
from Sach inner join NhaXuatBan on Sach.iMaNXB = NhaXuatBan.iMaNXB
		  inner join soluong_sach_muon_5_2023 on Sach.iMaSach = soluong_sach_muon_5_2023.iMaSach
group by NhaXuatBan.sTenNXB
--13. Sách đc mượn 1 lần vào năm 2023
--14. Tính tổng số tiền phạt của từng độc giả



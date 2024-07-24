--procedure

-- 1 Cho biết thông tin nhân viên nào đó theo mã
create proc maNV 
@iMaNV int 
as
	select iMaNV , sTenNV
	from NhanVien 
	where iMaNV = @iMaNV

--
exec maNV 1000

--2	Cho biết tên nhà xuất bản theo mã sách
create proc TenNXB_MaSach 
@iMaSach int
as
	select iMaSach , sTenNXB
	from Sach join NhaXuatBan on Sach.iMaNXB=NhaXuatBan.iMaNXB
	where iMaSach=@iMaSach

-- 
exec TenNXB_MaSach 1000

--3 Cho biết tên nhân viên đã lập phiếu mượn theo mã mượn sách
create proc tenNV_Phieumuon 
@iMaMuonSach int
as
	select iMaMuonSach , sTenNV 
	from NhanVien join MuonSach on NhanVien.iMaNV=MuonSach.iMaNV
	where iMaMuonSach=@iMaMuonSach

--
exec tenNV_Phieumuon 10000

--4 Cho biết tên sách của một nhà xuất bản nào đó
create proc Sach_NXB 
@iMaNXB int 
as
	select sTenNXB , sTenSach
	from NhaXuatBan join Sach on NhaXuatBan.iMaNXB =Sach.iMaNXB
	where NhaXuatBan.iMaNXB =@iMaNXB

--
exec Sach_NXB 1000

--5  Cho biết độc giả đã mượn một cuốn sách nào đó
create proc DocGia_Sach
@iMaSach int
as
	select Sach.iMaSach , sTenDocGia
	from DocGia join MuonSach on DocGia.iMaDocGia=MuonSach.iMaDocGia
				join ChiTietMuonSach on MuonSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
				join Sach on Sach.iMaSach = ChiTietMuonSach.iMaSach
	where ChiTietMuonSach.iMaSach = @iMaSach

--
exec DocGia_Sach 1000

--6 Cho biết thể loại sách theo một mã sách nào đó
create proc MaSach_LoaiSach
@iMaSach int
as
	select iMaSach , sTheLoaiSach
	from Sach
	where iMaSach = @iMaSach

--
exec MaSach_LoaiSach 1000

--7 Cho biết tình trạng sách theo một mã sách nào đó trong trả sách
create proc TinhTrang_Sach
@iMaSach int
as
	select iMaSach , sTinhTrang
	from ChiTietMuonSach join TraSach on ChiTietMuonSach.iMaMuonSach=TraSach.iMaMuonSach
	where iMaSach=@iMaSach

--
exec TinhTrang_Sach 1005

--8 Cho biết những cuốn sách được xuất bản trong một năm nào đó 
create proc NamXB_Sach
@dNgayXuatBan date
as
	select iMaSach , sTenSach , dNgayXuatBan
	from Sach
	where year(dNgayXuatBan) = year(@dNgayXuatBan)

--
exec NamXB_Sach '1990-01-01'

--9  Cho biết những độc giả mượn sách trong một tháng nào đó
create proc DocGia_MuonSach 
@dNgayMuon int
as
	select sTenDocGia , sTenSach , dNgayMuon
	from DocGia join MuonSach on DocGia.iMaDocGia=MuonSach.iMaDocGia
				join ChiTietMuonSach on MuonSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
				join Sach on ChiTietMuonSach.iMaSach=Sach.iMaSach
	where month(dNgayMuon)= @dNgayMuon

--
exec DocGia_MuonSach 1

--10 Cho biết tác giả đã viết một cuốn sách nào đó theo mã sách
create proc TacGia_Sach
@iMaSach int
as
	select iMaSach , sTenTacGia
	from Sach join TacGia on Sach.iMaTacGia=TacGia.iMaTacGia
	where Sach.iMaSach=@iMaSach

--
exec TacGia_Sach 1009

--11 Cho biết số sách của một nhà xuất bản nào đó đã cung cấp
create proc NXB_SLSach
@iMaNXB int 
as
	select iMaNXB , sum(iSoLuong) as slSach
	from Sach
	where iMaNXB = @iMaNXB
	group by iMaNXB

--
exec NXB_SLSach 1008

--12 Cho biết ngày trả sách dự kiến của một độc giả nào đó
create proc NgayTra_DocGia 
@iMaDocGia int
as
	select MuonSach.iMaDocGia, sTenDocGia , dNgayTra
	from MuonSach join DocGia on MuonSach.iMaDocGia=DocGia.iMaDocGia
	where MuonSach.iMaDocGia =@iMaDocGia

--
exec NgayTra_DocGia 1000

--13 Cho biết tên sách đã được trả trong 1 tháng nào đó
create proc Sach_TraSach
@dNgayTra int
as
	select sTenSach , dNgayTra
	from TraSach join ChiTietMuonSach on TraSach.iMaMuonSach=ChiTietMuonSach.iMaMuonSach
					join Sach on ChiTietMuonSach.iMaSach=Sach.iMaSach
	where month(dNgayTra) =@dNgayTra

-- 
exec Sach_TraSach 4

--14 cho biết tổng số tiền phạt theo mã phiếu phạt nào đó
create proc TienPhat
@iMaPhieuPhat int
as
	select iMaPhieuPhat , sum(fSoTienPhat) as SoTienPhat
	from PhieuPhat
	where iMaPhieuPhat=@iMaPhieuPhat
	group by iMaPhieuPhat

--
exec TienPhat 30000


-- 15 đếm số nhân viên(output)
create proc demNV
@soNV int output
as 
	set @soNV = 0
	select count(iMaNV)from NhanVien 

--
declare @a int
exec demNV  @a

--16 viết thủ tục lấy ra lương cao nhấ của nhân viên
create proc luongcaonhat
@maxluong int output
as
	select @maxluong = max(fLuongCoBan) from NhanVien

--
declare @max int =0
exec luongcaonhat @max output
select @max as luongcaonhat


--17 đếm số lượng sách được trả theo tháng với số lượng là tham số trả về
create proc sltheothang
@sl int output,
@thang int
as
	select @sl = sum(iSoLuong)
	from ChiTietMuonSach join TraSach on ChiTietMuonSach.iMaMuonSach = TraSach.iMaMuonSach
	where month(TraSach.dNgayTra) = @thang
	
--
declare @so int
exec sltheothang @thang = 1 , @sl = @so output
select @so as slsach

--18 cho biết thông tin sách của 1 nhà xuất bản trong 1 năm nào đó
create proc ttsach_nxb_nam
@iMaSach int output,
@sTenSach nvarchar(20) output,
@iMaNXB int,
@dNgayXuatBan date
as
	select @iMaSach = iMaSach , @sTenSach = sTenSach from Sach 
	where @iMaNXB = iMaNXB and YEAR(dNgayXuatBan) = YEAR(@dNgayXuatBan)

--
declare @a int  , @b nvarchar(20)
exec ttsach_nxb_nam @iMaNXB = 1000 ,
					@dNgayXuatBan = '2008-11-01' ,
					@iMaSach =@a output ,
					@sTenSach =@b output
select @a as iMaSach , @b as sTenSach

--19 lấy ra thông tin sách theo mã sách
create proc ttsach
@iMaSach int,
@sTenSach nvarchar(200) output,
@iSoLuong int output,
@sTheLoaiSach nvarchar(35) output
as
	select @iMaSach=iMaSach ,  @sTenSach =sTenSach , @iSoLuong=iSoLuong , @sTheLoaiSach = sTheLoaiSach
	from Sach
	where @iMaSach = iMaSach

--
declare @a nvarchar(200) , @b int , @c nvarchar(35)
exec ttsach 1000 , @sTenSach =@a output,
				   @iSoLuong =@b output,
				   @sTheLoaiSach=@c output
select @a as tensach , @b as slsach , @c as theloaisach

-- 20 thủ tục kiểm tra xem sách có tồn tại không  (return)
create proc checksach
@iMaSach int 
as
	if exists (select 1 from Sach where iMaSach=@iMaSach)
		begin 
			return 0
		end
	else 
		begin 
			return 1
		end

--
declare @a int
exec  @a = checksach 1000
select @a as return_status

--21 thêm sách
create proc themsach
@iMaSach int,
@sTenSach nvarchar(200),
@iMaNXB int ,
@iMaTacGia int,
@dNgayXuatBan date,
@iSoLuong int,
@sMoTa nvarchar(225),
@sTheLoaiSach nvarchar(30)
as
	if exists (select 1 from Sach where @iMaSach =iMaSach)
		begin 
			print N'đã tồn tại mã sách này'
			return
		end
	else 
		begin
			insert into Sach(iMaSach,sTenSach,iMaNXB,iMaTacGia,dNgayXuatBan,iSoLuong,sMoTa,sTheLoaiSach)
			values (@iMaSach ,@sTenSach,@iMaNXB ,@iMaTacGia ,@dNgayXuatBan ,@iSoLuong ,@sMoTa ,@sTheLoaiSach)

			print 'success!!'
		end
-- 
exec themsach 1009 , N'Lão Hạc',1009,1009,'1943-01-01',55,N'Truyện ngắn về cuộc đời của Lão Hạc',N'Truyện Ngắn '





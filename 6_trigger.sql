use quanlythuvien;
--1.khi 1 phiếu mượn sách được tạo thì sẽ tự động giảm số lượng sách trong kho,
--nếu không đủ số lượng mượn sẽ hiện thông báo lỗi.
create trigger trg_SL_sach_muon
on ChiTietMuonSach
after insert
as
begin
	declare @soluongsachmuon int, @soluongsach int, @masach int
	select @soluongsach = sach.iSoLuong, @soluongsachmuon = inserted.iSoLuong, 
	@masach = inserted.iMaSach
	from Sach inner join inserted on Sach.iMaSach = inserted.iMaSach

	if @soluongsachmuon > @soluongsach
	begin
		print N'số lượng sách trong thư viện không đủ.'
		rollback tran
	end
	else
	begin
		update Sach
		set iSoLuong = iSoLuong - @soluongsachmuon
		where iMaSach = @masach
	end
end

insert into ChiTietMuonSach(iMaMuonSach, iMaSach, iSoLuong) values (10003, 1002, 554);

--2. khi trả sách sẽ tự động cập nhật số lượng sách
-- 1 lần mượn sách sẽ mượn nhiều sách và khi trả sẽ cập nhật tất cả sách đã mượn
create trigger trg_SL_sachtra
on TraSach
after insert
as
begin
	declare @masach int, @soluongsachmuon int
	declare ChiTietMuonSachCursor cursor for 
	select ChiTietMuonSach.iMaSach, ChiTietMuonSach.iSoLuong
	from ChiTietMuonSach inner join inserted on ChiTietMuonSach.iMaMuonSach =  inserted.iMaMuonSach

	open ChiTietMuonSachCursor
	fetch next from ChiTietMuonSachCursor into @masach, @soluongsachmuon

	while @@FETCH_STATUS = 0
	begin
		update Sach
		set iSoLuong = iSoLuong + @soluongsachmuon
		where iMaSach = @masach

		fetch next from ChiTietMuonSachCursor into @masach, @soluongsachmuon
	end
	close ChiTietMuonSachCursor
	deallocate ChiTietMuonSachCursor
end

insert into TraSach(iMaMuonSach, iMaNV, dNgayTra, sTinhTrang) values (10000, 1001, '2025-7-10', N'Tốt');

--3. Khi 1 bản ghi sách được thêm, xóa thì số lượng sách của từng nhà xuất bản sẽ cập nhật theo
--thêm cột số lượng sách cho bảng nhà xuất bản
alter table NhaXuatBan
add iSoLuongSach int;

create trigger trg_sl_NXB
on Sach
after insert, delete
as
begin
	update NhaXuatBan
	set iSoLuongSach = (select count(1) from Sach where Sach.iMaNXB = NhaXuatBan.iMaNXB)
	where NhaXuatBan.iMaNXB = (select top 1 inserted.iMaNXB from inserted)
	or NhaXuatBan.iMaNXB = (select top 1 deleted.iMaNXB from deleted)
end
insert into Sach(sTenSach, iMaNXB, iMaTacGia, iSoLuong) values ('cnnt', 1000, 1000, 3);
delete Sach where iMaSach = 1010;

--4. Tự động tạo phiếu phạt khi quá hạn trả sách
create trigger trg_phieuphat
on TraSach
after insert, update
as
begin
	declare @ngayTraDuKien date, @ngayTraThucTe date, @maTraSach int, @tienPhat float
	select @ngayTraDuKien = MuonSach.dNgayTra, @ngayTraThucTe = inserted.dNgayTra, @maTraSach = inserted.iMaTraSach
	from MuonSach inner join inserted on MuonSach.iMaMuonSach = inserted.iMaMuonSach

	if DATEDIFF(day, @ngayTraDuKien, @ngayTraThucTe) > 0
	begin
		set @tienPhat = datediff(day, @ngayTraDuKien, @ngayTraThucTe) * 10000
		insert into PhieuPhat(iMaTraSach, fSoTienPhat, sLyDo, dNgayPhat) 
		values(@maTraSach, @tienPhat, N'Quá hạn trả sách', getdate());  
	end
	else
	begin
		return
	end
end
insert into MuonSach(iMaDocGia, iMaNV, dNgayMuon, dNgayTra) values(1000, 1000, '2024-7-5', '2024-7-9');
insert into TraSach(iMaMuonSach, iMaNV, dNgayTra, sTinhTrang) values(10010, 1000, '2024-7-11', N'tốt');
select * from MuonSach;
select * from Sach;
select * from ChiTietMuonSach;
select * from TraSach;
select * from NhaXuatBan;
select * from PhieuPhat
order by iMaPhieuPhat desc ;

select * from TacGia;
select * from DocGia;
select * from NhanVien;
select * from DanhGia;
--5. Khi thay đổi hệ số lương hoặc lương cơ bản của nhân viên, tự động tính lại tổng số lương
--thêm cột tổng số lương cho bảng NhanVien
alter table NhanVien
add fTongSoLuong float;
update NhanVien
set fTongSoLuong = fLuongCoBan * fHeSoLuong;

create trigger trg_capnhatluong
on NhanVien
after update
as
begin
	if update(fLuongCoBan) or update(fHeSoLuong)
	begin
		update NhanVien
		set fTongSoLuong = fLuongCoBan * fHeSoLuong
		where NhanVien.iMaNV = (select top 1 iMaNV from inserted)
	end
end
update NhanVien
set fHeSoLuong = 5
where imanv = 1000

--6. khi 1 độc giả bị xóa thì các dữ liệu mượn sách, trả sách,đánh giá,... của độc giả này cũng sẽ bị xóa theo
create trigger trg_xoa_docgia on DocGia
instead of delete
as
begin
	declare @madocgia int, @mamuonsach int, @matrasach int, @maphietphat int, @madanhgia int;
	select top 1 @madocgia = iMaDocGia from deleted;
	select @mamuonsach = iMaMuonSach from MuonSach where iMaDocGia = @madocgia;
	select @matrasach = iMaTraSach from TraSach where iMaMuonSach = @mamuonsach;
	select @maphietphat = iMaPhieuPhat from PhieuPhat where iMaTraSach = @matrasach;

	delete DanhGia where iMaDocGia = @madocgia;
	delete PhieuPhat where iMaPhieuPhat = @maphietphat;
	delete TraSach where iMaTraSach = @matrasach;
	delete ChiTietMuonSach where iMaMuonSach = @mamuonsach;
	delete MuonSach where iMaMuonSach = @mamuonsach;
	delete DocGia where iMaDocGia = @madocgia;
end

delete DocGia where iMaDocGia = 1002;

--7. Xoá dữ liệu mượn sách . Xoá toàn bộ thông tin liên quan từ Chi Tiết , Trả Sách , Phiếu Phạt
Create trigger trgXoadlMuonSach
on MuonSach 
instead of delete
as
begin
Declare @iMaMuonSach int = (select top 1 iMaMuonSach from inserted)
declare @imaTrasach int
if exists (select * from TraSach where iMaMuonSach = @iMaMuonSach)
begin
select @imaTrasach =(select iMaTraSach from TraSach where iMaMuonSach = @iMaMuonSach)
delete PhieuPhat 
where iMaTraSach =@imaTrasach
delete ChiTietMuonSach
where iMaMuonSach= @iMaMuonSach
delete TraSach 
where iMaMuonSach = @iMaMuonSach
delete MuonSach
where iMaMuonSach= @iMaMuonSach
end
else 
delete MuonSach
where iMaMuonSach= @iMaMuonSach
end
drop trigger trgXoadlMuonSach
delete MuonSach
where iMaMuonSach = 10010
  
 -- 8. Nếu insert bảng sách mà bị trùng mà sách thì sẽ tăng số lượng sách đó .
create trigger trgThemSach
on Sach
after insert 
as
  begin 
	declare @imaNXb int , @sTenSach nvarchar(200) , @SoLuong int 
	select @imaNXb = (select top 1 iMaNXB from inserted  ) ,
			@sTenSach = (select top 1 sTenSach from inserted),
			@SoLuong =(select top 1 iSoLuong from inserted)
	if exists (select * from Sach where sTenSach =@sTenSach and iMaNXB = @imaNXb)
	begin
		update Sach
		set iSoLuong = iSoLuong + @SoLuong 
		where sTenSach =@sTenSach and iMaNXB = @imaNXb
		print N'Đã Tăng Số Lượng Sách '
	end
	else 
		insert into Sach (sTenSach ,iMaNXB ,iMaTacGia ,dNgayXuatBan,iSoLuong,sMoTa,sTheLoaiSach)
		select sTenSach ,iMaNXB ,iMaTacGia ,dNgayXuatBan,iSoLuong,sMoTa,sTheLoaiSach from inserted
 end

drop trigger trgThemSach
insert into Sach
values(N'Cho tôi xin một vé đi tuổi thơ', 1000, 1000, '2008-11-01', 1, N'Sách thiếu nhi về tuổi thơ', N'Thiếu Nhi')
select * from sach 


--9- Ngày trả sách phải lớn hơn hoặc bằng ngày mượn
create trigger check_ngay
on TraSach
after insert 
as
begin
	declare @dNgayTra date
	declare @dNgayMuon date
	select @dNgayTra = dNgaytra from inserted
	select @dNgayMuon = dNgayTra from MuonSach
	if @dNgayTra<@dNgayMuon
		raiserror('ngay tra phai lon hon ngay muon',16,1)
		rollback tran

end

select * from MuonSach
select * from TraSach
insert into TraSach
values (10011,1001,'2024-07-01','tot')


--10 Tự động tính số ngày trả sách muộn của sinh viên 
-- thêm cột số ngày muộn vào bảng trasach
alter table TraSach add songaymuon int

create trigger updatengaymuon
on TraSach
after insert , update
as
begin
	declare @songaymuon int
	declare @dNgayTra date
	declare @dNgayMuon date 

	SELECT TOP 1 @dNgayMuon = dNgayTra
    FROM MuonSach
    WHERE iMaMuonSach = (SELECT TOP 1 iMaMuonSach FROM inserted);

	
	select @dNgayTra = dNgayTra from inserted
	set @songaymuon = DATEDIFF(DAY, @dNgayMuon, @dNgayTra);
	if(@dNgayTra>@dNgayMuon)
		update TraSach
		set songaymuon = @songaymuon
		where iMaTraSach=(select iMaTraSach from inserted)
		
end

drop trigger updatengaymuon
select * from MuonSach
select * from TraSach

update TraSach
set dNgayTra = '2023-01-15'
where iMaTraSach = 20000


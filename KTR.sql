use quanlythuvien;
--clo1
create table KhoaKhamBenh(
	iMakhoa int primary key,
	sTenkhoa nvarchar(30),
	sSdt nvarchar(20)
);

create table BenhNhan(
	iMabenhnhan int primary key,
	sTenbenhnhan nvarchar(30),
	sGioitinh nvarchar(10) check (sgioitinh in ('nam', N'nữ')),
	iNgaysinh date,
	iMakhoa int references KhoaKhamBenh(imakhoa)
);
insert into KhoaKhamBenh(iMakhoa, sTenkhoa, sSdt) values(100, N'khoa khám 1', '080073232');
insert into KhoaKhamBenh(iMakhoa, sTenkhoa, sSdt) values(101, N'khoa khám 2', '2387233232');
insert into KhoaKhamBenh(iMakhoa, sTenkhoa, sSdt) values(102, N'khoa khám 3', '08373232');
insert into KhoaKhamBenh(iMakhoa, sTenkhoa, sSdt) values(103, N'khoa khám 4', '0832673232');
insert into KhoaKhamBenh(iMakhoa, sTenkhoa, sSdt) values(104, N'khoa khám 5', '0992673232');

insert into BenhNhan(iMabenhnhan, iMakhoa, sTenbenhnhan, sGioitinh, iNgaysinh) values
(100, 100, N'nguyễn văn a', 'nam', '2024-7-22'),
(101, 100, N'nguyễn văn b', 'nam', '2024-7-2'),
(102, 101, N'nguyễn văn c', 'nam', '2024-8-22'),
(103, 101, N'nguyễn vănc a', N'nữ', '2024-8-22'),
(104, 101, N'nguyễn thi a', N'nữ', '2024-7-11'),
(105, 102, N'nguyễn y a', 'nam', '2024-2-22'),
(106, 103, N'pham a', 'nam', '2024-2-2'),
(107, 104, N'nguyễn văn ew', N'nữ', '2024-9-2')

--clo2
--view hiện các bệnh nhân có mã khoa được sắp xếp giảm dần
create view sx_benhnhan
as
select top 10 iMabenhnhan, iMakhoa, sTenbenhnhan 
from BenhNhan
order by imakhoa desc

select * from sx_benhnhan

--tạo login và cấp quyền
create login khang23a with password = '123';
use quanlythuvien;
create user khang for login khang23a;

grant insert, select on benhnhan to khang
--Thủ tục cho biết khoa với tên cụ thể có bao nhiêu bệnh nhân sinh trong năm cụ thể 
--với tên khoa, năm là tham số truyền vào
create proc benhnhan_nam_khoa
@tenkhoa nvarchar(20), @nam int
as
begin
	select KhoaKhamBenh.iMakhoa, KhoaKhamBenh.sTenkhoa, count(BenhNhan.iMabenhnhan) as [số bệnh nhân]
	from BenhNhan inner join KhoaKhamBenh on BenhNhan.iMakhoa = KhoaKhamBenh.iMakhoa
	where KhoaKhamBenh.sTenkhoa = @tenkhoa and year(BenhNhan.iNgaysinh) = @nam
	group by KhoaKhamBenh.sTenkhoa, KhoaKhamBenh.iMakhoa
end

exec benhnhan_nam_khoa N'khoa khám 1', 2024
exec benhnhan_nam_khoa N'khoa khám 2', 2024

--clo3, clo4 phân tách dọc bảng bệnh nhân
create table quanlythuvien1.dbo.BenhNhan1(
	iMabenhnhan int primary key,
	sTenbenhnhan nvarchar(30),
);
insert into quanlythuvien1.dbo.BenhNhan1(iMabenhnhan, sTenbenhnhan) values (1007, N'phạm văn khang')
insert into linkmayao.quanlythuvien2.dbo.BenhNhan2(iMabenhnhan, sGioitinh, ingaysinh, imakhoa) 
values (1007, 'nam', '2005-02-18', 100)
--tạo view lấy từ 2 máy
create view benhnhan_2may
as
select b1.iMabenhnhan, b1.sTenbenhnhan, b2.sGioitinh, b2.ingaysinh, b2.imakhoa
from quanlythuvien1.dbo.BenhNhan1 b1 inner join linkmayao.quanlythuvien2.dbo.BenhNhan2 b2
on b1.iMabenhnhan = b2.iMabenhnhan

select * from benhnhan_2may;
select * from quanlythuvien.dbo.BenhNhan;
select * from quanlythuvien1.dbo.BenhNhan1;
select * from linkmayao.quanlythuvien2.dbo.BenhNhan2;
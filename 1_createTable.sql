create database quanlythuvien
ON
(NAME ='quanlythuvien',
FILENAME = 'D:\SQL SERVER\BTL_quanlythuvien\quanlythuvien.mdf',
SIZE = 5MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 10%);

use quanlythuvien;
create table DocGia (
    iMaDocGia int identity(1000, 1) primary key,
    sTenDocGia nvarchar(200) not null,
    dNgaySinh date,
    sDiaChi nvarchar(200),
    sDienThoai nvarchar(15)
);

create table NhanVien (
    iMaNV int identity(1000, 1) primary key,
    sTenNV nvarchar(200) not null,
    sDiaChi nvarchar(200),
    fLuongCoBan float not null,
    fHeSoLuong float not null
);

create table NhaXuatBan (
    iMaNXB int identity(1000, 1) primary key,
    sTenNXB nvarchar(200) not null,
    sDiaChi nvarchar(200),
    sEmail nvarchar(200)
);

create table TacGia (
    iMaTacGia int identity(1000, 1) primary key,
    sTenTacGia nvarchar(200) not null,
    sQuocTich nvarchar(50),
    sMoTa nvarchar(200)
);

create table Sach (
    iMaSach int identity(1000, 1) primary key,
    sTenSach nvarchar(200) not null,
    iMaNXB int not null,
    iMaTacGia int not null,
    dNgayXuatBan date,
    iSoLuong int not null,
    sMoTa nvarchar(225),
    constraint FK_NhaXuatBan_Sach foreign key (iMaNXB) references NhaXuatBan(iMaNXB),
    constraint FK_TacGia_Sach foreign key (iMaTacGia) references TacGia(iMaTacGia)
);

create table DanhGia (
    iMaSach int not null,
    iMaDocGia int not null,
    fDiemDanhGia float not null,
    sBinhLuan nvarchar(200),
    dNgayDanhGia date not null,
    constraint FK_Sach_DanhGia foreign key (iMaSach) references Sach(iMaSach),
    constraint FK_DocGia_DanhGia foreign key (iMaDocGia) references DocGia(iMaDocGia),
    primary key (iMaSach, iMaDocGia)
);

create table MuonSach (
    iMaMuonSach int identity(10000, 1) primary key,
    iMaDocGia int not null,
    iMaNV int not null,
    dNgayMuon date not null,
    dNgayTra date,
    constraint FK_DocGia_MuonSach foreign key (iMaDocGia) references DocGia(iMaDocGia),
    constraint FK_NhanVien_MuonSach foreign key (iMaNV) references NhanVien(iMaNV)
);

create table ChiTietMuonSach (
    iMaMuonSach int not null,
    iMaSach int not null,
    iSoLuong int not null,
    primary key (iMaMuonSach, iMaSach),
    constraint FK_MuonSach_ChiTiet foreign key (iMaMuonSach) references MuonSach(iMaMuonSach),
    constraint FK_Sach_ChiTiet foreign key (iMaSach) references Sach(iMaSach)
);

create table TraSach (
    iMaTraSach int identity(20000, 1) primary key,
    iMaMuonSach int not null,
    iMaNV int not null,
    dNgayTra date not null,
    sTinhTrang nvarchar(200) not null,
    constraint FK_MuonSach_TraSach foreign key (iMaMuonSach) references MuonSach(iMaMuonSach),
    constraint FK_NhanVien_TraSach foreign key (iMaNV) references NhanVien(iMaNV)
);

create table PhieuPhat (
    iMaPhieuPhat int identity(30000, 1) primary key,
    iMaTraSach int not null,
    fSoTienPhat float not null,
    sLyDo nvarchar(200) not null,
    dNgayPhat date,
    constraint FK_TraSach_PhieuPhat foreign key (iMaTraSach) references TraSach(iMaTraSach)
);

alter table Sach
add sTheLoaiSach nvarchar(30);

alter table Sach
add constraint CK_Sach_SoLuong check (iSoLuong > 0);

alter table docgia
add sGioiTinh nvarchar(30) constraint CK_gioitinh check(sgioitinh in ('nam', N'nữ'));

alter table NhanVien
add constraint CK_NhanVien_LuongCoBan check (fLuongCoBan > 0),
    constraint CK_NhanVien_HeSoLuong check (fHeSoLuong > 0);

alter table DanhGia
add constraint CK_DanhGia_Diem check (fDiemDanhGia >= 0 and fDiemDanhGia <= 5);

alter table MuonSach
add constraint CK_MuonSach_NgayTra check (dNgayTra is null or dNgayTra > dNgayMuon);

alter table ChiTietMuonSach
add constraint CK_ChiTietMuonSach_SoLuong check (iSoLuong > 0);

alter table PhieuPhat
add constraint CK_PhieuPhat_SoTienPhat check (fSoTienPhat > 0);

alter table DocGia
add constraint UQ_SDT unique(sDienthoai);
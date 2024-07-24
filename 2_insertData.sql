use quanlythuvien;

-- Insert data into NhaXuatBan
insert into NhaXuatBan (sTenNXB, sDiaChi, sEmail)
values
(N'NXB Kim Đồng', N'123 Kim Mã, Hà Nội', N'kimdong@nxb.vn'),
(N'NXB Giáo Dục', N'456 Lê Duẩn, Hà Nội', N'giaoduc@nxb.vn'),
(N'NXB Trẻ', N'789 Nguyễn Trãi, Hà Nội', N'tre@nxb.vn'),
(N'NXB Văn Học', N'1010 Hoàng Hoa Thám, Hà Nội', N'vanhoc@nxb.vn'),
(N'NXB Đại Học Quốc Gia', N'1111 Láng Hạ, Hà Nội', N'dhqg@nxb.vn'),
(N'NXB Lao Động', N'1212 Cầu Giấy, Hà Nội', N'laodong@nxb.vn'),
(N'NXB Thanh Niên', N'1313 Giải Phóng, Hà Nội', N'thanhnien@nxb.vn'),
(N'NXB Công An Nhân Dân', N'1414 Phạm Hùng, Hà Nội', N'congan@nxb.vn'),
(N'NXB Quân Đội Nhân Dân', N'1515 Trần Duy Hưng, Hà Nội', N'quandoi@nxb.vn'),
(N'NXB Thế Giới', N'1616 Hoàng Quốc Việt, Hà Nội', N'thegioi@nxb.vn');

-- Insert data into TacGia
insert into TacGia (sTenTacGia, sQuocTich, sMoTa)
values
(N'Nguyễn Nhật Ánh', N'Vietnam', N'Tác giả của nhiều sách thiếu nhi nổi tiếng'),
(N'Tô Hoài', N'Vietnam', N'Nhà văn với nhiều tác phẩm cho thiếu nhi'),
(N'Kim Đồng', N'Vietnam', N'Nhà văn nổi tiếng với tác phẩm "Đất rừng phương Nam"'),
(N'Nguyễn Du', N'Vietnam', N'Tác giả của "Truyện Kiều"'),
(N'Trần Đăng Khoa', N'Vietnam', N'Nhà thơ nổi tiếng với tác phẩm "Góc sân và khoảng trời"'),
(N'Lê Minh Khuê', N'Vietnam', N'Nhà văn với nhiều tác phẩm về chiến tranh'),
(N'Bảo Ninh', N'Vietnam', N'Tác giả của "Nỗi buồn chiến tranh"'),
(N'Ngô Tất Tố', N'Vietnam', N'Tác giả của "Tắt đèn"'),
(N'Vũ Trọng Phụng', N'Vietnam', N'Tác giả của "Số đỏ"'),
(N'Nam Cao', N'Vietnam', N'Tác giả của "Lão Hạc"');

-- Insert data into DocGia
insert into DocGia (sTenDocGia, dNgaySinh, sDiaChi, sDienThoai, sGioiTinh)
values
(N'Nguyễn Văn A', '1990-01-01', N'123 Trần Duy Hưng, Hà Nội', N'0909123456', 'nam'),
(N'Trần Thị B', '1991-02-02', N'456 Hoàng Quốc Việt, Hà Nội', N'0909123457', N'nữ'),
(N'Lê Văn C', '1992-03-03', N'789 Nguyễn Trãi, Hà Nội', N'0909123458', 'nam'),
(N'Phạm Thị D', '1993-04-04', N'1010 Cầu Giấy, Hà Nội', N'0909123459',  N'nữ'),
(N'Hoàng Văn E', '1994-05-05', N'1111 Kim Mã, Hà Nội', N'0909123460', 'nam'),
(N'Vũ Thị F', '1995-06-06', N'1212 Phạm Hùng, Hà Nội', N'0909123461',  N'nữ'),
(N'Đặng Văn G', '1996-07-07', N'1313 Láng Hạ, Hà Nội', N'0909123462', 'nam'),
(N'Ngô Thị H', '1997-08-08', N'1414 Giải Phóng, Hà Nội', N'0909123463',  N'nữ'),
(N'Doãn Văn I', '1998-09-09', N'1515 Đê La Thành, Hà Nội', N'0909123464', 'nam'),
(N'Đỗ Thị K', '1999-10-10', N'1616 Chùa Bộc, Hà Nội', N'0909123465',  N'nữ');

-- Insert data into Sach
insert into Sach (sTenSach, iMaNXB, iMaTacGia, dNgayXuatBan, iSoLuong, sMoTa, sTheLoaiSach)
values
(N'Cho tôi xin một vé đi tuổi thơ', 1000, 1000, '2008-11-01', 50, N'Sách thiếu nhi về tuổi thơ', N'Thiếu Nhi'),
(N'Dế Mèn phiêu lưu ký', 1001, 1001, '1941-01-01', 30, N'Cuộc phiêu lưu của Dế Mèn', N'Thiếu Nhi'),
(N'Đất rừng phương Nam', 1002, 1002, '1957-01-01', 40, N'Tác phẩm nổi tiếng về miền Nam', N'Truyện'),
(N'Truyện Kiều', 1003, 1003, '1820-01-01', 20, N'Tác phẩm văn học kinh điển', N'Truyện'),
(N'Góc sân và khoảng trời', 1004, 1004, '1973-01-01', 60, N'Tác phẩm thơ về tuổi thơ', N'Thơ'),
(N'Những ngôi sao xa xôi', 1005, 1005, '1981-01-01', 15, N'Truyện ngắn về chiến tranh', N'Truyện Ngắn'),
(N'Nỗi buồn chiến tranh', 1006, 1006, '1990-01-01', 25, N'Tác phẩm về hậu quả chiến tranh', N'Truyện'),
(N'Tắt đèn', 1007, 1007, '1939-01-01', 35, N'Tác phẩm về nông dân nghèo', N'Truyện'),
(N'Số đỏ', 1008, 1008, '1936-01-01', 45, N'Tác phẩm châm biếm xã hội', N'Truyện'),
(N'Lão Hạc', 1009, 1009, '1943-01-01', 55, N'Truyện ngắn về cuộc đời của Lão Hạc', N'Truyện Ngắn');

-- Insert data into NhanVien
insert into NhanVien (sTenNV, sDiaChi, fLuongCoBan, fHeSoLuong)
values
(N'Nguyễn Văn M', N'1717 Trường Chinh, Hà Nội', 8000000, 1.5),
(N'Trần Thị N', N'1818 Giải Phóng, Hà Nội', 8500000, 1.6),
(N'Lê Văn O', N'1919 Hoàng Hoa Thám, Hà Nội', 9000000, 1.7),
(N'Phạm Thị P', N'2020 Nguyễn Trãi, Hà Nội', 9500000, 1.8),
(N'Hoàng Văn Q', N'2121 Kim Mã, Hà Nội', 10000000, 1.9),
(N'Vũ Thị R', N'2222 Láng Hạ, Hà Nội', 10500000, 2.0),
(N'Đặng Văn S', N'2323 Phạm Hùng, Hà Nội', 11000000, 2.1),
(N'Ngô Thị T', N'2424 Cầu Giấy, Hà Nội', 11500000, 2.2),
(N'Doãn Văn U', N'2525 Giải Phóng, Hà Nội', 12000000, 2.3),
(N'Đỗ Thị V', N'2626 Hoàng Quốc Việt, Hà Nội', 12500000, 2.4);

-- Insert data into DanhGia
insert into DanhGia (iMaSach, iMaDocGia, fDiemDanhGia, sBinhLuan, dNgayDanhGia)
values
(1000, 1000, 5.0, N'Tuyệt vời!', '2023-01-01'),
(1001, 1001, 4.5, N'Rất thú vị', '2023-02-01'),
(1002, 1002, 4.0, N'Hấp dẫn', '2023-03-01'),
(1003, 1003, 5.0, N'Không thể bỏ qua', '2023-04-01'),
(1004, 1004, 3.5, N'Khá hay', '2023-05-01'),
(1005, 1005, 4.0, N'Thú vị', '2023-06-01'),
(1006, 1006, 5.0, N'Tuyệt vời!', '2023-07-01'),
(1007, 1007, 4.5, N'Rất hay', '2023-08-01'),
(1008, 1008, 4.0, N'Không tồi', '2023-09-01'),
(1009, 1009, 5.0, N'Tác phẩm xuất sắc', '2023-10-01');

-- Insert data into MuonSach
insert into MuonSach (iMaDocGia, iMaNV, dNgayMuon, dNgayTra)
values
(1000, 1000, '2023-01-01', '2023-01-10'),
(1001, 1001, '2023-02-01', '2023-02-10'),
(1002, 1002, '2023-03-01', '2023-03-10'),
(1003, 1003, '2023-04-01', '2023-04-10'),
(1004, 1004, '2023-05-01', '2023-05-10'),
(1005, 1005, '2023-06-01', '2023-06-10'),
(1006, 1006, '2023-07-01', '2023-07-10'),
(1007, 1007, '2023-08-01', '2023-08-10'),
(1008, 1008, '2023-09-01', '2023-09-10'),
(1009, 1009, '2023-10-01', '2023-10-10');

-- Insert data into ChiTietMuonSach
insert into ChiTietMuonSach (iMaMuonSach, iMaSach, iSoLuong)
values
(10000, 1000, 1),
(10000, 1001, 2),
(10001, 1002, 1),
(10001, 1003, 2),
(10002, 1004, 1),
(10002, 1005, 2),
(10003, 1006, 1),
(10003, 1007, 2),
(10004, 1008, 1),
(10004, 1009, 2),
(10005, 1009, 1),
(10005, 1001, 2),
(10006, 1002, 1),
(10006, 1003, 2),
(10007, 1004, 1),
(10007, 1005, 2),
(10008, 1006, 1);

-- Insert data into TraSach
insert into TraSach (iMaMuonSach, iMaNV, dNgayTra, sTinhTrang)
values
(10000, 1000, '2023-01-10', N'Tốt'),
(10001, 1001, '2023-02-10', N'Tốt'),
(10002, 1002, '2023-03-10', N'Tốt'),
(10003, 1003, '2023-04-10', N'Tốt'),
(10004, 1004, '2023-05-10', N'Tốt'),
(10005, 1005, '2023-06-10', N'Tốt'),
(10006, 1006, '2023-07-10', N'Tốt'),
(10007, 1007, '2023-08-10', N'Tốt'),
(10008, 1008, '2023-09-10', N'Tốt'),
(10009, 1009, '2023-10-10', N'Tốt');

-- Insert data into PhieuPhat
insert into PhieuPhat (iMaTraSach, fSoTienPhat, sLyDo, dNgayPhat)
values
(20000, 50000, N'Quá hạn trả sách', '2023-01-11'),
(20001, 100000, N'Hư hỏng sách', '2023-02-11'),
(20002, 75000, N'Quá hạn trả sách', '2023-03-11'),
(20003, 50000, N'Quá hạn trả sách', '2023-04-11'),
(20004, 100000, N'Hư hỏng sách', '2023-05-11'),
(20005, 75000, N'Quá hạn trả sách', '2023-06-11'),
(20006, 50000, N'Quá hạn trả sách', '2023-07-11'),
(20007, 100000, N'Hư hỏng sách', '2023-08-11'),
(20008, 75000, N'Quá hạn trả sách', '2023-09-11'),
(20009, 50000, N'Quá hạn trả sách', '2023-10-11');
--fix dữ liệu 
use quanlythuvien;
update TraSach
set Stinhtrang = N'Hư hỏng sách'
from PhieuPhat
where PhieuPhat.iMaTraSach = TraSach.iMaTraSach and PhieuPhat.sLyDo = N'Hư hỏng sách';

update trasach
set dNgayTra = dateadd(day, 4, dNgayTra)
from PhieuPhat
where PhieuPhat.iMaTraSach = TraSach.iMaTraSach and PhieuPhat.sLyDo = N'Quá hạn trả sách';

update phieuphat
set dNgayPhat = dateadd(day, 4, dNgayPhat)
from trasach
where PhieuPhat.iMaTraSach = TraSach.iMaTraSach and PhieuPhat.sLyDo = N'Quá hạn trả sách';
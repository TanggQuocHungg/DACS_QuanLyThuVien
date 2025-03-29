CREATE DATABASE QLTV;
GO


USE QLTV;
GO

CREATE TABLE LOAITAIKHOAN (
    MaLoaiTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
    TenLoaiTaiKhoan NVARCHAR(50) NOT NULL,
    MoTa NVARCHAR(200)
);

CREATE TABLE TAIKHOAN (
    ID INT IDENTITY(1,1) PRIMARY KEY,
	TaiKhoan VARCHAR(100) NOT NULL,
    MatKhau VARCHAR(100) NOT NULL,
    MaLoaiTaiKhoan INT NOT NULL,
    CONSTRAINT FK_TAIKHOAN_LOAITAIKHOAN FOREIGN KEY (MaLoaiTaiKhoan) REFERENCES LOAITAIKHOAN(MaLoaiTaiKhoan)
);

CREATE TABLE LOAIDOCGIA (
    MaLoaiDocGia INT IDENTITY(1,1) PRIMARY KEY,
    TenLoaiDocGia NVARCHAR(100) NOT NULL
);

CREATE TABLE DOCGIA (
    MaDocGia INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(200) NOT NULL,
    NgaySinh DATE NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL,
    Email NVARCHAR(200) NOT NULL UNIQUE,
    NgayLapThe DATE NOT NULL,
    NgayHetHan DATE NOT NULL, 
    MaLoaiDocGia INT NOT NULL,
    ID INT NOT NULL UNIQUE,
    Sdt VARCHAR(20) NOT NULL,
    TongNo DECIMAL(18, 0) NOT NULL CHECK (TongNo >= 0),
    GioiThieu NVARCHAR(500),
    CONSTRAINT FK_DOCGIA_TAIKHOAN FOREIGN KEY (ID) REFERENCES TAIKHOAN(ID),
    CONSTRAINT FK_DOCGIA_LOAIDOCGIA FOREIGN KEY (MaLoaiDocGia) REFERENCES LOAIDOCGIA(MaLoaiDocGia)
);



CREATE TABLE ADMIN (
    IDAdmin INT IDENTITY(1,1) PRIMARY KEY,
	ID INT NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATETIME NOT NULL,
    DiaChi NVARCHAR(200),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Sdt VARCHAR(20) NOT NULL UNIQUE,
    CONSTRAINT FK_ADMIN_TAIKHOAN FOREIGN KEY (ID) REFERENCES TAIKHOAN(ID)
);

CREATE TABLE THUTHU (
    IDTT INT IDENTITY(1,1) PRIMARY KEY,
	ID INT NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATETIME NOT NULL,
    DiaChi NVARCHAR(200),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Sdt VARCHAR(20) NOT NULL UNIQUE,
    CONSTRAINT FK_THUTHU_TAIKHOAN FOREIGN KEY (ID) REFERENCES TAIKHOAN(ID)
);

CREATE TABLE KHOATAIKHOAN (
    IDKhoa INT IDENTITY(1,1) PRIMARY KEY,
    ID INT NOT NULL,
    LyDo NVARCHAR(255) NOT NULL,
    NgayKhoa DATE DEFAULT GETDATE(),
	CONSTRAINT FK_KHOATAIKHOAN_TAIKHOAN FOREIGN KEY (ID) REFERENCES TAIKHOAN(ID)
);

CREATE TABLE PHANQUYEN(
	IDPQ INT IDENTITY(1,1) PRIMARY KEY,
	TenPQ NVARCHAR(100) NOT NULL,
	Quyen VARCHAR(100) NOT NULL,
	MoTa NVARCHAR(200) NULL
);


CREATE TABLE CTPHANQUYEN(
	IDPQ INT,
	MaLoaiTaiKhoan INT,
	TrangThai BIT NOT NULL,
	CONSTRAINT FK_CTPHANQUYEN_PHANQUYEN FOREIGN KEY (IDPQ) REFERENCES PHANQUYEN(IDPQ),
	CONSTRAINT FK_CTPHANQUYEN_LOAITAIKHOAN FOREIGN KEY (MaLoaiTaiKhoan) REFERENCES LOAITAIKHOAN(MaLoaiTaiKhoan)
);


CREATE TABLE THELOAI (
    MaTheLoai INT IDENTITY(1,1) PRIMARY KEY,
    TenTheLoai NVARCHAR(100) NOT NULL
);

CREATE TABLE TACGIA (
    MaTacGia INT IDENTITY(1,1) PRIMARY KEY,
    TenTacGia NVARCHAR(100) NOT NULL
);

CREATE TABLE TINHTRANG (
    MaTinhTrang INT IDENTITY(1,1) PRIMARY KEY,
    TenTinhTrang NVARCHAR(100) NOT NULL
);

CREATE TABLE KHUVUC (
    MaKhuVuc INT IDENTITY(1,1) PRIMARY KEY,
    TenKhuVuc NVARCHAR(100) NOT NULL,
	MaTheLoai INT NOT NULL,
    MoTa NVARCHAR(200),
	CONSTRAINT FK_KHUVUC_THELOAI FOREIGN KEY (MaTheLoai) REFERENCES THELOAI(MaTheLoai)
);

CREATE TABLE SACH (
    MaSach INT IDENTITY(1,1) PRIMARY KEY,
    TenSach NVARCHAR(100) NOT NULL,
    MaTheLoai INT NOT NULL,
    NamXuatBan INT NOT NULL,
    NhaXuatBan NVARCHAR(100),
	SoLuong INT NOT NULL CHECK (SoLuong >=0),
    MaTacGia INT NOT NULL,
    NgayNhap DATE NOT NULL,
    TriGia DECIMAL(18, 0) NOT NULL,
    MaTinhTrang INT NOT NULL,
    CONSTRAINT FK_SACH_THELOAI FOREIGN KEY (MaTheLoai) REFERENCES THELOAI(MaTheLoai),
    CONSTRAINT FK_SACH_TACGIA FOREIGN KEY (MaTacGia) REFERENCES TACGIA(MaTacGia),
    CONSTRAINT FK_SACH_TINHTRANG FOREIGN KEY (MaTinhTrang) REFERENCES TINHTRANG(MaTinhTrang)
);

CREATE TABLE YEUTHICH_SACH (
    MaYeuThich INT IDENTITY(1,1) PRIMARY KEY, 
	MaDocGia INT NOT NULL,
    MaSach INT NOT NULL,                       
    NgayDanhDau DATETIME DEFAULT GETDATE(),     
    GhiChu NVARCHAR(255),                       
    CONSTRAINT FK_YEUTHICH_SACH_DOCGIA FOREIGN KEY (MaDocGia) REFERENCES DOCGIA(MaDocGia),
	CONSTRAINT FK_YEUTHICH_SACH_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
    
);

CREATE TABLE DATCHO_SACH (
    MaDatCho INT IDENTITY(1,1) PRIMARY KEY,  
    MaDocGia INT NOT NULL,                   
    MaSach INT NOT NULL,                     
    NgayDatCho DATE NOT NULL DEFAULT GETDATE(), 
    ThuTuUuTien INT NOT NULL DEFAULT 1,      
    TrangThai NVARCHAR(50) NOT NULL DEFAULT N'Chờ duyệt',                          
    GhiChu NVARCHAR(200),                    
    CONSTRAINT FK_DATCHO_SACH_DOCGIA FOREIGN KEY (MaDocGia) REFERENCES DOCGIA(MaDocGia),
    CONSTRAINT FK_DATCHO_SACH_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE LOAITHONGBAO(
    MaLoaiThongBao INT IDENTITY(1,1) PRIMARY KEY,
	TenLoaiThongBao NVARCHAR(100) NOT NULL
);

CREATE TABLE THONGBAO (
    MaThongBao INT IDENTITY(1,1) PRIMARY KEY,       
    MaDocGia INT NOT NULL, 
	MaLoaiThongBao INT,
	MaMuonSach INT NULL, 
    NoiDung NVARCHAR(500) NOT NULL,                                                        
    NgayTao DATETIME DEFAULT GETDATE(),                  
    CONSTRAINT FK_THONGBAO_DOCGIA FOREIGN KEY (MaDocGia) REFERENCES DOCGIA(MaDocGia),
	CONSTRAINT FK_THONGBAO_LOAITHONGBAO FOREIGN KEY (MaLoaiThongBao) REFERENCES LOAITHONGBAO(MaLoaiThongBao)
);


CREATE TABLE MUONSACH (
    MaMuonSach INT IDENTITY(1,1) PRIMARY KEY,
    MaDocGia INT NOT NULL,
    NgayMuon DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_MUONSACH_DOCGIA FOREIGN KEY (MaDocGia) REFERENCES DOCGIA(MaDocGia)
);

CREATE TABLE CTMUONSACH (
    MaMuonSach INT,
    MaSach INT,
	SoLuongMuon INT NOT NULL CHECK (SoLuongMuon >= 0),
    HanTra DATETIME NOT NULL,
    TinhTrangMuon NVARCHAR(200) NOT NULL,
    PRIMARY KEY (MaMuonSach, MaSach),
    CONSTRAINT FK_CTMUONSACH_MUONSACH FOREIGN KEY (MaMuonSach) REFERENCES MUONSACH(MaMuonSach),
    CONSTRAINT FK_CTMUONSACH_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE TRASACH (
    MaTraSach INT IDENTITY(1,1) PRIMARY KEY,
    MaMuonSach INT NOT NULL,
    NgayTra DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_TRASACH_MUONSACH FOREIGN KEY (MaMuonSach) REFERENCES MUONSACH(MaMuonSach)
);

CREATE TABLE CTTRASACH (
    MaTraSach INT,
    MaSach INT,
	SoLuongTra INT NOT NULL CHECK (SoLuongTra >= 0),
    SoNgayMuon INT NOT NULL CHECK (SoNgayMuon >= 0),
    TienPhat DECIMAL(18, 0) NOT NULL CHECK (TienPhat >= 0),
    TinhTrangTraSach NVARCHAR(200) NOT NULL,
    GhiChu NVARCHAR(200),
    PRIMARY KEY (MaTraSach, MaSach),
    CONSTRAINT FK_CTTRASACH_TRASACH FOREIGN KEY (MaTraSach) REFERENCES TRASACH(MaTraSach),
    CONSTRAINT FK_CTTRASACH_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE BCTKMUONSACH (
    MaBCTKMuonSach INT IDENTITY(1,1) PRIMARY KEY,
    Thang DATE NOT NULL UNIQUE,
    TongSoLuotMuon INT NOT NULL
);

CREATE TABLE CTBCTKMUONSACH (
    MaBCTKMuonSach INT,
    MaTheLoai INT,
    SoLuotMuon INT NOT NULL CHECK (SoLuotMuon >= 0),
    TiLe FLOAT NOT NULL CHECK (TiLe >= 0 AND TiLe <= 1),
    PRIMARY KEY (MaBCTKMuonSach, MaTheLoai),
    CONSTRAINT FK_CTBCTKMUONSACH_BCTKMUONSACH FOREIGN KEY (MaBCTKMuonSach) REFERENCES BCTKMUONSACH(MaBCTKMuonSach),
    CONSTRAINT FK_CTBCTKMUONSACH_THELOAI FOREIGN KEY (MaTheLoai) REFERENCES THELOAI(MaTheLoai)
);

CREATE TABLE BCTKTRATRE (
    MaBCTKTraTre INT IDENTITY(1,1) PRIMARY KEY,
    Ngay DATE NOT NULL UNIQUE
);

CREATE TABLE CTBCTKTRATRE (
    MaBCTKTraTre INT,
    MaTraSach INT,
    MaSach INT,
    SoNgayTraTre INT NOT NULL CHECK (SoNgayTraTre >= 0),
    PRIMARY KEY (MaBCTKTraTre, MaTraSach, MaSach),
    CONSTRAINT FK_CTBCTKTRATRE_BCTKTRATRE FOREIGN KEY (MaBCTKTraTre) REFERENCES BCTKTRATRE(MaBCTKTraTre),
    CONSTRAINT FK_CTBCTKTRATRE_CTTRASACH FOREIGN KEY (MaTraSach, MaSach) REFERENCES CTTRASACH(MaTraSach, MaSach)
);

CREATE TABLE THUTIENPHAT (
    MaThuTP INT IDENTITY(1,1) PRIMARY KEY,
    MaDocGia INT NOT NULL,
	MaSach INT NOT NULL,
    TongNo DECIMAL(18, 0) NOT NULL CHECK (TongNo >= 0),
    SoTienThu DECIMAL(18, 0) NOT NULL CHECK (SoTienThu >= 0),
    ConLai DECIMAL(18, 0) NOT NULL CHECK (ConLai >= 0),
    NgayThu DATETIME NOT NULL,
    CONSTRAINT FK_THUTIENPHAT_DOCGIA FOREIGN KEY (MaDocGia) REFERENCES DOCGIA(MaDocGia),
	CONSTRAINT FK_THUTIENPHAT_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);


CREATE TABLE DANHGIA_NHANXET (
    MaDanhGia INT IDENTITY(1,1) PRIMARY KEY,  
    MaDocGia INT NOT NULL,                    
    MaSach INT NOT NULL,                       
    DiemDanhGia INT CHECK (DiemDanhGia BETWEEN 1 AND 5) NOT NULL, 
    NhanXet NVARCHAR(1000),                    
    NgayDanhGia DATETIME DEFAULT GETDATE(),    
    TrangThai NVARCHAR(50) DEFAULT N'Hiển thị', 
    GhiChu NVARCHAR(200),                     
    CONSTRAINT FK_DANHGIA_DOCGIA FOREIGN KEY (MaDocGia) REFERENCES DOCGIA(MaDocGia),
	CONSTRAINT FK_DANHGIA_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);





CREATE TRIGGER dg_CheckNgayHetHan
ON DOCGIA
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE NgayHetHan <= NgayLapThe
    )
    BEGIN
        RAISERROR('NgayHetHan phải lớn hơn NgayLapThe!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;




CREATE TRIGGER pts_TRASACH_Check_NgayTra
ON TRASACH
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN MUONSACH pm ON i.MaMuonSach = pm.MaMuonSach
        WHERE i.NgayTra < pm.NgayMuon
    )
    BEGIN
        RAISERROR (N'Ngày trả phải lớn hơn hoặc bằng ngày mượn!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;







/**CHỈ MỤC**/

-- DOCGIA
CREATE NONCLUSTERED INDEX IDX_DOCGIA_Email ON DOCGIA(Email);
CREATE NONCLUSTERED INDEX IDX_DOCGIA_Sdt ON DOCGIA(Sdt);
CREATE NONCLUSTERED INDEX IDX_DOCGIA_MaLoaiDocGia ON DOCGIA(MaLoaiDocGia);

-- TAIKHOAN
CREATE NONCLUSTERED INDEX IDX_TAIKHOAN_MaLoaiTaiKhoan ON TAIKHOAN(MaLoaiTaiKhoan);

-- ADMIN
CREATE NONCLUSTERED INDEX IDX_ADMIN_Email ON ADMIN(Email);
CREATE NONCLUSTERED INDEX IDX_ADMIN_Sdt ON ADMIN(Sdt);

-- PHANQUYEN
CREATE NONCLUSTERED INDEX IX_PHANQUYEN_TenPQ ON PHANQUYEN (TenPQ);

-- CTPHANQUYEN
CREATE NONCLUSTERED INDEX IX_CTPHANQUYEN_TrangThai ON CTPHANQUYEN (TrangThai);


-- SACH
CREATE NONCLUSTERED INDEX IDX_SACH_TenSach ON SACH(TenSach);
CREATE NONCLUSTERED INDEX IDX_SACH_MaTheLoai ON SACH(MaTheLoai);
CREATE NONCLUSTERED INDEX IDX_SACH_MaTacGia ON SACH(MaTacGia);
CREATE NONCLUSTERED INDEX IDX_SACH_MaTinhTrang ON SACH(MaTinhTrang);
CREATE NONCLUSTERED INDEX IX_SACH_SoLuong ON SACH(SoLuong);


-- PHIEUMUONSACH
CREATE NONCLUSTERED INDEX IDX_MUONSACH_MaDocGia ON MUONSACH(MaDocGia);

-- CTPHIEUMUON
CREATE NONCLUSTERED INDEX IDX_CTMUONSACH_MaSach ON CTMUONSACH(MaSach);

-- PHIEUTRASACH
CREATE NONCLUSTERED INDEX IDX_TRASACH_MaMuonSach ON TRASACH(MaMuonSach);

-- CTPHIEUTRASACH
CREATE NONCLUSTERED INDEX IDX_CTTRASACH_MaSach ON CTTRASACH(MaSach);

-- PHIEUTHUTIENPHAT
CREATE NONCLUSTERED INDEX IDX_THUTIENPHAT_MaDocGia ON THUTIENPHAT(MaDocGia);

-- CTBCTKMUONSACH
CREATE NONCLUSTERED INDEX IDX_CTBCTKMUONSACH_MaTheLoai ON CTBCTKMUONSACH(MaTheLoai);

-- CTBCTKTRATRE
CREATE NONCLUSTERED INDEX IDX_CTBCTKTRATRE_MaSach ON CTBCTKTRATRE(MaSach);

-- YEUTHICH_SACH
CREATE NONCLUSTERED INDEX IDX_YEUTHICH_DOCGIA_SACH ON YEUTHICH_SACH (MaDocGia, MaSach);

-- DANHGIA_NHANXET
CREATE UNIQUE NONCLUSTERED INDEX UQ_DANHGIA_DOCGIA_SACH ON DANHGIA_NHANXET (MaDocGia, MaSach);

-- DATCHO
CREATE NONCLUSTERED INDEX IDX_DATCHO_SACH_SACH_TRANGTHAI ON DATCHO_SACH (MaSach, TrangThai);





-- LOAITAIKHOAN
INSERT INTO LOAITAIKHOAN (TenLoaiTaiKhoan, MoTa) VALUES
(N'Admin', N'Tài khoản quản trị'),
(N'Thủ thư', N'Quản lý sách và độc giả'),
(N'Độc giả', N'Tài khoản người dùng');

-- TAIKHOAN
INSERT INTO TAIKHOAN (TaiKhoan, MatKhau, MaLoaiTaiKhoan) VALUES
('admin', '123456789', 1),
('thuthu', '123456789', 2),
('user1', '987654321', 3),
('user2', '987654321', 3),
('user3', '987654321', 3);

-- KHOATAIKHOAN
INSERT INTO KHOATAIKHOAN (ID, LyDo, NgayKhoa) VALUES
(3, N'Vi phạm', '2025-04-10');

-- LOAIDOCGIA
INSERT INTO LOAIDOCGIA (TenLoaiDocGia) VALUES
(N'Sinh viên'),
(N'Giảng viên');

-- DOCGIA (Ngày lập thẻ luôn trước ngày mượn sách đầu tiên)
INSERT INTO DOCGIA (HoTen, NgaySinh, DiaChi, Email, NgayLapThe, NgayHetHan, MaLoaiDocGia, ID, Sdt, TongNo, GioiThieu) VALUES
(N'Nguyễn Văn A', '2004-05-12', N'Hà Nội', 'a@hutech.com', '2025-01-01', '2029-01-01', 1, 3, '0909123456', 0, N'Giới thiệu A'),
(N'Trần Thị B', '1990-09-23', N'Hồ Chí Minh', 'b@hutech.com', '2025-01-01', '2029-01-01', 2, 4, '0912123456', 50000, N'Giới thiệu B'),
(N'Lê Văn C', '2004-11-30', N'Đà Nẵng', 'c@hutech.com', '2025-01-01', '2029-01-01', 1, 5, '0922123456', 0, N'Giới thiệu C');

-- ADMIN
INSERT INTO ADMIN (ID, HoTen, NgaySinh, DiaChi, Email, Sdt) VALUES
(1,N'Admin Nguyễn', '1990-01-01', N'Hà Nội', 'admin1@hutech.com', '0901000001');

-- THUTHU
INSERT INTO THUTHU (ID, HoTen, NgaySinh, DiaChi, Email, Sdt) VALUES
(2,N'Thuthu Nguyễn', '1999-03-05' , N'Tp.Hồ Chí Minh', 'thuthu@hutech.com', '0979878767');


-- PHANQUYEN
INSERT INTO PHANQUYEN (TenPQ, Quyen, MoTa) VALUES
(N'ADmin', 'AD', N'Được phép quản lý toàn bộ hệ thống'),
(N'Thuthu', 'TT', N'Quản lý sách và đọc giả'),
(N'Độc Giả', 'ĐG', N'Chỉ được xem thông tin của mình');



-- CTPHANQUYEN
INSERT INTO CTPHANQUYEN (IDPQ, MaLoaiTaiKhoan, TrangThai) VALUES
(1, 1, 0),
(2, 2, 0),
(3, 3, 0);


-- THELOAI
INSERT INTO THELOAI (TenTheLoai) VALUES
(N'Truyện tranh'),
(N'Giáo trình'),
(N'Văn học');

-- TACGIA
INSERT INTO TACGIA (TenTacGia) VALUES
(N'Nguyễn Nhật Ánh'),
(N'J.K. Rowling'),
(N'George Orwell');

-- TINHTRANG
INSERT INTO TINHTRANG (TenTinhTrang) VALUES
(N'Còn'),
(N'Hết');


-- KHUVUC
INSERT INTO KHUVUC (TenKhuVuc, MaTheLoai, MoTa) VALUES
(N'Khu vực A', 1, N'Khu vực dành cho truyện tranh'),
(N'Khu vực B', 2, N'Khu vực sách giáo trình'),
(N'Khu vực C', 3, N'Khu vực văn học');

-- SACH
INSERT INTO SACH (TenSach, MaTheLoai, NamXuatBan, NhaXuatBan, SoLuong, MaTacGia, NgayNhap, TriGia, MaTinhTrang) VALUES
(N'Mắt Biếc', 3, '2010', N'NXB Trẻ', 5, 1, '2025-01-05', 50000, 1),
(N'Harry Potter', 3, '2000', N'Bloomsbury', 10, 2, '2025-01-10', 150000, 1),
(N'1984', 2, '1949', N'Signet', 7, 3, '2025-01-15', 80000, 2);

-- DATCHO
INSERT INTO DATCHO_SACH (MaDocGia, MaSach, NgayDatCho, ThuTuUuTien, TrangThai, GhiChu) VALUES
(1, 2, GETDATE(), 1, N'Chờ duyệt', N'Đặt chỗ ưu tiên cao'),
(2, 3, '2025-03-15', 2, N'Đã duyệt', N'Đặt chỗ cần xác nhận lại'),
(3, 1, GETDATE(), 3, N'Hủy', N'Đã hủy do không đủ điều kiện');

-- LOAITHONGBAO
INSERT INTO LOAITHONGBAO (TenLoaiThongBao) VALUES
(N'Thời gian mượn sách'),
(N'Thời gian trả sách'),
(N'Sách mới');

-- THONGBAO
INSERT INTO THONGBAO (MaDocGia,MaLoaiThongBao, MaMuonSach, NoiDung, NgayTao) VALUES
(1,1,1,N'Sắp đến hạn trả sách', '2025-02-13');


-- YEUTICH_SACH
INSERT INTO YEUTHICH_SACH (MaDocGia, MaSach, NgayDanhDau, GhiChu) VALUES
(1, 2, GETDATE(), N'Yêu thích vì nội dung hấp dẫn'),
(2, 3, '2025-03-15', N'Thay đổi cuộc sống của mình sau khi đọc'),
(3, 1, GETDATE(), N'Sách tham khảo thường xuyên');

-- DANHGIA_NHANXET
INSERT INTO DANHGIA_NHANXET (MaDocGia, MaSach, DiemDanhGia, NhanXet, GhiChu) VALUES 
(1, 2, 5, N'Sách rất hay và ý nghĩa, giúp tôi hiểu thêm nhiều điều.', N'Đánh giá lần đầu'),
(2, 3, 4, N'Nội dung hấp dẫn, tuy nhiên phần cuối hơi khó hiểu.', N'Bổ sung ý kiến sau khi đọc lại'),
(3, 1, 3, N'Sách ổn, nhưng chưa thật sự đặc sắc như mong đợi.', N'Đánh giá trung lập');

-- MUONSACH (sau ngày lập thẻ và ngày nhập sách)
INSERT INTO MUONSACH (MaDocGia, NgayMuon) VALUES
(1, '2025-02-01'),
(2, '2025-02-05'),
(3, '2025-02-10');

-- CTPHIEUMUON
INSERT INTO CTMUONSACH (MaMuonSach, MaSach, SoLuongMuon, HanTra, TinhTrangMuon) VALUES
(1, 1, 2, '2025-02-15', N'Đang mượn'),
(2, 2, 1, '2025-02-20', N'Đang mượn'),
(3, 3, 3, '2025-02-25', N'Đang mượn');

-- PHIEUTRASACH (trả sau khi mượn)
INSERT INTO TRASACH (MaMuonSach, NgayTra) VALUES
(1, '2025-02-14'),
(2, '2025-02-25'),
(3, '2025-03-01');

-- CTPHIEUTRASACH (số ngày mượn khớp ngày mượn/trả)
INSERT INTO CTTRASACH (MaTraSach, MaSach,SoLuongTra, SoNgayMuon, TienPhat, TinhTrangTraSach, GhiChu) VALUES
(1, 1, 1, 13, 0, N'Tốt', N'Không ghi chú'),
(2, 2, 1, 20, 5000, N'Rách nhẹ', N'Cần bảo quản'),
(3, 3, 3, 20, 10000, N'Hỏng bìa', N'Phạt sửa chữa');

-- BCTKMUONSACH (Tháng báo cáo sau khi có phát sinh mượn sách)
INSERT INTO BCTKMUONSACH (Thang, TongSoLuotMuon) VALUES
('2025-02-01', 100),
('2025-03-01', 150),
('2025-04-01', 200);

-- CTBCTKMUONSACH
INSERT INTO CTBCTKMUONSACH (MaBCTKMuonSach, MaTheLoai, SoLuotMuon, TiLe) VALUES
(1, 1, 40, 0.4),
(2, 2, 60, 0.6),
(3, 3, 100, 0.67);

-- BCTKTRATRE (ngày sau khi đã có phát sinh trả sách)
INSERT INTO BCTKTRATRE (Ngay) VALUES
('2025-02-15'),
('2025-02-28'),
('2025-03-05');

-- CTBCTKTRATRE
INSERT INTO CTBCTKTRATRE (MaBCTKTraTre, MaTraSach, MaSach, SoNgayTraTre) VALUES
(1, 1, 1, 1),
(2, 2, 2, 3),
(3, 3, 3, 4);

-- PHIEUTHUTIENPHAT (sau ngày trả sách)
INSERT INTO THUTIENPHAT (MaDocGia, MaSach, TongNo, SoTienThu, ConLai, NgayThu) VALUES
(1, 1, 5000, 5000, 0, '2025-02-16'),
(2, 2, 10000, 5000, 5000, '2025-03-01'),
(3, 3, 15000, 15000, 0, '2025-03-05');


SELECT * FROM SACH
SELECT * FROM THELOAI
SELECT * FROM TACGIA
SELECT * FROM TAIKHOAN
SELECT * FROM LOAITAIKHOAN
SELECT * FROM DOCGIA
SELECT * FROM LOAIDOCGIA
SELECT * FROM TINHTRANG
SELECT * FROM MUONSACH
SELECT * FROM TRASACH
SELECT * FROM THUTIENPHAT
SELECT * FROM PHANQUYEN
SELECT * FROM CTPHANQUYEN
SELECT * FROM ADMIN
SELECT * FROM DATCHO_SACH
SELECT * FROM DANHGIA_NHANXET
SELECT * FROM YEUTHICH_SACH
SELECT * FROM THONGBAO
SELECT * FROM KHOATAIKHOAN




-- SACH

--*thêm
CREATE PROCEDURE sp_ThemSach
    @TenSach NVARCHAR(100),
    @MaTheLoai INT,
    @NamXuatBan INT,
    @NhaXuatBan NVARCHAR(100),
    @SoLuong INT,
    @MaTacGia INT,
    @NgayNhap DATE,
    @TriGia DECIMAL(18, 0),
    @MaTinhTrang INT
AS
BEGIN
    INSERT INTO SACH (TenSach, MaTheLoai, NamXuatBan, NhaXuatBan, SoLuong, MaTacGia, NgayNhap, TriGia, MaTinhTrang)
    VALUES (@TenSach, @MaTheLoai, @NamXuatBan, @NhaXuatBan, @SoLuong, @MaTacGia, @NgayNhap, @TriGia, @MaTinhTrang)
END;


--* xóa
CREATE PROCEDURE sp_XoaSach
    @MaSach INT
AS
BEGIN
    DELETE FROM SACH
    WHERE MaSach = @MaSach
END;


--* sửa
CREATE PROCEDURE sp_SuaSach
    @MaSach INT,
    @TenSach NVARCHAR(100),
    @SoLuong INT,
    @MaTinhTrang INT
AS
BEGIN
    UPDATE SACH
    SET TenSach = @TenSach,
        SoLuong = @SoLuong,
        MaTinhTrang = @MaTinhTrang
    WHERE MaSach = @MaSach
END;


--* tìm kiếm

CREATE PROCEDURE sp_TimKiemSach
    @TuKhoa NVARCHAR(100)
AS
BEGIN
    SELECT MaSach, TenSach, SoLuong, NamXuatBan
    FROM SACH
    WHERE TenSach LIKE '%' + @TuKhoa + '%'
END;

EXEC sp_TimKiemSach N'Mắt Biếc';








-- DOCGIA

--*thêm
CREATE PROCEDURE sp_ThemDocGia
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(200),
    @NgayLapThe DATE,
    @NgayHetHan DATE,
    @MaLoaiDocGia INT,
    @ID INT,  
    @Sdt VARCHAR(20),
    @TongNo DECIMAL(18, 0),
    @GioiThieu NVARCHAR(255)
AS
BEGIN
    INSERT INTO DOCGIA (HoTen, NgaySinh, DiaChi, Email, NgayLapThe, NgayHetHan, MaLoaiDocGia, ID, Sdt, TongNo, GioiThieu)
    VALUES (@HoTen, @NgaySinh, @DiaChi, @Email, @NgayLapThe, @NgayHetHan, @MaLoaiDocGia, @ID, @Sdt, @TongNo, @GioiThieu)
END;


--* xóa
CREATE PROCEDURE sp_XoaDocGia
    @MaDocGia INT
AS
BEGIN
    DELETE FROM DOCGIA
    WHERE MaDocGia = @MaDocGia
END;


--* sửa
CREATE PROCEDURE sp_SuaDocGia
    @MaDocGia INT,
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(200),
    @Sdt VARCHAR(20),
    @GioiThieu NVARCHAR(255)
AS
BEGIN
    UPDATE DOCGIA
    SET HoTen = @HoTen,
        NgaySinh = @NgaySinh,
        DiaChi = @DiaChi,
        Email = @Email,
        Sdt = @Sdt,
        GioiThieu = @GioiThieu
    WHERE MaDocGia = @MaDocGia
END;


--* tìm kiếm 

CREATE PROCEDURE sp_TimKiemDocGia_MaHoTen
    @MaDocGia INT = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SELECT MaDocGia, HoTen, Email, Sdt, NgayLapThe, NgayHetHan
    FROM DOCGIA
    WHERE (@MaDocGia IS NULL OR MaDocGia = @MaDocGia)
      AND (@TuKhoa IS NULL OR HoTen LIKE '%' + @TuKhoa + '%')
END;

EXEC sp_TimKiemDocGia_MaHoTen @MaDocGia = 2;
EXEC sp_TimKiemDocGia_MaHoTen @TuKhoa = N'Nguyễn';









-- THELOAI

--*thêm
CREATE PROCEDURE sp_ThemTheLoai
    @TenTheLoai NVARCHAR(100)
AS
BEGIN
    INSERT INTO THELOAI (TenTheLoai)
    VALUES (@TenTheLoai)
END;


--* xóa
CREATE PROCEDURE sp_XoaTheLoai
    @MaTheLoai INT
AS
BEGIN
    DELETE FROM THELOAI
    WHERE MaTheLoai = @MaTheLoai
END;


--* sửa
CREATE PROCEDURE sp_SuaTheLoai
    @MaTheLoai INT,
    @TenTheLoai NVARCHAR(100)
AS
BEGIN
    UPDATE THELOAI
    SET TenTheLoai = @TenTheLoai
    WHERE MaTheLoai = @MaTheLoai
END;



--* tìm kiếm
CREATE PROCEDURE sp_TimKiemTheLoai
    @MaTheLoai INT = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SELECT MaTheLoai, TenTheLoai
    FROM THELOAI
    WHERE (@MaTheLoai IS NULL OR MaTheLoai = @MaTheLoai)
      AND (@TuKhoa IS NULL OR TenTheLoai LIKE '%' + @TuKhoa + '%')
END;

EXEC sp_TimKiemTheLoai @MaTheLoai = 1;
EXEC sp_TimKiemTheLoai @TuKhoa = N'Truyện';







-- TACGIA

--*thêm
CREATE PROCEDURE sp_ThemTacGia
    @TenTacGia NVARCHAR(100)
AS
BEGIN
    INSERT INTO TACGIA (TenTacGia)
    VALUES (@TenTacGia)
END;

EXEC sp_ThemTacGia N'Nguyễn Nhật Ánh';



--* xóa
CREATE PROCEDURE sp_XoaTacGia
    @MaTacGia INT
AS
BEGIN
    DELETE FROM TACGIA
    WHERE MaTacGia = @MaTacGia
END;

EXEC sp_XoaTacGia 4;

--* sửa
CREATE PROCEDURE sp_SuaTacGia
    @MaTacGia INT,
    @TenTacGia NVARCHAR(100)
AS
BEGIN
    UPDATE TACGIA
    SET TenTacGia = @TenTacGia
    WHERE MaTacGia = @MaTacGia
END;



--* tìm kiếm

CREATE PROCEDURE sp_TimKiemTacGia
    @MaTacGia INT = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SELECT MaTacGia, TenTacGia
    FROM TACGIA
    WHERE (@MaTacGia IS NULL OR MaTacGia = @MaTacGia)
      AND (@TuKhoa IS NULL OR TenTacGia LIKE '%' + @TuKhoa + '%')
END;

EXEC sp_TimKiemTacGia @TuKhoa = N'Nguyễn';
EXEC sp_TimKiemTacGia @MaTacGia = 1








-- MUONSACH

--*thêm
CREATE PROCEDURE sp_ThemMuonSach
    @MaDocGia INT,
    @NgayMuon DATE
AS
BEGIN
    INSERT INTO MUONSACH (MaDocGia, NgayMuon)
    VALUES (@MaDocGia, @NgayMuon)
END;

EXEC sp_ThemMuonSach @MaDocGia = 2, @NgayMuon = '2025-03-28';



--* xóa
CREATE PROCEDURE sp_XoaMuonSach
    @MaMuonSach INT
AS
BEGIN
    DELETE FROM MUONSACH
    WHERE MaMuonSach = @MaMuonSach
END;

EXEC sp_XoaMuonSach @MaMuonSach = 1;



--* sửa
CREATE PROCEDURE sp_SuaMuonSach
    @MaMuonSach INT,
    @MaDocGia INT,
    @NgayMuon DATE
AS
BEGIN
    UPDATE MUONSACH
    SET MaDocGia = @MaDocGia,
        NgayMuon = @NgayMuon
    WHERE MaMuonSach = @MaMuonSach
END;

EXEC sp_SuaMuonSach @MaMuonSach = 3, @MaDocGia = 2, @NgayMuon = '2025-03-20';



--* tìm kiếm
CREATE PROCEDURE sp_TimKiemMuonSach
    @MaMuonSach INT = NULL,
    @TuNgay DATE = NULL,
    @DenNgay DATE = NULL
AS
BEGIN
    SELECT MaMuonSach, MaDocGia, NgayMuon
    FROM MUONSACH
    WHERE (@MaMuonSach IS NULL OR MaMuonSach = @MaMuonSach)
      AND (@TuNgay IS NULL OR NgayMuon >= @TuNgay)
      AND (@DenNgay IS NULL OR NgayMuon <= @DenNgay)
END;

EXEC sp_TimKiemMuonSach @MaMuonSach = 2;
EXEC sp_TimKiemMuonSach @TuNgay = '2025-02-01', @DenNgay = '2025-03-01';









-- THONGBAO
CREATE TRIGGER trg_TuDongThongBao_GanDenHan
ON CTMUONSACH
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
   
    INSERT INTO THONGBAO (MaDocGia, MaLoaiThongBao, MaMuonSach, NoiDung, NgayTao)
    SELECT d.MaDocGia, 
           1,  
           m.MaMuonSach,
           N'Thông báo: Sách của bạn sắp đến hạn trả. Vui lòng kiểm tra và trả đúng hạn.',
           GETDATE()
    FROM inserted i
    INNER JOIN MUONSACH m ON i.MaMuonSach = m.MaMuonSach
    INNER JOIN DOCGIA d ON m.MaDocGia = d.MaDocGia
    WHERE DATEDIFF(day, GETDATE(), i.HanTra) BETWEEN 0 AND 3;
END;




-- TRASACH

--*thêm
CREATE PROCEDURE sp_ThemTraSach
    @MaMuonSach INT,
    @NgayTra DATE
AS
BEGIN
    INSERT INTO TRASACH (MaMuonSach, NgayTra)
    VALUES (@MaMuonSach, @NgayTra)
END;

EXEC sp_ThemTraSach @MaMuonSach = 1, @NgayTra = '2025-03-28';



--* xóa
CREATE PROCEDURE sp_XoaTraSach
    @MaTraSach INT
AS
BEGIN
    DELETE FROM TRASACH
    WHERE MaTraSach = @MaTraSach
END;

EXEC sp_XoaTraSach @MaTraSach = 3;



--* sửa
CREATE PROCEDURE sp_SuaTraSach
    @MaTraSach INT,
    @MaMuonSach INT,
    @NgayTra DATE
AS
BEGIN
    UPDATE TRASACH
    SET MaMuonSach = @MaMuonSach,
        NgayTra = @NgayTra
    WHERE MaTraSach = @MaTraSach
END;

EXEC sp_SuaTraSach @MaTraSach = 2, @MaMuonSach = 1, @NgayTra = '2025-03-25';



--* tìm kiếm
CREATE PROCEDURE sp_TimKiemTraSach
    @MaTraSach INT = NULL,
    @TuNgay DATE = NULL,
    @DenNgay DATE = NULL
AS
BEGIN
    SELECT MaTraSach, MaMuonSach, NgayTra
    FROM TRASACH
    WHERE (@MaTraSach IS NULL OR MaTraSach = @MaTraSach)
      AND (@TuNgay IS NULL OR NgayTra >= @TuNgay)
      AND (@DenNgay IS NULL OR NgayTra <= @DenNgay)
END;

EXEC sp_TimKiemTraSach @MaTraSach = 1;
EXEC sp_TimKiemTraSach @TuNgay = '2025-02-01', @DenNgay = '2025-03-15';



-- DANHGIA_NHANXET

--*thêm
CREATE PROCEDURE sp_ThemDanhGia
    @MaDocGia INT,
    @MaSach INT,
    @DiemDanhGia INT,
    @NhanXet NVARCHAR(1000),
    @GhiChu NVARCHAR(200)
AS
BEGIN
    INSERT INTO DANHGIA_NHANXET (MaDocGia, MaSach, DiemDanhGia, NhanXet, NgayDanhGia, TrangThai, GhiChu)
    VALUES (@MaDocGia, @MaSach, @DiemDanhGia, @NhanXet, GETDATE(), N'Hiển thị', @GhiChu)
END;

EXEC sp_ThemDanhGia 3, 2, 4, N'Sách rất cuốn hút', N'Lần đầu đánh giá';



--*sửa
CREATE PROCEDURE sp_SuaDanhGia
    @MaDanhGia INT,
    @DiemDanhGia INT,
    @NhanXet NVARCHAR(1000),
    @TrangThai NVARCHAR(50),
    @GhiChu NVARCHAR(200)
AS
BEGIN
    UPDATE DANHGIA_NHANXET
    SET DiemDanhGia = @DiemDanhGia,
        NhanXet = @NhanXet,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu
    WHERE MaDanhGia = @MaDanhGia
END;

EXEC sp_SuaDanhGia 1, 5, N'Xuất sắc, nội dung tuyệt vời!', N'Hiển thị', N'Cập nhật';



--*tìm kiếm
CREATE PROCEDURE sp_TimKiemDanhGia
    @MaSach INT = NULL,
    @MaDocGia INT = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SELECT MaDanhGia, MaDocGia, MaSach, DiemDanhGia, NhanXet, NgayDanhGia, TrangThai
    FROM DANHGIA_NHANXET
    WHERE (@MaSach IS NULL OR MaSach = @MaSach)
      AND (@MaDocGia IS NULL OR MaDocGia = @MaDocGia)
      AND (@TuKhoa IS NULL OR NhanXet LIKE '%' + @TuKhoa + '%')
END;

EXEC sp_TimKiemDanhGia @MaSach = 1;
EXEC sp_TimKiemDanhGia @MaDocGia = 3;
EXEC sp_TimKiemDanhGia @TuKhoa = N'tuyệt';


--*xóa
CREATE PROCEDURE sp_XoaDanhGia
    @MaDanhGia INT
AS
BEGIN
    DELETE FROM DANHGIA_NHANXET
    WHERE MaDanhGia = @MaDanhGia
END;

EXEC sp_XoaDanhGia 2;




-- KHOATAIKHOAN

--*thêm
CREATE PROCEDURE sp_ThemKhoaTaiKhoan
    @ID INT,  -- ID người dùng từ bảng TAIKHOAN
    @LyDo NVARCHAR(255)
AS
BEGIN
    INSERT INTO KHOATAIKHOAN (ID, LyDo, NgayKhoa)
    VALUES (@ID, @LyDo, GETDATE())
END;

EXEC sp_ThemKhoaTaiKhoan @ID = 3, @LyDo = N'Vi phạm quy định mượn sách';

 --*xóa
CREATE PROCEDURE sp_XoaKhoaTaiKhoan
    @IDKhoa INT
AS
BEGIN
    DELETE FROM KHOATAIKHOAN
    WHERE IDKhoa = @IDKhoa
END;

EXEC sp_XoaKhoaTaiKhoan @IDKhoa = 1;



--*sửa
CREATE PROCEDURE sp_SuaKhoaTaiKhoan
    @IDKhoa INT,
    @LyDo NVARCHAR(255),
    @NgayKhoa DATE
AS
BEGIN
    UPDATE KHOATAIKHOAN
    SET LyDo = @LyDo,
        NgayKhoa = @NgayKhoa
    WHERE IDKhoa = @IDKhoa
END;

EXEC sp_SuaKhoaTaiKhoan 
    @IDKhoa = 2,
    @LyDo = N'Cập nhật lý do',
    @NgayKhoa = GETDATE();





--*tìm kiếm
CREATE PROCEDURE sp_TimKiemKhoaTaiKhoan
    @IDKhoa INT = NULL,
    @ID INT = NULL
AS
BEGIN
    SELECT kt.IDKhoa, kt.ID, tk.TaiKhoan, kt.LyDo, kt.NgayKhoa
    FROM KHOATAIKHOAN kt
    INNER JOIN TAIKHOAN tk ON kt.ID = tk.ID
    WHERE (@IDKhoa IS NULL OR kt.IDKhoa = @IDKhoa)
      AND (@ID IS NULL OR kt.ID = @ID)
END;

EXEC sp_TimKiemKhoaTaiKhoan @IDKhoa = 2;
EXEC sp_TimKiemKhoaTaiKhoan @ID = 3;





-- CTMUONSACH
CREATE TRIGGER trg_Update_SoLuong_Sach_AfterInsert
ON CTMUONSACH
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE S
    SET S.SoLuong = S.SoLuong - I.SoLuongMuon
    FROM SACH S
    INNER JOIN inserted I ON S.MaSach = I.MaSach;
END;



CREATE TRIGGER trg_Update_SoLuong_Sach_AfterDelete
ON CTMUONSACH
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE S
    SET S.SoLuong = S.SoLuong + D.SoLuongMuon
    FROM SACH S
    INNER JOIN deleted D ON S.MaSach = D.MaSach;
END;








-- YEUTHICH__SACH

--*thêm
CREATE PROCEDURE sp_ThemYeuThichSach
    @MaDocGia INT,
    @MaSach INT,
    @GhiChu NVARCHAR(255) = NULL
AS
BEGIN
    INSERT INTO YEUTHICH_SACH (MaDocGia, MaSach, NgayDanhDau, GhiChu)
    VALUES (@MaDocGia, @MaSach, GETDATE(), @GhiChu)
END;

EXEC sp_ThemYeuThichSach 2, 3, N'Tác phẩm truyền cảm hứng';



--*xóa
CREATE PROCEDURE sp_XoaYeuThichSach
    @MaYeuThich INT
AS
BEGIN
    DELETE FROM YEUTHICH_SACH
    WHERE MaYeuThich = @MaYeuThich
END;

EXEC sp_XoaYeuThichSach 1;



--*tìm kiếm
CREATE PROCEDURE sp_TimKiemYeuThichSach
    @MaDocGia INT = NULL,
    @MaSach INT = NULL
AS
BEGIN
    SELECT ys.MaYeuThich, ys.MaDocGia, dg.HoTen, ys.MaSach, s.TenSach, ys.NgayDanhDau, ys.GhiChu
    FROM YEUTHICH_SACH ys
    INNER JOIN DOCGIA dg ON ys.MaDocGia = dg.MaDocGia
    INNER JOIN SACH s ON ys.MaSach = s.MaSach
    WHERE (@MaDocGia IS NULL OR ys.MaDocGia = @MaDocGia)
      AND (@MaSach IS NULL OR ys.MaSach = @MaSach)
END;

EXEC sp_TimKiemYeuThichSach @MaDocGia = 2;
EXEC sp_TimKiemYeuThichSach @MaSach = 1;





-- TAIKHOAN

--*thêm
CREATE PROCEDURE sp_ThemTaiKhoan
    @TaiKhoan VARCHAR(100),
    @MatKhau VARCHAR(100),
    @MaLoaiTaiKhoan INT
AS
BEGIN
    INSERT INTO TAIKHOAN (TaiKhoan, MatKhau, MaLoaiTaiKhoan)
    VALUES (@TaiKhoan, @MatKhau, @MaLoaiTaiKhoan)
END;

EXEC sp_ThemTaiKhoan 'user123', 'matkhau123', 3;



--*xóa
CREATE PROCEDURE sp_XoaTaiKhoan
    @ID INT
AS
BEGIN
    DELETE FROM TAIKHOAN
    WHERE ID = @ID
END;

EXEC sp_XoaTaiKhoan 5;



--*sửa
CREATE PROCEDURE sp_SuaTaiKhoan
    @ID INT,
    @TaiKhoan VARCHAR(100),
    @MatKhau VARCHAR(100),
    @MaLoaiTaiKhoan INT
AS
BEGIN
    UPDATE TAIKHOAN
    SET TaiKhoan = @TaiKhoan,
        MatKhau = @MatKhau,
        MaLoaiTaiKhoan = @MaLoaiTaiKhoan
    WHERE ID = @ID
END;

EXEC sp_SuaTaiKhoan 3, 'user123_updated', 'newpass456', 2;



--*tìm kiếm
CREATE PROCEDURE sp_TimKiemTaiKhoan
    @ID INT = NULL,
    @TuKhoa VARCHAR(100) = NULL,
    @MaLoaiTaiKhoan INT = NULL
AS
BEGIN
    SELECT tk.ID, tk.TaiKhoan, ltk.TenLoaiTaiKhoan
    FROM TAIKHOAN tk
    INNER JOIN LOAITAIKHOAN ltk ON tk.MaLoaiTaiKhoan = ltk.MaLoaiTaiKhoan
    WHERE (@ID IS NULL OR tk.ID = @ID)
      AND (@TuKhoa IS NULL OR tk.TaiKhoan LIKE '%' + @TuKhoa + '%')
      AND (@MaLoaiTaiKhoan IS NULL OR tk.MaLoaiTaiKhoan = @MaLoaiTaiKhoan)
END;

EXEC sp_TimKiemTaiKhoan @ID = 3;
EXEC sp_TimKiemTaiKhoan @TuKhoa = 'admin';
EXEC sp_TimKiemTaiKhoan @MaLoaiTaiKhoan = 1;






-- PHANQUYEN
CREATE TRIGGER trg_Unique_TenPQ
ON PHANQUYEN
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM PHANQUYEN p
        INNER JOIN inserted i ON p.TenPQ = i.TenPQ
    )
    BEGIN
        RAISERROR(N'Tên phân quyền đã tồn tại!', 16, 1)
        RETURN
    END

    INSERT INTO PHANQUYEN (TenPQ, Quyen, MoTa)
    SELECT TenPQ, Quyen, MoTa FROM inserted
END;





-- DATCHO_SACH

--*thêm
CREATE PROCEDURE sp_ThemDatChoSach
    @MaDocGia INT,
    @MaSach INT,
    @ThuTuUuTien INT = 1,
    @TrangThai NVARCHAR(50) = N'Chờ duyệt',
    @GhiChu NVARCHAR(200) = NULL
AS
BEGIN
    INSERT INTO DATCHO_SACH (MaDocGia, MaSach, NgayDatCho, ThuTuUuTien, TrangThai, GhiChu)
    VALUES (@MaDocGia, @MaSach, GETDATE(), @ThuTuUuTien, @TrangThai, @GhiChu)
END;

EXEC sp_ThemDatChoSach @MaDocGia = 2, @MaSach = 1, @ThuTuUuTien = 1, @TrangThai = N'Chờ duyệt', @GhiChu = N'Đặt ưu tiên cao';



--*sửa
CREATE PROCEDURE sp_SuaDatChoSach
    @MaDatCho INT,
    @ThuTuUuTien INT,
    @TrangThai NVARCHAR(50),
    @GhiChu NVARCHAR(200)
AS
BEGIN
    UPDATE DATCHO_SACH
    SET ThuTuUuTien = @ThuTuUuTien,
        TrangThai = @TrangThai,
        GhiChu = @GhiChu
    WHERE MaDatCho = @MaDatCho
END;

EXEC sp_SuaDatChoSach @MaDatCho = 1, @ThuTuUuTien = 2, @TrangThai = N'Đã duyệt', @GhiChu = N'Cập nhật lại';



--*xóa
CREATE PROCEDURE sp_XoaDatChoSach
    @MaDatCho INT
AS
BEGIN
    DELETE FROM DATCHO_SACH
    WHERE MaDatCho = @MaDatCho
END;

EXEC sp_XoaDatChoSach @MaDatCho = 1;


--*tìm kiếm

CREATE PROCEDURE sp_TimKiemDatChoSach
    @MaDocGia INT = NULL,
    @MaSach INT = NULL,
    @TrangThai NVARCHAR(50) = NULL
AS
BEGIN
    SELECT dc.MaDatCho, dc.MaDocGia, dg.HoTen, dc.MaSach, s.TenSach,
           dc.NgayDatCho, dc.ThuTuUuTien, dc.TrangThai, dc.GhiChu
    FROM DATCHO_SACH dc
    INNER JOIN DOCGIA dg ON dc.MaDocGia = dg.MaDocGia
    INNER JOIN SACH s ON dc.MaSach = s.MaSach
    WHERE (@MaDocGia IS NULL OR dc.MaDocGia = @MaDocGia)
      AND (@MaSach IS NULL OR dc.MaSach = @MaSach)
      AND (@TrangThai IS NULL OR dc.TrangThai = @TrangThai)
END;

EXEC sp_TimKiemDatChoSach @TrangThai = N'Chờ duyệt';
EXEC sp_TimKiemDatChoSach @MaDocGia = 2;
EXEC sp_TimKiemDatChoSach @MaSach = 1, @TrangThai = N'Đã duyệt';



-- CTPHANQUYEN
CREATE TRIGGER trg_Validate_CTPHANQUYEN
ON CTPHANQUYEN
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    
    IF EXISTS (
        SELECT 1 FROM inserted WHERE TrangThai NOT IN (0, 1)
    )
    BEGIN
        RAISERROR(N'Lỗi: Giá trị TrangThai chỉ được là 0 hoặc 1!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;



-- CTTRASACH
CREATE TRIGGER trg_Validate_CTTRASACH
ON CTTRASACH
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    
    IF EXISTS (SELECT 1 FROM inserted WHERE SoLuongTra < 0)
    BEGIN
        RAISERROR(N'Lỗi: Số lượng trả không được nhỏ hơn 0!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM inserted WHERE TienPhat < 0)
    BEGIN
        RAISERROR(N'Lỗi: Tiền phạt không được nhỏ hơn 0!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;




-- ADMIN

--*thêm
CREATE PROCEDURE sp_ThemAdmin
    @ID INT,
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(200),
    @Sdt VARCHAR(20)
AS
BEGIN
    INSERT INTO ADMIN (ID, HoTen, NgaySinh, DiaChi, Email, Sdt)
    VALUES (@ID, @HoTen, @NgaySinh, @DiaChi, @Email, @Sdt)
END;

EXEC sp_ThemAdmin 1, N'Nguyễn Văn Quản Trị', '1990-01-01', N'Hà Nội', 'admin6@hutech.com', '0909999999';



--*sửa
CREATE PROCEDURE sp_SuaAdmin
    @ID INT,
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(200),
    @Sdt VARCHAR(20)
AS
BEGIN
    UPDATE ADMIN
    SET HoTen = @HoTen, 
		NgaySinh = @NgaySinh, 
		DiaChi = @DiaChi,
		Email = @Email,
        Sdt = @Sdt
    WHERE ID = @ID
END;

EXEC sp_SuaAdmin 1, N'Nguyễn Văn A', '1991-01-01', N'HCM', 'admin6@hutech.com', '0909111111';



--*xóa
CREATE PROCEDURE sp_XoaAdmin
    @ID INT
AS
BEGIN
    DELETE FROM ADMIN
    WHERE ID = @ID
END;

EXEC sp_XoaAdmin 1;


--*tìm kiếm
CREATE PROCEDURE sp_TimKiemAdmin
    @ID INT = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SELECT ID, HoTen, NgaySinh, DiaChi, Email, Sdt
    FROM ADMIN
    WHERE (@ID IS NULL OR ID = @ID)
      AND (@TuKhoa IS NULL OR HoTen LIKE '%' + @TuKhoa + '%')
END;

EXEC sp_TimKiemAdmin @ID = 1;
EXEC sp_TimKiemAdmin @TuKhoa = N'Nguyễn';





-- THUTHU

--*thêm
CREATE PROCEDURE sp_ThemThuThu
    @ID INT,
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(200),
    @Sdt VARCHAR(20)
AS
BEGIN
    INSERT INTO THUTHU (ID, HoTen, NgaySinh, DiaChi, Email, Sdt)
    VALUES (@ID, @HoTen, @NgaySinh, @DiaChi, @Email, @Sdt)
END;

EXEC sp_ThemThuThu 1, N'Ngô Thị Thủ Thư', '1995-05-01', N'Đà Nẵng', 'thuthu7@hutech.com', '0908777666';

--*sửa
CREATE PROCEDURE sp_SuaThuThu
    @ID INT,
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(200),
    @Sdt VARCHAR(20)
AS
BEGIN
    UPDATE THUTHU
    SET HoTen = @HoTen,
        NgaySinh = @NgaySinh,
        DiaChi = @DiaChi,
        Email = @Email,
        Sdt = @Sdt
    WHERE ID = @ID
END;

EXEC sp_SuaThuThu 1, N'Ngô Thị Sửa', '1995-06-01', N'Huế', 'thuthu7@hutech.com', '0908999888';



--*xóa

CREATE PROCEDURE sp_XoaThuThu
    @ID INT
AS
BEGIN
    DELETE FROM THUTHU
    WHERE ID = @ID
END;

EXEC sp_XoaThuThu 1;


--*tìm kiếm

CREATE PROCEDURE sp_TimKiemThuThu
    @ID INT = NULL,
    @TuKhoa NVARCHAR(100) = NULL
AS
BEGIN
    SELECT ID, HoTen, NgaySinh, DiaChi, Email, Sdt
    FROM THUTHU
    WHERE (@ID IS NULL OR ID = @ID)
      AND (@TuKhoa IS NULL OR HoTen LIKE '%' + @TuKhoa + '%')
END;

EXEC sp_TimKiemThuThu @ID = 1;
EXEC sp_TimKiemThuThu @TuKhoa = N'Thuthu';


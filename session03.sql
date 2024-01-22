-- Tạo csdl 
create database session03_pt_jv06;
use session03_pt_jv06;
-- tạo bảng lop hoc 

create table lop_hoc(
	id int,
    ten_lop varchar(20),
    trang_thai bit(1)
);

-- thêm mới dữ liệu vào bảng lop_hoc
INSERT INTO lop_hoc(id,ten_lop,trang_thai) VALUES (1,'JAVA2306',1);
INSERT INTO lop_hoc(id,ten_lop,trang_thai) VALUES (2,'JAVA2307',1);
INSERT INTO lop_hoc(id,ten_lop,trang_thai) VALUES (2,'JAVA2411',0);
INSERT INTO lop_hoc(id,ten_lop,trang_thai) VALUES (3,'JAVA2412',0);

-- lấy tất cả các trường và tất cả bản ghi
SELECT * FROM lop_hoc;
select ten_lop FROM lop_hoc;

-- ràng buộc khóa chính 
-- DROP table lop_hoc;
DROP table lop_hoc;
create table lop_hoc(
	id int primary key auto_increment,
    ten_lop varchar(20),
    trang_thai bit(1)
);
INSERT INTO lop_hoc(ten_lop,trang_thai) VALUES ('JAVA2306',1);
INSERT INTO lop_hoc(ten_lop,trang_thai) VALUES ('JAVA2307',1);
INSERT INTO lop_hoc(ten_lop,trang_thai) VALUES ('JAVA2411',0);
INSERT INTO lop_hoc(trang_thai) VALUES (0);
-- câu lệnh 1 bản ghi trên bảng
DELETE FROM lop_hoc WHERE id = 4;

-- ràng buộc unique
DROP table lop_hoc;
create table lop_hoc(
	id int primary key auto_increment,
    ten_lop varchar(20) unique,
    trang_thai bit(1)
);
-- Ràng buộc không rỗng 
DROP table lop_hoc;
create table lop_hoc(
	id int primary key auto_increment,
    ten_lop varchar(20) unique not null,
    trang_thai bit(1)
);
-- giá trị mặc định 
DROP table lop_hoc;
create table lop_hoc(
	id int primary key auto_increment,
    ten_lop varchar(20) unique not null,
    trang_thai bit(1) default 1
);
INSERT INTO lop_hoc(ten_lop) VALUES ('JAVA2306');
-- Ràng buộc khóa ngoại
-- tạo bảng sinh_vien
create table sinh_vien(
	id int primary key auto_increment,
    ho_ten varchar(50) not null,
    tuoi int,
    gioi_tinh bit(1),
    phone varchar(14),
    lop_hoc_id int not null,
    foreign key (lop_hoc_id) references lop_hoc(id)
);
SELECT * FROM lop_hoc;
INSERT INTO sinh_vien(ho_ten,tuoi,gioi_tinh,phone,lop_hoc_id)
VALUES ('Nguyen thi hoa',18,0,'01232131231',1);
INSERT INTO sinh_vien(ho_ten,tuoi,gioi_tinh,phone,lop_hoc_id)
VALUES ('Nguyen thi hoa',18,0,'01232131231',100); -- sai 
SELECT * FROM sinh_vien;
DELETE FROM lop_hoc WHERE id = 1; -- sai 
-- ràng buộc check 
INSERT INTO sinh_vien(ho_ten,tuoi,gioi_tinh,phone,lop_hoc_id)
VALUES ('Nguyen thi hoa',-18,0,'012312312312',1);
INSERT INTO sinh_vien(ho_ten,tuoi,gioi_tinh,phone,lop_hoc_id)
VALUES ('Nguyen thi hoa',1800,0,'012312312312',1);
DROP TABLE sinh_vien;
create table sinh_vien(
	id int primary key auto_increment,
    ho_ten varchar(50) not null,
    tuoi int check(tuoi >6 AND tuoi <100),
    gioi_tinh bit(1),
    phone varchar(14),
    lop_hoc_id int not null,
    foreign key (lop_hoc_id) references lop_hoc(id)
);
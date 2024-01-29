create database session06;
use session06;
create table lop_hoc(
	id int primary key auto_increment,
    ten_lop varchar(20) not null unique,
    so_luong int default 0
);
create table sinh_vien(
	id int primary key auto_increment,
    ho_ten varchar(50) not null,
    tuoi int,
    lop_hoc_id int not null,
    foreign key (lop_hoc_id) references lop_hoc(id)
);

INSERT INTO lop_hoc(ten_lop) value ('JAV2203');
INSERT INTO lop_hoc(ten_lop) value ('JAV2204');
INSERT INTO lop_hoc(ten_lop) value ('JAV2205');
UPDATE lop_hoc SET so_luong = 10 WHERE id = 1;
SELECT * FROM lop_hoc;

-- tạo trigger 
DROP TRIGGER IF exists tg_after;
DELIMITER $$
	CREATE TRIGGER tg_after
    after insert ON sinh_vien
    FOR each row
    BEGIN
		declare love_id int;
        SET love_id = new.lop_hoc_id;
		UPDATE lop_hoc SET so_luong = so_luong + 1 WHERE id = love_id;
    END $$
DELIMITER ;

SELECT * FROM lop_hoc;
INSERT INTO sinh_vien(ho_ten,tuoi,lop_hoc_id) value ('Lan Ngoc',18,2);

-- tạo trigger hi thực hiện thêm mới vào bảng sinh_vien 
DROP TRIGGER IF exists tg_after;
DELIMITER $$
	CREATE TRIGGER tg_before_check_age
    before insert ON sinh_vien
    FOR each row
    BEGIN
		IF new.tuoi <18 THEN
			BEGIN
				SET new.tuoi = 18;
            END;
		END IF;
    END $$
DELIMITER ;
SELECT * FROM sinh_vien;
INSERT INTO sinh_vien(ho_ten,tuoi,lop_hoc_id) value ('Lan DOt Bien',10,2);

use qlbh;
DELETE FROM orders;
DELETE FROM order_details;
SELECT * FROM orders;
SELECT * FROM order_details;

start transaction;
INSERT INTO orders (user_id,ship_address,phone_number) VALUES (1,'30 Phạm Văn Đồng','012123231');
INSERT INTO order_detail (order_id,product_id,price,quantity) VALUES (7,1,100,1);
INSERT INTO order_detail (order_id,product_id,price,quantity) VALUES (9,2,100,1);
rollback;


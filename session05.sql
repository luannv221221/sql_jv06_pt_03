create database qlbh;
use qlbh;
create table categories(
	id int primary key auto_increment,
    name varchar(100) unique,
    status bit(1) default 1
);
create table products(
	id int primary key auto_increment,
    name varchar(100) unique,
    price int not null,
    category_id int,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);
create table users(
	id int primary key auto_increment,
    name varchar(100) not null,
    password varchar(100) not null,
    username varchar(100) unique
);
create table orders(
	id int primary key auto_increment,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    status bit(1) default 1,
    ship_address varchar(255) not null,
    phone_number varchar(15) not null
);
create table order_details(
	order_id int,
    product_id int,
    price int not null,
    quantity int,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

insert into categories (name) values('ao');
insert into categories (name) values('quan');
insert into categories (name) values('mu');
insert into categories (name) values('giay');
insert into categories (name) values('dep');

insert into products (name, price, category_id) values('ao ba lo',100,1);
insert into products (name, price, category_id) values('quan ong suong',200,2);
insert into products (name, price, category_id) values('mu luoi trai',50,3);
insert into products (name, price, category_id) values('giay co cao',300,4);
insert into products (name, price, category_id) values('dep con cuu',50,5);

insert into users (name,password,username) values('thai linh','123456','linh66');
insert into users (name,password,username) values('dang manh','123456','manh163');
insert into users (name,password,username) values('dinh toan','123456','toan177');
insert into users (name,password,username) values('bui bao','123456','bao3110');
insert into users (name,password,username) values('nguyen hoa','123456','hoa201');

insert into orders (user_id,ship_address,phone_number) values('1','ha noi','0363353173');
insert into orders (user_id,ship_address,phone_number) values('2','sai gon','0864353373');
insert into orders (user_id,ship_address,phone_number) values('3','nhat ban','0365553973');
insert into orders (user_id,ship_address,phone_number) values('1','sai gon','0368353983');
insert into orders (user_id,ship_address,phone_number) values('4','ha noi','044355173');

insert into order_details (order_id, product_id, price, quantity) values(1,2,600,3);
insert into order_details (order_id, product_id, price, quantity) values(2,5,300,6);
insert into order_details (order_id, product_id, price, quantity) values(3,4,1500,5);
insert into order_details (order_id, product_id, price, quantity) values(4,1,100,1);
insert into order_details (order_id, product_id, price, quantity) values(5,2,400,2);
insert into order_details (order_id, product_id, price, quantity) values(1,5,300,3);
delete from order_details where order_id = 5;

-- Hiển thị danh sách danh mục id,name,status,qty_product (COUNT,JOIN)
SELECT c.*,COUNT(p.id) as qty_product
FROM categories c 
JOIN products p
ON c.id = p.category_id
group by c.id,c.name;
-- Hiển danh sách sản phẩm id, name ,price category_id, category_name (JOIN)
SELECT p.*,c.name as category_name
FROM products p
JOIN categories c 
ON p.category_id = c.id WHERE p.price >100;
-- Hiển thị danh sách đơn hàng id ten_nguoi_mua ship_address phone status totail_price(Tổng tiền của đơn hàng)
SELECT o.*, u.name as user_name, SUM(od.price*od.quantity) as total_price
FROM 
orders o
JOIN 
users u
ON o.user_id = u.id
JOIN order_details od
ON o.id = od.order_id
group by o.id;
-- Hiển thị chi tết đơn hàng của 1 đơn hảng theo id order_id product_name price qty 
SELECT od.order_id,p.name as product_name,od.price,od.quantity,(od.price * od.quantity) as total_price
FROM order_details od 
JOIN products p
ON od.product_id = p.id WHERE od.order_id = 1;


SELECT p.*,c.name as category_name
FROM products p
JOIN categories c 
ON p.category_id = c.id;

-- Tạo view 
create view vw_product_cate
as
SELECT p.*,c.name as category_name
FROM products p
JOIN categories c 
ON p.category_id = c.id;

-- Hiển thị dữ liệu từ view 
SELECT * FROM vw_product_cate;
-- xóa view 
DROP VIEW vw_product_cate;
-- chỉnh sửa view 
alter view vw_product_cate
as 
SELECT p.id as product_id,p.name as product_name,c.name as category_name
FROM products p
JOIN categories c 
ON p.category_id = c.id WHERE p.price >= 100;

-- chỉ mục 
create table blogs(
	id int unique,
    title varchar(100),
    content text,
    status bit(1)
);
DELETE FROM blogs;
INSERT INTO blogs(id,title,content) values (1,'sap tet roi','noi dung');
INSERT INTO blogs(id,title,content) values (3,'tet co ny chua','noi dung');
INSERT INTO blogs(id,title,content) values (2,'luong bao tien','noi dung');
INSERT INTO blogs(id,title,content) values (4,'co thuong tet ko','noi dung');
SELECT * FROM blogs;

-- Đánh chỉ mục 
create index ixd_blogs_name ON blogs(title);
-- xóa chỉ mục 
alter table blogs drop index ixd_blogs_name;
DROP table blogs;
-- đánh chỉ mục unique 
create unique index ixd_blogs_id ON blogs(id);


-- thủ tục không tham sôs
-- tao thu tuc lay ve danh sach danh muc 
DELIMITER //
create procedure GET_ALL_CATEGORY()
BEGIN
	SELECT * FROM categories;
END //
DELIMITER ;
-- thực thi thủ tục call 
call GET_ALL_CATEGORY; 

-- thủ tục có tham số 
DELIMITER //
	create procedure FIN_CATEGORY_BY_ID(IN _id int)
		BEGIN
			SELECT * FROM categories WHERE id = _id;
        END //
DELIMITER ;
DROP procedure FIN_CATEGORY_BY_ID;
-- gọi thủ tục có tham số 
call FIN_CATEGORY_BY_ID(10);

-- thực hiện xây dựng thủ tục thêm mới bản ghi vào bảng category 
DELIMITER //
	create procedure ADD_CATEGORY(IN _name varchar(100), _status bit(1))
		BEGIN
			INSERT INTO categories (name,status) values(_name,_status);
        END //
DELIMITER ;

call ADD_CATEGORY('Thêm',1);
call GET_ALL_CATEGORY();
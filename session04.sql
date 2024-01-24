USE ss03_qlbh;
SELECT * FROM category;
SELECT * FROM product;

-- thuc hien join giua bang product va category 
SELECT p.*,c.name as 'category_name'
FROM product as p
INNER JOIN category as c
ON p.category_id = c.id;

-- LEFT JOIN 
SELECT p.*,c.name as 'category_name'
FROM product as p
LEFT JOIN category as c
ON p.category_id = c.id;

-- RIGHT JOIN 
SELECT p.*,c.name as 'category_name'
FROM product as p
RIGHT JOIN category as c
ON p.category_id = c.id;

-- FULL JOIN 
-- SELECT p.*,c.name as 'category_name',c.status
-- FROM product p
-- cross join category c 
-- WHERE p.category_id = c.id
-- FULL JOIN trong mysql
SELECT * FROM product
LEFT JOIN category ON product.category_id = category.id
UNION
SELECT * FROM product
RIGHT JOIN category ON product.category_id = category.id;

create table categories(
	id int primary key,
    name varchar(100) not null,
    parent_id int 
);
INSERT INTO categories(id,name,parent_id) VALUES (1,'AO',0);
INSERT INTO categories(id,name,parent_id) VALUES (2,'Quan',0);

INSERT INTO categories(id,name,parent_id) VALUES (3,'AO khoac',1);
INSERT INTO categories(id,name,parent_id) VALUES (4,'Ao so mi',1);
INSERT INTO categories(id,name,parent_id) VALUES (5,'Quan kaki',2);
SELECT * FROM categories;

SELECT c1.id,c1.name,c2.name as 'parent_category' 
FROM categories as c1
LEFT JOIN categories as c2 
ON c1.parent_id = c2.id;
SELECT * FROM product;
-- đếm số lượng sản phẩm 
SELECT COUNT(id) FROM product;
-- SUM 
select SUM(price) FROM product;
-- MIN 
SELECT MIN(price) FROM product;
SELECT * FROM product ORDER BY price asc limit 1;
-- GROUP_CONACT()
SELECT group_concat(name) as 'product_name' FROM product;

--
SELECT * FROM category;
SELECT c.id,c.name,c.status,COUNT(p.id) as 'total_product'
FROM category c
JOIN product p
ON c.id = p.category_id
group by c.id,c.name
having c.status = 1

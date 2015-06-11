#新建表格
create table php(
id int primary key auto_increment,
name char(3) not null default " ",
age tinyint unsigned not null default 0,
email varchar(30) not null default " ",
tel char(11) not null default " ",
salary decimal(11) not null default "1800",
riqi date not null default "2012-03-13"
);
#查看表格
desc tablename；


#想表格中插入数据
#往哪里插
insert into php
	#要查哪些值
	(name,age,email,tel,riqi)
	values
	#数值
	("刘备",99,"liubei@qq.com","111111111","2012-12-10");


insert into php
	(name,age,email)
	values
	("张飞",34,"zhangfei@qq.com"),
	("赵云",69,"zhaoyun@qq.com"),
	("黄忠",109,"huangzong@qq.com"),
	("马超",59,"machao@qq.com");


#修改
#修改哪张表
update php
	set
	#修改哪一列
	tel="4000"
	#是哪一行的这个列
	where name="马超";

#删除数据
delete from php
	where id=1;

create table goods(
	goods_id int primary key auto_increment,
	cat_id smallint not null default 0,
	good_sn char(15) not null default " ",
	goods_name varchar(30) not null default " ",
	click_count mediumint unsigned not null default 0,
	brand_id smallint not null default 0,
	market_price decimal(7,2) not null default 0.00,
	shop_price decimal(7,2) not null default 0.00,
	add_time int unsigned not null default 0

);

create table category(
	cat_id smallint primary key auto_increment,
	cat_name varchar(20) not null default " ",
	parent_id smallint not null default 0

);


create table brand_id(
	brand_id smallint primary key auto_increment,
	brand_name varchar(30) not null default " "
);

insert into goods
	select
	goods_id,
	cat_id,
	goods_sn,
	goods_name,
	click_count,
	brand_id,
	market_price,
	shop_price,
	add_time
	from ecshops.ecs_goods;

insert into brand_id
	select
	brand_id,
	brand_name
	from ecshops.ecs_brand;

select goods_id,goods_name from goods where goods_id>20;


select goods_name,market_price,shop_price from goods where market_price-shop_price>200;

#in  在集合里面in(val1,val2,val3,val4....)都行
select goods_name,cat_id from goods where cat_id in (4,5);

#between  表示范围 between val2 and val3
select goods_name,shop_price from goods where shop_price between 2000 and 3000;

#3000-5000 300-500 and or
select goods_name,shop_price from goods where shop_price>=3000 and shop_price<=5000 or shop_price>500 and shop_price<1000

#not
select goods_name cat_id from goods where cat_id<>4 and cat_id<>5;
select goods_name,cat_id from goods where cat_id not in (4,5);

#文档下载
#模糊查询
#%统配任意字符
select goods_name from goods where goods_name like "诺基亚%";
#_匹配单个字符
select goods_name from goods where goods_name like "诺基亚N__";

#group字句
#用于统计
#max min sum avg count

#most p
select max(shop_price) from goods;
select goods_name,max(shop_price) from goods;

#每个栏目下面最贵的商品价格
select cat_id,max(shop_price) from goods group by cat_id;

#最新的商品编号
select max(goods_id) from goods;

select min(shop_price) from goods;
#求总和
select sum(shop_price) from goods;
#求平均
 select avg(shop_price) from goods;

 select count(*) from goods;

select goods_name,market_price-shop_price as cj from goods;
#取别名


#15having对查询结果继续查询
#where只能对表文件查询

select goods_name,market_price-shop_price as cj having cj<200;


select goods_name,cat_id,market_price-shop_price as cj from goods where cat_id=3 having cj>200;

create table fenshu(
	name char(10) not null default " ",
	kemu char(10) not null default " ",
	cj tinyint unsigned not null default 0
);

insert into fenshu
	values
	("张三","数学","90"),
	("张三","语文","50"),
	("张三","地理","40"),
	("李四","语文","55"),
	("李四","政治","45"),
	("王五","政治","30")

select name,kemu,cj from fenshu where cj<60;#查出所有不及格的科目
#统计每个人不及格的科目
#
select goods_name,shop_price,cat_id from goods where cat_id=3;

#order默认正序
select goods_name,shop_price,cat_id from goods where cat_id=3 order by shop_price;
#desc 降序
 select goods_name,cat_id,shop_price from goods where cat_id=3 order by shop_price desc;
#asc 显示声明生序
#指定多个比较指标
 select goods_name,cat_id,shop_price from goods
 where cat_id<>3
 order by
 cat_id,shop_price desc;

 select goods_name,add_time from goods
 order by
 add_time asc;


#limit[offset][N]  在语句最后  限制条目的作用
#offset 偏移量
#取几行
select goods_name,shop_price from goods
order by shop_price desc
limit 3,3;

select goods_name,shop_price,cat_id from shop_price
group by cat_id

#5个字句有先后顺序，where group by having order limit
#子查询
#建立临时表
#truncate g2 清空一张表
select * from (select goods_name,cat_id,shop_price from

#where 子查询
select goods_name,goods_id from goods where goods_id=(select max(goods_id) from goods);
#把内层查询的结果作为外层查询的条件
select cat_id,max(goods_id) from goods group by cat_id;
select goods_name,shop_price,cat_id from goods
where shop_price in (select max(shop_price) from goods group by cat_id);


#from子查询
#把内层的查询结果作为临时表以供查询

select goods_name,goods_id,cat_id from
(select goods_name,goods_id,cat_id from goods order by
cat_id,goods_id desc) as tmp group by goods_id;

select * from (select goods_id,cat_id,goods_name from goods order by cat_id,goods_id desc)
as tmp group by cat_id;
#表必须加别名


#exists查询
#category查有商品的栏目
select cat_id,cat_name from category where exists (select * from goods where goods.cat_id=category.cat_id);















































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

#union 合并插叙结果 列数一致  以第一次列名为列名   重复的自动去掉
select goods_name,shop_price from goods
where shop_price>5000
union
select goods_name,shop_price from goods
where shop_price<20;

#如果字句中有order by 加括号
 (select goods_name,shop_price,cat_id from goods
 where cat_id=4 order by shop_price)
 union
 (select goods_name,shop_price,cat_id from goods
 where cat_id=5 order by shop_price);
#在子句中排序 
 select goods_name,shop_price,cat_id from goods
 where cat_id=4
 union
 select goods_name,shop_price,cat_id from goods
 where cat_id=5 order by shop_price desc;
#limit让排训有效
(select goods_name,shop_price,cat_id from goods where cat_id=3
order by shop_price desc limit 0,3)
union
(select goods_name,shop_price,cat_id from goods where cat_id=4
order by shop_price desc limit 0,2);

#接表 连接条件
#左连接
select
goods_name,goods_id,goods.cat_id,cat_name,shop_price from
goods left join category
on goods.cat_id=category.cat_id;#连接条件
#以左表为基准，没找到用null补气


#右连接
select boy.*,girl.* from
girl right join boy
on girl.flower=boy.flower;


#内连接 查询左右表都有的数据 不要左右连接中null的部分
select boy.*,girl.* from
boy inner join girl
on boy.flower=girl.flower;

select 
* from
goods right join category


select
* from 
goods inner join


create table boy(
	name char(10),
	flower char(10)
);

create table girl(
	name char(10),
	flower char(10)
);

insert into boy
	values
	("Jack","rose"),
	("Kaka","taohua"),
	("Jay","moli"),
	("Messi","hehua"),
	("Zedani","gou");

insert into girl
	values
	("Lucy","rose"),
	("Juli","taohua"),
	("Kassy","moli"),
	("Flora","moli"),
	("Nacy","hehua");
select boy.*,girl.* from
boy left join girl
on
boy.flower=girl.flower;

25






a 5
b 15
c 25
d 30
e 90


#增加列
Alter table 表名字 列声明

Alter table boy add height tinyint unsigned not
null default 0;
#增加咧在表最后
#after可以声明新增列在哪列后面

Alter table boy add age tinyint unsigned not null default 32
after flower;

#加到第一列
Alter table boy add id int primary key auto_increment
first

#修改列
Alter table 表 change 被改变的列明 新的列声明

Alter table boy change height height smallint not null default 180

#删除咧
Alter table 表 drop  列
Alter table boy drop id;

#视图
#由查询结果组成的一张虚拟表
select goods_id,goods_name,cat_id,shop_price from
goods where shop_price>1000;

create view name as select
create view pp as select goods_id,goods_name,cat_id,shop_price from
goods where shop_price>1000;

#试图删除
drop view

#试图权限控制
# 试图修改
#表的数据的改变会影响试图的改变 
#试图不是总能改
#试图的改变会影响表
#试图比训包含表中没有默认值的列

#试图的algonpthm
Alter view 


Merge:当引用试图时，引用试图的语句与定义语句合并

Temltable:建立零时表
create algorithm=Temptable view g3  as select goods_id,goods_name,cat_id,shop_price from goods
order by cat_id asc,shop_price desc;

undefined:自动

客户端－－－转换器－－－服务器
客户端发送数据使用的字符集 set character_set_client=gbk/utf8
转换器转化的字符集 set character_set_connection=gbk/utf8
返回给客户端的字符集 set character_set_results=gbk/utf8

#触发器
#监视三种操作 增删改
#触发操作  增删改
#监视地点  监视时间 触发事件  触发事件
create trigger triggerName
	after/before insert/update/delete on tablename
	begin
	sql
	end;

create trigger tg1 after
insert on o 
for each row
begin
update g set num=num-3 where id=2;
end$
#改变终止符号
delimiter $

#获取新增行
#用new表示新行



#删除触发器的语法
drop trigger trigger tg1

create trigger tg2
	after insert on o
	for each row
	begin
	update g set num=num-new.much where id=new.gid;
	end$

create trigger tg3
	after delete on o
	for each row
	begin
	update g set num=num+old.much where id=old.gid;
	end$

create trigger tg4
	after update on o
	for each row
	begin
	update g set num=num+old.much-new.much where id=new.gid; 
	end$


create trigger tg5 
	before insert on o
	for each row
	begin
	if new.much>5 then 
	set new.much=5; 
	end if;
    update g set num=num-new.much where id=new.gid;
	end$


#存储引擎
myisam 批量插入熟读快  不支持事务，锁表
 innoDB 批量插入速度慢  支持事务 锁行 支持全文索引


create table account(
	id int,
	name varchar(10),
	money int
)engine=innodb;


#开启事务
start transaction;

#事务完毕
commit or rollback

#导出表
mysqldump -uroot -proot database  table > ''
mysqldump -uroot -proot database -B mugua>

#还原数据库
#恢复以库为单位
source Documents/dumo/ks.sql;
#表恢复
#在库状态下执行上述语句
#不登入mysql
#库
mysql -uroot -proot < Documents/dump/ks.sql;
#表
mysql -uroot -proot ks< Documents/dump/fenshu.sql;


#普通索引 加快查询速度
#唯一索引 行上的值不能重复
#主键索引 主键不能重复
#全文索引
#查看一张表格的索引
show index from biao;

#建立索引
alter table biao add index/unique/primarykey/fulltext index(column)

#删除索引
alter table drop index 索引名
#全文索引的用法

match (index) against (keyword);






#ecshop goods_id  cat_id cat_name brand_id
#brand_name goods_name
select goods.goods_name,goods.goods_id,goods.cat_id,category.cat_name,goods.brand_id from
goods left join category
on
goods.cat_id=category.cat_id;


select tmp.goods_name,tmp.goods_id,tmp.cat_id,tmp.cat_name,tmp.brand_id,brand_id.brand_name
from
(select goods.goods_name,goods.goods_id,goods.cat_id,category.cat_name,goods.brand_id from
goods left join category
on
goods.cat_id=category.cat_id) as tmp left join brand_id
on
tmp.brand_id=brand_id.brand_id;

create table Mtch(#match关键字不能做表格名称
	matchID int primary key auto_increment,
	hostTeamID int not null default 0,
	guestTesmID int not null default 0,
	matchResult varchar(20) not null default " ",
	matchTime int not null default 0
);
insert into Mtch
	(hostTeamID,guestTesmID,matchResult,matchTime)
	values
	(2,3,"2:0",2222),
	(2,4,"3:1",2222),
	(3,1,"4:2",2222);
insert into Team
	values
	(1,"拜仁"),
	(2,"多特蒙德"),
	(3,"沙尔克04"),
	(4,"门兴");

create table match(
	hostTeamID int not null default 0,
	guestTesmID int not null default 0,
	matchResult varchar(20) not null default " ",
	matchTime int not null default 0
);

create table Match(
	matchID int primary key auto_increment

);



select hostTeamID,matchResult,guestTesmID,matchTime from Mtch;

select Team.teamName,tmp1.matchResult,tmp1.guestTesmID,tmp1.matchTime from
(select hostTeamID,matchResult,guestTesmID,matchTime from Mtch) as tmp1
left join Team
on tmp1.hostTeamID=Team.teamID;

select tmp2.teamName,tmp2.matchResult,Team.teamName,tmp2.matchTime from
(select Team.teamName,tmp1.matchResult,tmp1.guestTesmID,tmp1.matchTime from
(select hostTeamID,matchResult,guestTesmID,matchTime from Mtch) as tmp1
left join Team
on tmp1.hostTeamID=Team.teamID) as tmp2
left join Team
on tmp2.guestTesmID=Team.teamID;


select avg(shop_price) as pj,cat_id from goods group by cat_id


create view bavg as select avg(shop_price) as pj,cat_id from goods group by cat_id

create view g3 as select goods_id,goods_name,cat_id,shop_price from goods
 order by cat_id asc,shop_price desc;

create algorithm=Temptable view g3  as select goods_id,goods_name,cat_id,shop_price from goods
 order by cat_id asc,shop_price desc;

create table g(
	id int,
	name varchar(10),
	num int
);

create table o(
	oid int,
	gid int,
	much int
);

insert into g
	values
	(1,"猪",22),
	(2,"羊",19),
	(3,"狗",12),
	(4,"猫",8);

insert into o
	values
	(1,2,3);

#导出数据 mysqldump
mysqldump -uroot -proot mugua account > Documents/dump/account.sql;
#导出多张表
mysqldump -uroot -proot mugua account goods > Documents/dump/goodaacc.sql;
#导出一个库下面所有的表
mysqldump -uroot -proot mugua > Documents/mugua.sql;
#导出一个库
mysqldump -uroot -proot -B mugua > Documents/dump/mugua.sql;
#导出所有苦
mysqldump uroot -proot -A > Documents/dump/all.sql;

#读取sql文件


create table member(
	id int,
	email varchar(30),
	tel char(11),
	intro text
)engine myisam;

alter table member add index tel (tel);
alter table member add unique (email);
alter table member add fulltext (intro);
alter table member add primary key (id);

alter table member drop index intro;
alter table member drop index email;

select * from member where match(intro) against ("china");

#产看存储古
show procedure status;

#删除存储过程
Drop procedure name;

# 写存储过程

create procedure p1() begin
	select * from g;
end$

#调用
call pi();

create procedure p3(n int,j char(1))
	begin
	if j="h" then select * from g where num>n;
	else
	select * from g where num<n;
	end if;
	end$


















#
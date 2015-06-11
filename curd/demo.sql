create table msg(id int,title varchar(60),name varchar(10),content varchar(1000));
	insert into msg(id,title,name,content)
		values("1","初来乍到","张三","刚来不能当老大");

	update msg
		set id=2,
		content="偏要当老大"
		where
		name="李四";
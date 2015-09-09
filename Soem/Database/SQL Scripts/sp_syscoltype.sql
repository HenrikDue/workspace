USE [mdw]
GO
/****** Object:  StoredProcedure [dbo].[syscoltype]    Script Date: 09-09-2015 09:57:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[syscoltype] @tablename varchar(255),  @prefix varchar(255) = '', @postfix varchar(255) = ','
as 
begin
	select 
		case @prefix when '' then '' else @prefix+'.' end +c.name+@postfix as colname, 
		t.name as typename, 
		c.length, 
		t.collation  
	from 
		syscolumns c 
			inner join 
		systypes t on c.xtype = t.xtype 
	where 
		c.id = object_id(@tablename)
    order by colorder
end
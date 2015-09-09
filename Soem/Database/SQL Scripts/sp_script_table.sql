USE [mdw]
GO
/****** Object:  StoredProcedure [dbo].[script_table]    Script Date: 09-09-2015 09:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[script_table] 
	@tablename sysname, 
	@drop bit = 0

as
BEGIN

set nocount on
declare @mdwtabelnavn sysname
declare @kolonnetekst varchar(8000)
declare @praefix sysname
set @mdwtabelnavn =  @tablename
declare kolonner cursor  read_only for
select
	'['+ a.name+']'+' '
	+(select case name
			when 'nvarchar' then 'varchar'
			when 'nchar' then 'char'
			when 'ntext' then 'text'
			else name
			end				
 from systypes b where a.xtype = b.xtype and a.xusertype = b.xusertype)
	+ case (select name from systypes b where a.xtype = b.xtype and a.xusertype = b.xusertype)
		when 'varchar' then '('+convert(varchar, a.prec)+')'
		when 'nvarchar' then '('+convert(varchar, a.prec)+')'
		when 'char' then '('+convert(varchar,a.prec)+')'
		when 'nchar' then '('+convert(varchar,a.prec)+')'

		else ''
	end
	+' NULL'
	+
	case colid
		when (select max(colid) from syscolumns  a where id = object_id(@tablename)) then ''
		else ','
	end  as Attributter
from
	syscolumns  a
where
	id = (object_id(@tablename))
order by
	colid

if @drop = 1 begin
	PRINT 'IF object_id('''+@mdwtabelnavn+''') is not null'
	print 'DROP TABLE '+ @mdwtabelnavn
end
	print 'GO '
	print 'CREATE TABLE ' + @mdwtabelnavn + '('

open  kolonner
fetch next from kolonner into @kolonnetekst
while @@fetch_status <> -1
begin
	print 	'	'+@kolonnetekst
	fetch next from kolonner into @kolonnetekst
end
deallocate kolonner

print ')'

Print 'Go'
END

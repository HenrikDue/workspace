USE [mdw]
GO
/****** Object:  StoredProcedure [dbo].[script_select]    Script Date: 09-09-2015 09:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[script_select] @tablename sysname, @alias sysname =null, @vistyper bit = 0
as
begin

	declare @colname sysname
	declare @colorder int
	declare @colordermax int
	declare @typename sysname 
	declare @length int
	declare @collation sysname
	declare @maxcolname int
	declare @maxcoltypename int

	select @colordermax = max(colorder) from syscolumns c where id = object_id(@tablename) 
	select @maxcolname = 2+max(len(c.name)) from syscolumns c  where id = object_id(@tablename)
	select @maxcoltypename = 1+max(len(t.name)) from syscolumns c inner join systypes t on c.xtype = t.xusertype where id = object_id(@tablename)
	
		
	declare col cursor  scroll for
		select c.name, c.colorder, t.name as typename, c.prec, t.collation  
		from syscolumns c 
			inner join 
		systypes t on c.xtype = t.xusertype 

		where id = object_id(@tablename) order by colorder
		
	
	open col

	print 'SELECT '

	fetch first from col into @colname, @colorder, @typename, @length, @collation 

	while @@fetch_status = 0
	begin
		print '	' + isnull(quotename(@alias,'[')+'.','')+quotename(@colname,'[') + case when @colorder = @colordermax then ' ' else ',' end
				+case @vistyper when 1 then replicate(' ',@maxcolname-len(@colname)) + '--  ' +@typename+','+replicate(' ',@maxcoltypename-len(@typename))+ isnull(case @length when -1 then convert(varchar(10),'MAX') else convert(varchar(10),@length)end,'')+',	'+isnull(@collation,'') else '' end
		fetch next from col into @colname, @colorder, @typename, @length, @collation 
	end
	close col
	deallocate col

	print 'FROM'
	Print '	' + @tablename + isnull(' as '+quotename(@alias,'['),'')

end


USE [mdw]
GO
/****** Object:  StoredProcedure [dbo].[find]    Script Date: 09-09-2015 09:54:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[find] @tekst varchar(8000), @tabel sysname = '', @schema sysname = ''
as 
begin
select @tekst = '%'+@tekst+'%'
if object_id ('tempdb..#temptabeller') is not null drop table #temptabeller
select quotename(s.name,']')+'.'+quotename(o.name,']') as tabel--'*** Tabeller der er søgt i ***'
into #temptabeller 
from	sys.sysobjects o 
			inner join 
		sys.schemas s 
		on o.uid = s.schema_id
where o.name like '%' +@tabel+'%' and xtype in ('U', 'V') and s.name = @schema 

	

declare  tabeller cursor fast_forward for 
select  
	 tabel
from	
		#temptabeller
		
		
open tabeller
declare @CurrentTabel sysname
declare @sql varchar(max)

fetch next from tabeller into @CurrentTabel 

while @@fetch_status = 0
begin
	set @sql = 'select '''+@currentTabel + ''' as [*** Fundet i tabel ***], * into #temp from '+@currentTabel + ' with (nolock) where 1=0 '
	select @sql = @sql + ' or ' +quotename(name,']') + ' like ' + quotename (@tekst,'''')  
	from sys.syscolumns where id = object_id(@currentTabel)
	set @sql = @sql + ';if @@rowcount > 0 select * from #temp' 
	print @sql
	exec (@sql) 
	fetch next from tabeller into @CurrentTabel 
end

close tabeller
deallocate tabeller

select tabel as ' *** Tabeller der blev søgt i ***' from #temptabeller


end


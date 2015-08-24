
CREATE proc [dbo].[script_insert] @tablename sysname
as
begin

declare col cursor  scroll for

select c.name from syscolumns c where id = object_id(@tablename) order by colorder
declare @colname sysname
Print 'Insert into ' + @tablename + ' ('
open col
fetch next from col into @colname
while @@fetch_status = 0
begin
	print '	'+quotename(@colname,'[') + ','
	fetch next from col into @colname
end
print ')'
print 'SELECT '

fetch first from col into @colname
while @@fetch_status = 0
begin
	print ' ' + quotename(@colname,'[')  + ',   ---' + @colname
	fetch next from col into @colname
end
close col
deallocate col

print 'From'
end
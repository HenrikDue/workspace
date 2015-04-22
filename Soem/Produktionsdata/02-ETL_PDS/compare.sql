/*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
SELECT  *  
FROM  mdw_udv1.
[edw].[FT_OBSOpgaver]where di_tid between 20150301 and 20150331
--with cube
go

:CONNECT mssqlp01\alpha
SELECT *
FROM mdw.
[edw].[FT_OBSOpgaver]
--where year([Tidsstempel])=2015 and month([Tidsstempel])=4
--where fk_di_tid='201502' -- and status='Oprindelig'
--group by AT_Togkategori
--with cube
go



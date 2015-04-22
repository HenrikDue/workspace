/*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
SELECT  
--*
count(*)
--count(*),sum(varighed_tim)  
FROM  mdw_udv1.
--[edw].[FT_OBSOpgaver]
--[edw].[FT_OBSArbejder]
[edw].[FT_OBSFravaer]
where di_tid between 20150301 and 20150331
--with cube
go

:CONNECT mssqlp01\alpha
SELECT 
--*
count(*)
--count(*),sum(varighed_tim)  
FROM mdw.
--[edw].[FT_OBSOpgaver]
--[edw].[FT_OBSArbejder]
[edw].[FT_OBSFravaer]
where di_tid between 20150301 and 20150331
--with cube
go



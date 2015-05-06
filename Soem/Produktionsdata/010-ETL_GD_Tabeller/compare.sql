 /*
dbo.GD_R_Baneafgifter_FR


 */
 /*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
--truncate table [MDW_udv1].edw.di_s_station_straekning 
--go
SELECT 
--*
count(*)--,sum([Litrakm]),sum([Pladskm])  
FROM  mdw_udv1.

--where [DI_Tid] between '20150301' and '20150331'
--with cube
go

:CONNECT mssqlp01\alpha
SELECT
--*
count(*)--,sum([Litrakm]),sum([Pladskm])
FROM mdw.
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go
 /*
dbo.GD_R_Baneafgifter_FR
dbo.GD_R_Togførertid_FR
dbo.GD_R_Lokoførertid_FR
dbo.GD_R_LønsumAnsættelsetype
[dbo].[GD_R_Lokoførertid_STog]

 */
 /*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
--truncate table [MDW_udv1].edw.di_s_station_straekning 
--go
SELECT 
--*
count(*)--,sum([Litrakm]),sum([Pladskm])  
FROM  mdw_udv1.
--dbo.GD_R_Baneafgifter_FR
--dbo.GD_R_Togførertid_FR
--dbo.GD_R_Lokoførertid_FR
--dbo.GD_R_LønsumAnsættelsetype
[dbo].[GD_R_Lokoførertid_STog]
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go

:CONNECT mssqlt01\alpha
SELECT
--*
count(*)--,sum([Litrakm]),sum([Pladskm])
FROM poemaktuel.
--dbo.GD_R_Baneafgifter_FR
--dbo.GD_R_Togførertid_FR
--dbo.GD_R_Lokoførertid_FR
--dbo.GD_R_LønsumAnsættelsetype
[dbo].[GD_R_Lokoførertid_STog]
where [PeriodeIndlæst]='201503'
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go
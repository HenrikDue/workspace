 /*
dbo.GD_R_Baneafgifter_FR
dbo.GD_R_Togf�rertid_FR
dbo.GD_R_Lokof�rertid_FR
dbo.GD_R_L�nsumAns�ttelsetype
[dbo].[GD_R_Lokof�rertid_STog]
dbo.GD_R_Personaledata

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
--dbo.GD_R_Togf�rertid_FR
--dbo.GD_R_Lokof�rertid_FR
--dbo.GD_R_L�nsumAns�ttelsetype
--[dbo].[GD_R_Lokof�rertid_STog]
dbo.GD_R_Personaledata
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go

:CONNECT mssqlt01\alpha
SELECT
--*
count(*)--,sum([Litrakm]),sum([Pladskm])
FROM poemaktuel.
--dbo.GD_R_Baneafgifter_FR
--dbo.GD_R_Togf�rertid_FR
--dbo.GD_R_Lokof�rertid_FR
--dbo.GD_R_L�nsumAns�ttelsetype
--[dbo].[GD_R_Lokof�rertid_STog]
dbo.GD_R_Personaledata
where [PeriodeIndl�st]='201503'
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go
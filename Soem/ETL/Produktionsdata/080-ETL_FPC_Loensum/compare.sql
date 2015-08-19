 /*
[ods].[RD_FPC_L�nsum]
[ods].[RD_RIM_Rejseindtaegter_togsystemer]
etl.RD_RIM_Rejseindtaegter_togsystemer_beregn_for_loadperiode
[ods].[RD_RIM_Rejseindtaegter]
etl.RD_RIM_Rejseindtaegter_beregn_for_loadperiode


 */
 /*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
--truncate table [MDW_udv1].edw.di_s_station_straekning 
--go
SELECT 
--*
count(*)--,sum([Litrakm]),sum([Pladskm])  
FROM  mdw_udv1.
--ods.rd_stog_korelobtider
--ods.md_stog_stationer
--ods.rd_stog_Straekninger
--edw.di_s_station_straekning
--edw.DI_S_Materiel
--ods.MD_Stog_finger_straekninger
--edw.DI_S_Straekning
--edw.FT_Togproduktion_S_Tog_Litra
[ods].[RD_RIM_Rejseindtaegter_togsystemer]

--where [DI_Tid] between '20150301' and '20150331'
--with cube
go

:CONNECT mssqlp01\alpha
SELECT
--*
count(*)--,sum([Litrakm]),sum([Pladskm])
FROM mdw.
--ods.rd_stog_korelobtider
--ods.md_stog_stationer
--ods.rd_stog_Straekninger
--edw.di_s_station_straekning
--edw.DI_S_Materiel
--ods.MD_Stog_finger_straekninger
--edw.DI_S_Straekning
--edw.FT_Togproduktion_S_Tog_Litra
[ods].[RD_RIM_Rejseindtaegter_togsystemer]
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go
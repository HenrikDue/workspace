 /*
 ods.rd_stog_korelobtider OK
 ods.md_stog_stationer
 ods.rd_stog_Straekninger
 edw.di_s_station_straekning
 edw.DI_S_Materiel
 ods.MD_Stog_litra_typer
edw.DI_S_Straekning
 ods.MD_Stog_finger_straekninger
edw.DI_S_Doegn_Inddeling


 */
 /*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
--truncate table [MDW_udv1].edw.di_s_station_straekning 
--go
SELECT 
--*
count(*)  
FROM  mdw_udv1.
--ods.rd_stog_korelobtider
--ods.md_stog_stationer
--ods.rd_stog_Straekninger
--edw.di_s_station_straekning
--edw.DI_S_Materiel
--ods.MD_Stog_finger_straekninger
edw.DI_S_Straekning
--with cube
go

:CONNECT mssqlp01\alpha
SELECT
--*
count(*) 
FROM mdw.
--ods.rd_stog_korelobtider
--ods.md_stog_stationer
--ods.rd_stog_Straekninger
--edw.di_s_station_straekning
--edw.DI_S_Materiel
--ods.MD_Stog_finger_straekninger
edw.DI_S_Straekning
--with cube
go
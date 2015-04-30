 /*
 ods.rd_stog_korelobtider OK

 ods.md_stog_stationer

 ods.rd_stog_Straekninger



 */
 /*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
SELECT 
--*
count(*)  
FROM  mdw_udv1.
--ods.rd_stog_korelobtider
--ods.md_stog_stationer
ods.rd_stog_Straekninger
--with cube
go

:CONNECT mssqlp01\alpha
SELECT
--*
count(*) 
FROM mdw.
--ods.rd_stog_korelobtider
--ods.md_stog_stationer
ods.rd_stog_Straekninger
--with cube
go
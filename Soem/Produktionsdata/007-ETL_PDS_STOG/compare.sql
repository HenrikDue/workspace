 /*
[ods].[RD_PDS_Lokof�rer_STOG]
ods.TD_Str�kning_Mapping
[etl].[ods_TD_Str�kning_Mapping_Standsninger]
[ods].[TD_Str�kning_S_Lokof�rer_Opgaver]
edw.DI_S_Opgave_Straekning


 */
 /*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
--truncate table [MDW_udv1].[ods].[RD_PDS_Lokof�rer_STOG] 
--go
SELECT 
--*
count(*)
--count(*),sum([Litrakm]),sum([Pladskm])  
FROM  mdw_udv1.
--[ods].[RD_PDS_Lokof�rer_STOG]
--[ods].[TD_Str�kning_Mapping]
--[ods].[TD_Str�kning_S_Lokof�rer_Opgaver]
edw.DI_S_Opgave_Straekning
--where E_DAY_DATE BETWEEN DATEADD(day, -1, '2015-03-01' ) AND DATEADD(month, 1, '2015-03-01')
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go

:CONNECT mssqlp01\alpha
SELECT
--*
count(*)
--count(*),sum([Litrakm]),sum([Pladskm])
FROM mdw.
--[ods].[RD_PDS_Lokof�rer_STOG]
--[ods].[TD_Str�kning_Mapping]
--[ods].[TD_Str�kning_S_Lokof�rer_Opgaver]
edw.DI_S_Opgave_Straekning
--where E_DAY_DATE BETWEEN DATEADD(day, -1, '2015-03-01' ) AND DATEADD(month, 1, '2015-03-01')
--where [DI_Tid] between '20150301' and '20150331'
--with cube
go
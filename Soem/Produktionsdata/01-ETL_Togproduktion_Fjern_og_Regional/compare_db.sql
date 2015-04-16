/*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT mssqlt01\alpha
SELECT
--*
--count(*),sum(antaltog) /*Broafgifter*/
--count(*),sum(antaltog_udenafgift) /*Strkafgifter*/
count(*),sum(antal),sum(afgift_kr) /*Togproduktion_Afgifter*/ 
FROM  mdw_test.
[edw].[FT_Togproduktion_Afgifter]
--[ods].[RDP_Strkafgifter]
--[ods].[RDH_Strkafgifter]
--[ods].[RD_Strkafgifter]
--[ods].[RDH_Broafgifter]
--[ods].[RD_Broafgifter]
--[ods].[RDP_Broafgifter]
--[ods].[RDP_Baneafgifter]

--where maaned='201503' /*Broafgifter Strkafgifter  */
where fk_di_tid='201503' and [status]='oprindelig'/*Togproduktion_Afgifter*/
--group by AT_Togkategori
--with cube
go

:CONNECT mssqlp01\alpha
SELECT 
*
--count(*),sum(antaltog) /*Broafgifter*/
--count(*),sum(antaltog_udenafgift) /*Strkafgifter*/
--count(*),sum(antal),sum(afgift_kr) /*Togproduktion_Afgifter*/
FROM [mssqlp01\alpha].mdw.
[edw].[FT_Togproduktion_Afgifter] /*diff*/
--[ods].[RDP_Strkafgifter]
--[ods].[RDH_Strkafgifter]
--[ods].[RD_Strkafgifter]
--[ods].[RDH_Broafgifter]
--[ods].[RD_Broafgifter]
--[ods].[RDP_Broafgifter]
--[ods].[RDP_Baneafgifter]

--where maaned='201503' /*Broafgifter Strkafgifter  */
where fk_di_tid='201503'-- and [status]='oprindelig'/*Togproduktion_Afgifter*/
--group by AT_Togkategori
--with cube
go


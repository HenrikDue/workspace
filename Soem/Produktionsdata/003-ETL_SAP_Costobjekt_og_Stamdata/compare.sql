/*afvikles i SQLCMD mode. Query - SQLCMD*/

:CONNECT oesmsqlt01\soem
SELECT  
--*  
count(*)
FROM  mdw_udv1.
[edw].[DI_CostObject]
--with cube
go

:CONNECT mssqlp01\alpha
SELECT 
--*  
count(*)
FROM  mdw.
[edw].[DI_CostObject]
--with cube
go

--syntax linked server
--EXEC sp_addlinkedsrvlogin 'Servername', 'false', NULL, 'username', 'password@123'



:CONNECT oesmsqlt01\soem
SELECT  
--*
count(*)  
FROM  mdw_udv1.
edw.ft_fte
where di_tid_maaned='201503'
go

:CONNECT mssqlp01\alpha
SELECT 
--*
count(*)
FROM  mdw.
edw.ft_fte
where di_tid_maaned='201503'

go



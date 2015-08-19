USE [MDW_test02]

EXEC sp_spaceused 

DECLARE @Compressiontype VARCHAR(5)
SET @Compressiontype = 'PAGE' -- Value should be NONE or ROW or PAGE
SELECT 'ALTER TABLE [' + SCHEMA_NAME (schema_id)+'].['+ name 
+ '] REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = '+ @Compressiontype + ')'  FROM sys.tables order by SCHEMA_NAME (schema_id),name 
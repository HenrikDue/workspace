USE [MDW_UDV3]
GO

DECLARE	@return_value int

EXEC	@return_value = [etl].[CreateSASABMTables]
		@model = N'M9999',
		--@tableName = N'DimMember',
		@tableName = N'Costelement',
		@database = N'SASABMMODELS_UDV3'

SELECT	'Return Value' = @return_value

GO

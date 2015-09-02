CREATE VIEW [dbo].[vwABM_DimensionMember]
AS
SELECT     TOP 100 PERCENT dbo.ABM_DimensionMember.*, RIGHT(dbo.ABM_DimensionMember.Reference, LEN(dbo.ABM_DimensionMember.Reference) 
                      - CHARINDEX('_', dbo.ABM_DimensionMember.Reference)) AS SortCol
FROM         dbo.ABM_DimensionMember 
ORDER BY dbo.ABM_DimensionMember.DimLevel, dbo.ABM_DimensionMember.DimRef, RIGHT(dbo.ABM_DimensionMember.Reference, 
                      LEN(dbo.ABM_DimensionMember.Reference) - CHARINDEX('_', dbo.ABM_DimensionMember.Reference))
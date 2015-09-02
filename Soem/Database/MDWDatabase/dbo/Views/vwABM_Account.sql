CREATE VIEW [dbo].[vwABM_Account]
AS
SELECT     TOP 100 PERCENT dbo.ABM_Account.*, CASE WHEN dbo.ABM_Account.ModuleType = 'Activity' THEN RIGHT(dbo.ABM_Account.Reference, 
                      LEN(dbo.ABM_Account.Reference) - CHARINDEX('_', dbo.ABM_Account.Reference)) ELSE dbo.ABM_Account.Reference END AS SortCol
FROM         dbo.ABM_Account 
ORDER BY (CASE WHEN dbo.ABM_Account.ModuleType = 'Activity' THEN RIGHT(dbo.ABM_Account.Reference, LEN(dbo.ABM_Account.Reference) 
                      - CHARINDEX('_', dbo.ABM_Account.Reference)) ELSE dbo.ABM_Account.Reference END)
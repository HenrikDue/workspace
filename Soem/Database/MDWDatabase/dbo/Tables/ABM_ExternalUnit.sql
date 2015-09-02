CREATE TABLE [dbo].[ABM_ExternalUnit] (
    [Delmodel]     NVARCHAR (64) NOT NULL,
    [ModelID]      SMALLINT      NULL,
    [ModelName]    NVARCHAR (64) NOT NULL,
    [PeriodID]     SMALLINT      NULL,
    [Period]       NVARCHAR (64) NOT NULL,
    [ScenarioID]   SMALLINT      NULL,
    [Scenario]     NVARCHAR (64) NOT NULL,
    [ExtUnitID]    SMALLINT      NOT NULL,
    [DimSigniture] NVARCHAR (64) NULL,
    [Reference]    NVARCHAR (64) NOT NULL,
    [NewReference] NVARCHAR (64) NULL,
    [Name]         NVARCHAR (64) NOT NULL,
    CONSTRAINT [PK_ExternalUnit] PRIMARY KEY CLUSTERED ([Delmodel] ASC, [ModelName] ASC, [Period] ASC, [Scenario] ASC, [ExtUnitID] ASC, [Reference] ASC, [Name] ASC) WITH (FILLFACTOR = 90)
);


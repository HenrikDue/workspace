CREATE TABLE [dbo].[ABM_DimensionLevel] (
    [Delmodel]  NVARCHAR (64) NOT NULL,
    [ModelID]   SMALLINT      NULL,
    [ModelName] NVARCHAR (64) NULL,
    [DimID]     SMALLINT      NULL,
    [DimRef]    NVARCHAR (64) NOT NULL,
    [LevelNo]   SMALLINT      NOT NULL,
    [Name]      NVARCHAR (64) NOT NULL
);


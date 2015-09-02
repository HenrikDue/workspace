CREATE TABLE [ods].[td_SASABMMODELSDYN_PeriodDefinition] (
    [Id]          SMALLINT       NOT NULL,
    [Name]        NVARCHAR (64)  NULL,
    [ParentId]    SMALLINT       NULL,
    [LevelId]     SMALLINT       NULL,
    [StartDate]   SMALLDATETIME  NULL,
    [EndDate]     SMALLDATETIME  NULL,
    [Description] NTEXT          NULL,
    [Refnum]      NVARCHAR (256) NULL
);


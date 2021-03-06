﻿CREATE TABLE [dbo].[ABM_KEY_DimensionAttributeAssoc] (
    [Delmodel]               NVARCHAR (64) NOT NULL,
    [ModelID]                SMALLINT      NULL,
    [ModelName]              NVARCHAR (64) NULL,
    [PeriodID]               SMALLINT      NULL,
    [Period]                 NVARCHAR (64) NOT NULL,
    [ScenarioID]             SMALLINT      NULL,
    [Scenario]               NVARCHAR (64) NOT NULL,
    [ItemModuleType]         NVARCHAR (64) NOT NULL,
    [ItemID]                 SMALLINT      NULL,
    [ItemDummyRef]           NVARCHAR (64) NOT NULL,
    [ItemReference]          NVARCHAR (64) NULL,
    [ItemDimSigniture]       NVARCHAR (64) NULL,
    [AttributeDimID]         SMALLINT      NULL,
    [AttributeDimRef]        NVARCHAR (64) NOT NULL,
    [AttributeDimName]       NVARCHAR (64) NULL,
    [AttributeDimMemberID]   SMALLINT      NULL,
    [AttributeDimMemberRef]  NVARCHAR (64) NULL,
    [AttributeDimMemberName] NVARCHAR (64) NULL,
    [ItemDimRef1]            NVARCHAR (64) NULL,
    [ItemDimMemberRef1]      NVARCHAR (64) NULL,
    [ItemDimRef2]            NVARCHAR (64) NULL,
    [ItemDimMemberRef2]      NVARCHAR (64) NULL,
    [ItemDimRef3]            NVARCHAR (64) NULL,
    [ItemDimMemberRef3]      NVARCHAR (64) NULL,
    [ItemDimRef4]            NVARCHAR (64) NULL,
    [ItemDimMemberRef4]      NVARCHAR (64) NULL,
    [ItemDimRef5]            NVARCHAR (64) NULL,
    [ItemDimMemberRef5]      NVARCHAR (64) NULL,
    CONSTRAINT [PK_ABM_KEY_DimensionAttributeAssoc] PRIMARY KEY CLUSTERED ([Delmodel] ASC, [Period] ASC, [Scenario] ASC, [ItemModuleType] ASC, [ItemDummyRef] ASC, [AttributeDimRef] ASC) WITH (FILLFACTOR = 90, DATA_COMPRESSION = PAGE)
);




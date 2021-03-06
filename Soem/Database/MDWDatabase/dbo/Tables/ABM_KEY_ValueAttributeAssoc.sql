﻿CREATE TABLE [dbo].[ABM_KEY_ValueAttributeAssoc] (
    [Delmodel]           NVARCHAR (64)  NOT NULL,
    [ModelID]            SMALLINT       NULL,
    [ModelName]          NVARCHAR (64)  NULL,
    [PeriodID]           SMALLINT       NULL,
    [Period]             NVARCHAR (64)  NOT NULL,
    [ScenarioID]         SMALLINT       NULL,
    [Scenario]           NVARCHAR (64)  NOT NULL,
    [ItemModuleType]     NVARCHAR (64)  NOT NULL,
    [ItemID]             SMALLINT       NULL,
    [ItemReference]      NVARCHAR (64)  NOT NULL,
    [AttributeReference] NVARCHAR (64)  NOT NULL,
    [Value]              NVARCHAR (255) NULL,
    [ItemDimRef1]        NVARCHAR (64)  NOT NULL,
    [ItemDimMemberRef1]  NVARCHAR (64)  NOT NULL,
    [ItemDimRef2]        NVARCHAR (64)  NULL,
    [ItemDimMemberRef2]  NVARCHAR (64)  NULL,
    [ItemDimRef3]        NVARCHAR (64)  NULL,
    [ItemDimMemberRef3]  NVARCHAR (64)  NULL,
    [ItemDimRef4]        NVARCHAR (64)  NULL,
    [ItemDimMemberRef4]  NVARCHAR (64)  NULL,
    [ItemDimRef5]        NVARCHAR (64)  NULL,
    [ItemDimMemberRef5]  NVARCHAR (64)  NULL,
    CONSTRAINT [PK_ABM_KEY_ValueAttributeAssoc] PRIMARY KEY CLUSTERED ([Delmodel] ASC, [Period] ASC, [Scenario] ASC, [AttributeReference] ASC, [ItemDimRef1] ASC, [ItemDimMemberRef1] ASC) WITH (FILLFACTOR = 90, DATA_COMPRESSION = PAGE)
);




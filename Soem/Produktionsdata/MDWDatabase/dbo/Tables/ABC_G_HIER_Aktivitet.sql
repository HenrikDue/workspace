﻿CREATE TABLE [dbo].[ABC_G_HIER_Aktivitet] (
    [Comments]        VARCHAR (255) NULL,
    [DocRef]          VARCHAR (50)  NULL,
    [Reference]       VARCHAR (50)  NOT NULL,
    [ModuleType]      VARCHAR (50)  NOT NULL,
    [Name]            VARCHAR (50)  NULL,
    [ParentReference] VARCHAR (50)  NULL,
    [Periode]         VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_ABC_G_HIER_Activity] PRIMARY KEY CLUSTERED ([Reference] ASC, [ModuleType] ASC, [Periode] ASC) WITH (DATA_COMPRESSION = PAGE)
);




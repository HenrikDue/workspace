﻿CREATE TABLE [dbo].[ABM_Account] (
    [Delmodel]         NVARCHAR (MAX) NOT NULL,
    [ModuleType]       NVARCHAR (64)  NOT NULL,
    [Period]           NVARCHAR (64)  NOT NULL,
    [Scenario]         NVARCHAR (64)  NOT NULL,
    [Reference]        NVARCHAR (64)  NOT NULL,
    [DriverName]       NVARCHAR (64)  NULL,
    [Name]             NVARCHAR (64)  NOT NULL,
    [OutputQuantityUE] FLOAT (53)     NULL,
    [PeriodicNote]     NTEXT          NULL,
    [Revenue]          FLOAT (53)     NULL,
    [SoldQuantity]     FLOAT (53)     NULL,
    [TDQUE]            FLOAT (53)     NULL,
    [UnitOfMeasure]    NVARCHAR (64)  NULL,
    [DimRef1]          NVARCHAR (64)  NULL,
    [DimMemberRef1]    NVARCHAR (64)  NULL,
    [DimRef2]          NVARCHAR (64)  NULL,
    [DimMemberRef2]    NVARCHAR (64)  NULL,
    [DimRef3]          NVARCHAR (64)  NULL,
    [DimMemberRef3]    NVARCHAR (64)  NULL,
    [DimRef4]          NVARCHAR (64)  NULL,
    [DimMemberRef4]    NVARCHAR (64)  NULL,
    [DimRef5]          NVARCHAR (64)  NULL,
    [DimMemberRef5]    NVARCHAR (64)  NULL
)
WITH (DATA_COMPRESSION = PAGE);




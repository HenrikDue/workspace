﻿CREATE TABLE [dbo].[ABM_Assignment] (
    [Delmodel]                 VARCHAR (64) NOT NULL,
    [Period]                   VARCHAR (64) NOT NULL,
    [Scenario]                 VARCHAR (64) NOT NULL,
    [SourceModuleType]         VARCHAR (64) NULL,
    [SourceReference]          VARCHAR (64) NOT NULL,
    [DestinationModuleType]    VARCHAR (64) NULL,
    [DestinationReference]     VARCHAR (64) NOT NULL,
    [DriverName]               VARCHAR (64) NULL,
    [DriverQuantityFixed]      FLOAT (53)   NULL,
    [DriverQuantityVariable]   FLOAT (53)   NULL,
    [DriverWeightFixed]        FLOAT (53)   NULL,
    [DriverWeightVariable]     FLOAT (53)   NULL,
    [SourceDimRef1]            VARCHAR (64) NULL,
    [SourceDimMemberRef1]      VARCHAR (64) NULL,
    [SourceDimRef2]            VARCHAR (64) NULL,
    [SourceDimMemberRef2]      VARCHAR (64) NULL,
    [SourceDimRef3]            VARCHAR (64) NULL,
    [SourceDimMemberRef3]      VARCHAR (64) NULL,
    [SourceDimRef4]            VARCHAR (64) NULL,
    [SourceDimMemberRef4]      VARCHAR (64) NULL,
    [SourceDimRef5]            VARCHAR (64) NULL,
    [SourceDimMemberRef5]      VARCHAR (64) NULL,
    [DestinationDimRef1]       VARCHAR (64) NULL,
    [DestinationDimMemberRef1] VARCHAR (64) NULL,
    [DestinationDimRef2]       VARCHAR (64) NULL,
    [DestinationDimMemberRef2] VARCHAR (64) NULL,
    [DestinationDimRef3]       VARCHAR (64) NULL,
    [DestinationDimMemberRef3] VARCHAR (64) NULL,
    [DestinationDimRef4]       VARCHAR (64) NULL,
    [DestinationDimMemberRef4] VARCHAR (64) NULL,
    [DestinationDimRef5]       VARCHAR (64) NULL,
    [DestinationDimMemberRef5] VARCHAR (64) NULL
)
WITH (DATA_COMPRESSION = PAGE);




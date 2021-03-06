﻿CREATE TABLE [etl].[Edw_TabRefLog] (
    [TabRefLogID]   INT             IDENTITY (1, 1) NOT NULL,
    [PackageLogID]  INT             NOT NULL,
    [TableName]     VARCHAR (50)    NOT NULL,
    [TypeRefresh]   VARCHAR (20)    CONSTRAINT [DF_ExtractLog_ExtractCount] DEFAULT ((0)) NOT NULL,
    [Period]        VARCHAR (12)    NULL,
    [NumRowsDel]    INT             NULL,
    [NameCtlColDel] VARCHAR (30)    NULL,
    [TotCtlColDel]  DECIMAL (18, 2) NULL,
    [NumRows]       INT             NULL,
    [RefColName_1]  VARCHAR (30)    NULL,
    [RefColTot_1]   DECIMAL (18, 2) NULL,
    [RefColName_2]  VARCHAR (30)    NULL,
    [RefColTot_2]   DECIMAL (18, 2) NULL,
    [RefColName_3]  VARCHAR (30)    NULL,
    [RefColTot_3]   DECIMAL (18, 2) NULL,
    [RefColName_4]  VARCHAR (30)    NULL,
    [RefColTot_4]   DECIMAL (18, 2) NULL,
    [RefColName_5]  VARCHAR (30)    NULL,
    [RefColTot_5]   DECIMAL (18, 2) NULL,
    [StartTime]     DATETIME        NOT NULL,
    [EndTime]       DATETIME        NULL,
    [Success]       BIT             CONSTRAINT [DF_ExtractLog_Success] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TabRefLogID] PRIMARY KEY CLUSTERED ([TabRefLogID] ASC) WITH (DATA_COMPRESSION = PAGE)
);




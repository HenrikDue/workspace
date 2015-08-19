﻿CREATE TABLE [edw].[FT_Nedskriv_BU_150303_1] (
    [Dim_Fabrik]       VARCHAR (10)    NULL,
    [Dim_Materiale]    INT             NULL,
    [Materiale]        VARCHAR (18)    NULL,
    [Dim_Tid]          VARCHAR (8)     NOT NULL,
    [Beholdning]       DECIMAL (18, 3) NULL,
    [Vaerdi_GP]        DECIMAL (18, 3) NULL,
    [GlidGnsPris]      DECIMAL (18, 6) NULL,
    [LNType]           VARCHAR (4)     NOT NULL,
    [FLNType]          VARCHAR (4)     NULL,
    [LavNedPct]        DECIMAL (7, 5)  NULL,
    [LogNedBrutto]     DECIMAL (18, 3) NULL,
    [LogNedBruttoPae]  DECIMAL (18, 3) NULL,
    [NedskrNetto]      DECIMAL (18, 3) NULL,
    [NedKorrNytMat]    DECIMAL (18, 3) NULL,
    [NedKorrNytMatPae] DECIMAL (18, 3) NULL,
    [Indk12mMgd]       DECIMAL (18, 3) NULL,
    [StatusNedskrPct]  DECIMAL (7, 5)  NULL,
    [LangNedskrPct]    DECIMAL (7, 5)  NULL,
    [RaekkeNedskrPct]  DECIMAL (7, 5)  NULL,
    [LitraNedskrPct]   DECIMAL (7, 5)  NULL,
    [NedKorrIndk]      DECIMAL (18, 3) NULL,
    [NedKorrIndkPae]   DECIMAL (18, 3) NULL,
    [IndkLagerBeh]     DECIMAL (18, 3) NULL,
    [IndkLagerVaerdi]  DECIMAL (18, 3) NULL,
    [Vaerdi_SP]        DECIMAL (18, 3) NULL,
    [Forskel]          DECIMAL (18, 3) NULL,
    [LitraNedVaerdi]   DECIMAL (18, 3) NULL,
    [DUF]              INT             NULL,
    [LangNedVaerdi]    DECIMAL (18, 3) NULL,
    [RID]              DECIMAL (18, 3) NULL,
    [RaekkeNedVaerdi]  DECIMAL (18, 3) NULL,
    [StatNedVaerdi]    DECIMAL (18, 3) NULL,
    [StatNedReelt]     DECIMAL (18, 3) NULL,
    [RestAabnBalBeh]   DECIMAL (18, 3) NULL,
    [AabnNedPct]       NUMERIC (7, 5)  NULL,
    [AabnBalNedVaerdi] NUMERIC (18, 3) NULL,
    [FraTil_tid]       VARCHAR (13)    NULL,
    [NedskrNettoPae]   DECIMAL (18, 3) NULL
);


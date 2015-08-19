﻿CREATE TABLE [edw].[GamleBeregninger] (
    [Dim_Fabrik]       VARCHAR (10)     NULL,
    [Dim_Materiale]    INT              NULL,
    [Materiale]        VARCHAR (18)     NULL,
    [Dim_Tid]          VARCHAR (6)      NOT NULL,
    [Beholdning]       DECIMAL (18, 3)  NULL,
    [Vaerdi_GP]        DECIMAL (18, 3)  NULL,
    [GlidGnsPris]      DECIMAL (18, 3)  NULL,
    [LNType]           VARCHAR (4)      NOT NULL,
    [FLNType]          VARCHAR (6)      NULL,
    [LavNedPct]        DECIMAL (38, 15) NULL,
    [LogNedBrutto]     DECIMAL (38, 6)  NULL,
    [LogNedBruttoPae]  DECIMAL (38, 6)  NULL,
    [NedskrNetto]      DECIMAL (38, 6)  NULL,
    [NedKorrNytMat]    DECIMAL (38, 6)  NULL,
    [NedKorrNytMatPae] DECIMAL (38, 6)  NULL,
    [Indk12mMgd]       INT              NULL,
    [StatusNedskrPct]  DECIMAL (8, 7)   NULL,
    [LangNedskrPct]    DECIMAL (13, 7)  NULL,
    [RaekkeNedskrPct]  DECIMAL (38, 15) NULL,
    [LitraNedskrPct]   DECIMAL (5, 2)   NULL,
    [NedKorrIndk]      DECIMAL (38, 6)  NULL,
    [NedKorrIndkPae]   DECIMAL (38, 6)  NULL,
    [IndkLagerBeh]     DECIMAL (38, 3)  NULL,
    [IndkLagerVaerdi]  DECIMAL (38, 3)  NULL,
    [Vaerdi_SP]        DECIMAL (18, 3)  NULL,
    [Forskel]          DECIMAL (19, 3)  NULL,
    [LitraNedVaerdi]   DECIMAL (24, 5)  NULL,
    [DUF]              INT              NULL,
    [LangNedVaerdi]    DECIMAL (32, 10) NULL,
    [RID]              DECIMAL (38, 6)  NULL,
    [RaekkeNedVaerdi]  DECIMAL (38, 6)  NULL,
    [StatNedVaerdi]    DECIMAL (27, 10) NULL,
    [StatNedReelt]     DECIMAL (38, 6)  NULL,
    [RestAabnBalBeh]   DECIMAL (38, 3)  NULL,
    [AabnNedPct]       NUMERIC (2, 2)   NULL,
    [AabnBalNedVaerdi] NUMERIC (38, 6)  NULL,
    [FraTil_tid]       VARCHAR (13)     NOT NULL,
    [NedskrNettoPae]   DECIMAL (38, 6)  NULL
);


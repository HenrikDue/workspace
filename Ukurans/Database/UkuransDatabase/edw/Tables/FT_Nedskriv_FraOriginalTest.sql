﻿CREATE TABLE [edw].[FT_Nedskriv_FraOriginalTest] (
    [DI_Fabrik]        VARCHAR (10)     NULL,
    [DI_Materiale]     INT              NULL,
    [Materiale]        VARCHAR (18)     NULL,
    [DI_Tid]           VARCHAR (6)      NOT NULL,
    [BeholdningIalt]   DECIMAL (18, 3)  NULL,
    [Vaerdi_GPIalt]    DECIMAL (18, 3)  NULL,
    [GlidGnsPris]      DECIMAL (18, 6)  NULL,
    [LNType]           VARCHAR (4)      NOT NULL,
    [LavNedPct]        DECIMAL (18, 15) NULL,
    [LogNedBrutto]     DECIMAL (18, 5)  NULL,
    [LogNedBruttoPae]  DECIMAL (18, 5)  NULL,
    [NedskrNetto]      DECIMAL (18, 5)  NULL,
    [NedKorrNytMat]    DECIMAL (18, 5)  NULL,
    [NedKorrNytMatPae] DECIMAL (18, 5)  NULL,
    [Indk12mMgd]       DECIMAL (18, 3)  NULL,
    [StatusNedskrPct]  DECIMAL (8, 7)   NULL,
    [LangNedskrPct]    DECIMAL (8, 7)   NULL,
    [RaekkeNedskrPct]  DECIMAL (18, 15) NULL,
    [LitraNedskrPct]   DECIMAL (5, 2)   NULL,
    [NedKorrIndk]      DECIMAL (18, 6)  NULL,
    [NedKorrIndkPae]   DECIMAL (18, 6)  NULL,
    [IndkLagerBeh]     DECIMAL (18, 3)  NULL,
    [IndkLagerVaerdi]  DECIMAL (18, 3)  NULL,
    [Vaerdi_SP]        DECIMAL (18, 3)  NULL,
    [Forskel]          DECIMAL (18, 3)  NULL,
    [LitraNedVaerdi]   DECIMAL (18, 5)  NULL,
    [DUF]              INT              NULL,
    [LangNedVaerdi]    DECIMAL (18, 6)  NULL,
    [RID]              DECIMAL (18, 6)  NULL,
    [RaekkeNedVaerdi]  DECIMAL (18, 6)  NULL,
    [StatNedVaerdi]    DECIMAL (18, 6)  NULL,
    [StatNedReelt]     DECIMAL (18, 5)  NULL,
    [RestAabnBalBeh]   DECIMAL (18, 3)  NULL,
    [AabnNedPct]       NUMERIC (2, 2)   NULL,
    [AabnBalNedVaerdi] NUMERIC (18, 6)  NULL,
    [FraTil_tid]       VARCHAR (13)     NULL,
    [NedskrNettoPae]   DECIMAL (18, 5)  NULL,
    [FLNType]          VARCHAR (4)      NULL
);


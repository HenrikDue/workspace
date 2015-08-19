﻿CREATE TABLE [edw].[FT_Forklaring_BU_141202_2_FraGlTest] (
    [01_Dato_Fra_Til]   VARCHAR (24)    NOT NULL,
    [02_Dato_Fra]       DATETIME        NOT NULL,
    [03_Dato_Til]       DATETIME        NOT NULL,
    [04_Fb]             VARCHAR (10)    NOT NULL,
    [05_Mat]            VARCHAR (18)    NOT NULL,
    [06_MaterialeTekst] VARCHAR (50)    NOT NULL,
    [07_LitraGr]        VARCHAR (15)    NOT NULL,
    [08_StatGr]         VARCHAR (20)    NOT NULL,
    [09_Mart]           VARCHAR (10)    NOT NULL,
    [10_Sm]             VARCHAR (1)     NULL,
    [11_Beh]            DECIMAL (18, 6) NULL,
    [12_GlGPris]        DECIMAL (18, 6) NULL,
    [13_AnskVaerdi]     DECIMAL (18, 6) NULL,
    [14_LNType]         VARCHAR (4)     NOT NULL,
    [15_LavNedPct]      DECIMAL (18, 6) NULL,
    [16_NedForPrinC]    DECIMAL (18, 6) NULL,
    [17_DI_aendring]    VARCHAR (20)    NOT NULL,
    [19_FTrMd]          VARCHAR (7)     NULL,
    [20_DSystAendr]     DECIMAL (18, 6) NULL,
    [21_NedskrNetto]    DECIMAL (18, 6) NULL,
    [23_Vaerdi_SP]      DECIMAL (18, 6) NULL,
    [24_Forskel]        DECIMAL (18, 6) NULL,
    [25_FLNType]        VARCHAR (4)     NOT NULL,
    [26_FLavNedPct]     DECIMAL (18, 6) NULL,
    [27_DUF]            INT             NULL,
    [30_RID]            INT             NULL,
    [90_MRP_Contr]      VARCHAR (6)     NULL,
    [91_MRP_Type]       VARCHAR (6)     NULL,
    [92_ABC_IN]         VARCHAR (6)     NULL,
    [93_VareGrp]        VARCHAR (18)    NULL,
    [94_IK_Grp]         VARCHAR (6)     NULL,
    [95_VareGrpTekst]   VARCHAR (20)    NULL
);


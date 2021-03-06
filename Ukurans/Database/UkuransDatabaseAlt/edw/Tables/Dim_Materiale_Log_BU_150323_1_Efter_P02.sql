﻿CREATE TABLE [edw].[Dim_Materiale_Log_BU_150323_1_Efter_P02] (
    [Dim_Tid]        VARCHAR (8)  NOT NULL,
    [LogDato]        DATETIME     NULL,
    [AendringNr]     VARCHAR (5)  NULL,
    [Aarsag]         VARCHAR (50) NULL,
    [PK_ID]          INT          NOT NULL,
    [Materiale]      VARCHAR (18) NOT NULL,
    [MaterialeTekst] VARCHAR (50) NULL,
    [LitraGr2]       VARCHAR (15) NOT NULL,
    [StatusGr2]      VARCHAR (15) NOT NULL,
    [Aktiv]          CHAR (1)     NOT NULL,
    [GyldigFra]      DATETIME     NOT NULL,
    [GyldigTil]      DATETIME     NOT NULL,
    [FRegAar]        VARCHAR (8)  NULL,
    [FTrAar]         VARCHAR (8)  NULL,
    [FRegDato]       DATETIME     NULL,
    [FTrDato]        DATETIME     NULL,
    [Oprettet]       DATETIME     NULL,
    [MatArt]         VARCHAR (20) NULL,
    [VareGrp]        VARCHAR (20) NULL,
    [FBevArt]        VARCHAR (20) NULL,
    [OmlVare]        CHAR (1)     NULL,
    [Litra_PKID]     INT          NOT NULL,
    [Timestamp]      DATETIME     NULL
);


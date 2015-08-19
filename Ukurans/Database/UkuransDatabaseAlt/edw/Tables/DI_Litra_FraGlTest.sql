CREATE TABLE [edw].[DI_Litra_FraGlTest] (
    [PK_ID]            INT              NOT NULL,
    [LitraGr1]         VARCHAR (20)     NOT NULL,
    [LitraGr2]         VARCHAR (50)     NOT NULL,
    [LitraGr2Tekst]    VARCHAR (100)    NOT NULL,
    [LitraNedskrPct]   DECIMAL (5, 2)   NULL,
    [DUF_NedskrAar]    INT              NOT NULL,
    [RID_NedskrFaktor] DECIMAL (16, 15) NULL,
    [RID_NedskrTekst]  VARCHAR (50)     NULL,
    [FixedNedskrFra]   DATETIME         NULL,
    [FixedNedskrTil]   DATETIME         NULL,
    [FixedNedskrErMax] VARCHAR (5)      NULL,
    [GyldigFra]        DATETIME         NOT NULL,
    [GyldigTil]        DATETIME         NOT NULL
);


CREATE TABLE [edw].[Dim_Litra_BU_150522_1_Efter_P04] (
    [PK_ID]            INT              IDENTITY (-1, 1) NOT NULL,
    [LitraGr1]         VARCHAR (15)     NOT NULL,
    [LitraGr2]         VARCHAR (15)     NOT NULL,
    [LitraGr2Tekst]    VARCHAR (100)    NOT NULL,
    [LitraNedskrPct]   DECIMAL (5, 3)   NULL,
    [DUF_NedskrAar]    INT              NOT NULL,
    [RID_NedskrFaktor] DECIMAL (15, 15) NULL,
    [RID_NedskrTekst]  VARCHAR (50)     NULL,
    [FixedNedskrFra]   DATETIME         NULL,
    [FixedNedskrTil]   DATETIME         NULL,
    [FixedNedskrErMax] VARCHAR (5)      NULL,
    [GyldigFra]        DATETIME         NOT NULL,
    [GyldigTil]        DATETIME         NOT NULL,
    CONSTRAINT [PK_Dim_Litra_PK_ID_BU_150522_1_Efter_P04] PRIMARY KEY CLUSTERED ([PK_ID] ASC) WITH (FILLFACTOR = 75, PAD_INDEX = ON)
);


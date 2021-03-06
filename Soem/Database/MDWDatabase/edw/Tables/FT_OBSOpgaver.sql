﻿CREATE TABLE [edw].[FT_OBSOpgaver] (
    [DI_Medarbejder_Togfører_FR] INT          NOT NULL,
    [DI_Opgave]                  INT          NOT NULL,
    [DI_TjenesteDepot]           VARCHAR (5)  NOT NULL,
    [DI_Lokation]                VARCHAR (10) NOT NULL,
    [DI_Togsystem]               INT          NOT NULL,
    [DI_Tid]                     VARCHAR (50) NOT NULL,
    [Varighed_tim]               FLOAT (53)   NULL,
    [Tognummer]                  INT          NOT NULL,
    [DI_Station_fra]             INT          NULL,
    [DI_Station_til]             INT          NULL,
    [PDS_Varighed_fordelt]       FLOAT (53)   NULL,
    [DI_Tidsintervaller]         INT          NULL,
    [FraTidspunkt]               DATETIME     NULL,
    [TilTidspunkt]               DATETIME     NULL,
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Lokation] FOREIGN KEY ([DI_Lokation]) REFERENCES [edw].[DI_Lokation] ([Kode]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Medarbejder_Togfører_FR] FOREIGN KEY ([DI_Medarbejder_Togfører_FR]) REFERENCES [edw].[DI_Medarbejder_Togfører_FR] ([PK_ID]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Opgave] FOREIGN KEY ([DI_Opgave]) REFERENCES [edw].[DI_Opgave] ([PK_ID]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Station_fra] FOREIGN KEY ([DI_Station_fra]) REFERENCES [edw].[DI_Station] ([PK_ID]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Station_til] FOREIGN KEY ([DI_Station_til]) REFERENCES [edw].[DI_Station] ([PK_ID]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Tid] FOREIGN KEY ([DI_Tid]) REFERENCES [edw].[DI_Tid] ([Reference]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Tidsinterval] FOREIGN KEY ([DI_Tidsintervaller]) REFERENCES [edw].[DI_Tidsintervaller] ([PK_ID]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_TjenesteDepot] FOREIGN KEY ([DI_TjenesteDepot]) REFERENCES [edw].[DI_Turdepot] ([Turdepot]),
    CONSTRAINT [FK_FT_OBSOpgaver_DI_Togsystem] FOREIGN KEY ([DI_Togsystem]) REFERENCES [edw].[DI_Togsystem] ([PK_DI_Togsystem])
)
WITH (DATA_COMPRESSION = PAGE);




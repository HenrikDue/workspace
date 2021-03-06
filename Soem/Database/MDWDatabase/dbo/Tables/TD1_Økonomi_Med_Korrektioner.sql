﻿CREATE TABLE [dbo].[TD1_Økonomi_Med_Korrektioner] (
    [Profitcenter]                 VARCHAR (50)  NULL,
    [Profitcenternavn_dont_use]    VARCHAR (50)  NULL,
    [Omkostningssted]              VARCHAR (50)  NULL,
    [Omkostningsstednavn_dont_use] VARCHAR (50)  NULL,
    [Omkostningsart]               VARCHAR (50)  NULL,
    [Omkostningsartnavn_dont_use]  VARCHAR (50)  NULL,
    [PSP-element]                  VARCHAR (50)  NULL,
    [PSP-elementNavn_dont_use]     VARCHAR (50)  NULL,
    [Ordre]                        VARCHAR (50)  NULL,
    [Ordrenavn_dont_use]           VARCHAR (50)  NULL,
    [Litratype]                    VARCHAR (50)  NULL,
    [Litratypenavn_dont_use]       VARCHAR (50)  NULL,
    [Bruges ikke]                  VARCHAR (50)  NULL,
    [indlæstAf]                    VARCHAR (128) NULL,
    [indlæstTidspunkt]             DATETIME      NULL,
    [Beløb]                        FLOAT (53)    NULL,
    [Stationsnr]                   VARCHAR (50)  NULL,
    [Stationstype]                 VARCHAR (50)  NULL,
    [Delområde]                    VARCHAR (50)  NULL,
    [NøgleFastEjendom]             VARCHAR (50)  NULL,
    [Beskrivelse]                  VARCHAR (200) NULL,
    [Periode]                      VARCHAR (50)  NULL,
    [KildeArk]                     VARCHAR (50)  NULL
)
WITH (DATA_COMPRESSION = PAGE);




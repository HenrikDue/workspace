﻿CREATE TABLE [dbo].[GD_R_Økonomi_Drift] (
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
    [Delområde]                    VARCHAR (50)  NULL,
    [DelområdeNavn]                VARCHAR (50)  NULL,
    [StationsNr]                   VARCHAR (50)  NULL,
    [StationsNavn]                 VARCHAR (50)  NULL,
    [StationsType]                 VARCHAR (50)  NULL,
    [StationsTypeNavn]             VARCHAR (50)  NULL,
    [NøgleFastEjendom]             VARCHAR (50)  NULL,
    [Beskrivelse]                  VARCHAR (200) NULL,
    [FaktiskBeløb]                 FLOAT (53)    NULL,
    [indlæstTidspunktRådata]       DATETIME      NULL,
    [indlæstAfRådata]              VARCHAR (128) NULL,
    [Momsstatus]                   FLOAT (53)    NULL,
    [CeArtGrp]                     VARCHAR (50)  NULL,
    [CeArtGrpNavn]                 VARCHAR (50)  NULL,
    [ArtGrp]                       VARCHAR (50)  NULL,
    [ArtGrpNavn]                   VARCHAR (50)  NULL,
    [Variabilitet]                 VARCHAR (50)  NULL,
    [VariabilitetNavn]             VARCHAR (50)  NULL,
    [Reversibilitet]               VARCHAR (50)  NULL,
    [ReversibilitetNavn]           VARCHAR (50)  NULL,
    [indlæstTidspunktManuelledata] DATETIME      NULL,
    [indlæstAfManuelleDAta]        VARCHAR (128) NULL,
    [indlæstTidspunkt]             DATETIME      NULL,
    [indlæstAf]                    [sysname]     NULL,
    [Periode]                      VARCHAR (50)  NULL,
    [KildeArk]                     VARCHAR (50)  NULL
)
WITH (DATA_COMPRESSION = PAGE);






﻿CREATE TABLE [dbo].[TD2_CD_G_ETL5_Ressourceportal_Drift] (
    [rækkeNummer]                               BIGINT        NULL,
    [Profitcenter]                              VARCHAR (50)  NULL,
    [Profitcenternavn]                          VARCHAR (50)  NULL,
    [Omkostningssted]                           VARCHAR (50)  NULL,
    [Omkostningsstednavn]                       VARCHAR (50)  NULL,
    [Omkostningsart]                            VARCHAR (50)  NULL,
    [Omkostningsartnavn]                        VARCHAR (50)  NULL,
    [PSP-element]                               VARCHAR (50)  NULL,
    [PSP-elementNavn]                           VARCHAR (50)  NULL,
    [Ordre]                                     VARCHAR (50)  NULL,
    [Ordrenavn]                                 VARCHAR (50)  NULL,
    [Litratype]                                 VARCHAR (50)  NULL,
    [Litratypenavn]                             VARCHAR (50)  NULL,
    [Delområde]                                 VARCHAR (50)  NULL,
    [DelområdeNavn]                             VARCHAR (50)  NULL,
    [StationsNr]                                VARCHAR (50)  NULL,
    [StationsNavn]                              VARCHAR (50)  NULL,
    [StationsType]                              VARCHAR (50)  NULL,
    [StationsTypeNavn]                          VARCHAR (50)  NULL,
    [NøgleFastEjendom]                          VARCHAR (50)  NULL,
    [Beløb]                                     FLOAT (53)    NULL,
    [Momsstatus]                                FLOAT (53)    NULL,
    [CeArtGrp]                                  VARCHAR (50)  NULL,
    [CeArtGrpNavn]                              VARCHAR (50)  NULL,
    [ArtGrp]                                    VARCHAR (50)  NULL,
    [ArtGrpNavn]                                VARCHAR (50)  NULL,
    [ATT_VarArt]                                VARCHAR (50)  NULL,
    [ATT_VarArt_Navn]                           VARCHAR (50)  NULL,
    [ATT_ResArt]                                VARCHAR (50)  NULL,
    [ATT_ResArt_Navn]                           VARCHAR (50)  NULL,
    [costpool]                                  VARCHAR (50)  NULL,
    [Reference_ID]                              VARCHAR (104) NULL,
    [Niveau]                                    VARCHAR (50)  NULL,
    [Sort]                                      INT           NULL,
    [Reference_Name]                            VARCHAR (50)  NULL,
    [Reference_Parent]                          VARCHAR (50)  NULL,
    [Reference_Name_Parent]                     VARCHAR (50)  NULL,
    [Type]                                      VARCHAR (50)  NULL,
    [EvenlyAssigned]                            VARCHAR (50)  NULL,
    [DriverName]                                VARCHAR (50)  NULL,
    [Model]                                     VARCHAR (50)  NULL,
    [Aktiv]                                     VARCHAR (50)  NULL,
    [Kilde_Beskrivelse]                         VARCHAR (200) NULL,
    [Ressource_Beskrivelse]                     VARCHAR (50)  NULL,
    [ATT_ResType]                               VARCHAR (50)  NULL,
    [IndlæstTidspunktEX_MD_G_ACCHIER_Ressource] DATETIME      NULL,
    [indlæstTidspunktMD_G_Stam_Artskontoplan]   DATETIME      NULL,
    [indlæstTidspunktGD_R_Økonomi_Drift]        DATETIME      NULL,
    [Periode]                                   VARCHAR (50)  NULL,
    [KildeArk]                                  VARCHAR (50)  NULL,
    [Variabilitet]                              VARCHAR (50)  NULL,
    [Variabilitet_Navn]                         VARCHAR (50)  NULL
);


﻿CREATE TABLE [ods].[RD_R_Økonomi_Drift] (
    [Profitcenter]                 VARCHAR (50) NULL,
    [Profitcenternavn_dont_use]    VARCHAR (50) NULL,
    [Omkostningssted]              VARCHAR (50) NULL,
    [Omkostningsstednavn_dont_use] VARCHAR (50) NULL,
    [Omkostningsart]               VARCHAR (50) NULL,
    [Omkostningsartnavn_dont_use]  VARCHAR (50) NULL,
    [PSP-element]                  VARCHAR (50) NULL,
    [PSP-elementNavn_dont_use]     VARCHAR (50) NULL,
    [Ordre]                        VARCHAR (50) NULL,
    [Ordrenavn_dont_use]           VARCHAR (50) NULL,
    [Litratype]                    VARCHAR (50) NULL,
    [Litratypenavn_dont_use]       VARCHAR (50) NULL,
    [FaktiskBeløb]                 VARCHAR (50) NULL,
    [PlanBeløb]                    VARCHAR (50) NULL,
    [AfvigelseBeløb]               VARCHAR (50) NULL,
    [AfvigelseProcent]             VARCHAR (50) NULL,
    [FaktiskMængde]                VARCHAR (50) NULL,
    [PlanMængde]                   VARCHAR (50) NULL,
    [indlæstTidspunkt]             DATETIME     DEFAULT (getdate()) NULL,
    [indlæstAf]                    [sysname]    DEFAULT (suser_sname()) NULL,
    [Periode]                      VARCHAR (50) NULL,
    [kildefilogark]                VARCHAR (50) NULL
)
WITH (DATA_COMPRESSION = PAGE);




﻿CREATE TABLE [ods].[TD_RDP_Togproduktion_Tog] (
    [Tognr]                   INT             NULL,
    [Dato]                    DATETIME        NULL,
    [Fratidspunkt]            VARCHAR (50)    NULL,
    [Tiltidspunkt]            VARCHAR (50)    NULL,
    [Frastation]              VARCHAR (50)    NULL,
    [Tilstation]              VARCHAR (50)    NULL,
    [Togkm]                   NUMERIC (24, 6) NULL,
    [PlanSaertog]             VARCHAR (50)    NULL,
    [Trækkraft]               VARCHAR (50)    NULL,
    [Togminutter]             NUMERIC (24, 6) NULL,
    [Omlagt]                  BIT             NULL,
    [Materielkørsel]          BIT             NULL,
    [Tomkørsel]               BIT             NULL,
    [AntalTraekkraefter]      INT             NULL,
    [Togsysnr]                INT             NULL,
    [Togdublering]            BIT             NULL,
    [AntalVogne]              INT             NULL,
    [RetningsbestemtStrk]     VARCHAR (100)   NULL,
    [IkkeRetningsbestemtStrk] VARCHAR (100)   NULL,
    [Omraade]                 VARCHAR (50)    NULL,
    [Omraadeland]             VARCHAR (50)    NULL,
    [TognrInterval]           VARCHAR (50)    NULL,
    [Division]                VARCHAR (50)    NULL,
    [Produkt]                 VARCHAR (50)    NULL,
    [Togkategoribeskrivelse]  VARCHAR (50)    NULL,
    [Togkategoriejer]         VARCHAR (50)    NULL,
    [Togsysnavn]              VARCHAR (50)    NULL,
    [Togsysforkortelse]       VARCHAR (50)    NULL,
    [Loebestrk]               VARCHAR (100)   NULL,
    [Aflyst]                  VARCHAR (50)    NULL,
    [ICStraekning]            VARCHAR (50)    NULL,
    [Togkategori]             VARCHAR (50)    NULL,
    [Ugedag]                  VARCHAR (50)    NULL,
    [Kontraktoperator]        VARCHAR (50)    NULL,
    [Tekniskoperator]         VARCHAR (50)    NULL,
    [Ekstraproduktion]        BIT             NULL,
    [Column 39]               VARCHAR (255)   NULL,
    [erSaertog]               BIT             NULL,
    [erAflyst]                BIT             NULL
);


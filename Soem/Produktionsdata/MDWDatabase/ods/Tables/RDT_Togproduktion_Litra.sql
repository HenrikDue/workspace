﻿CREATE TABLE [ods].[RDT_Togproduktion_Litra] (
    [Dato]                    DATETIME        NULL,
    [Tognr]                   INT             NULL,
    [Loebenr]                 INT             NULL,
    [TognrInterval]           VARCHAR (50)    NULL,
    [Fratidspunkt]            VARCHAR (50)    NULL,
    [Tiltidspunkt]            VARCHAR (50)    NULL,
    [Litra]                   VARCHAR (50)    NULL,
    [Ejer]                    VARCHAR (50)    NULL,
    [Jernbane]                VARCHAR (50)    NULL,
    [Frastation]              VARCHAR (50)    NULL,
    [Tilstation]              VARCHAR (50)    NULL,
    [Materieltype]            VARCHAR (50)    NULL,
    [RetningsbestemtStrk]     VARCHAR (100)   NULL,
    [IkkeRetningsbestemtStrk] VARCHAR (100)   NULL,
    [Loebestrk]               VARCHAR (100)   NULL,
    [Omraade]                 VARCHAR (50)    NULL,
    [Omraadeland]             VARCHAR (50)    NULL,
    [Division]                VARCHAR (50)    NULL,
    [Produkt]                 VARCHAR (50)    NULL,
    [Togkategori]             VARCHAR (50)    NULL,
    [Togkategoribeskrivelse]  VARCHAR (50)    NULL,
    [Togkategoriejer]         VARCHAR (50)    NULL,
    [Togsysnr]                VARCHAR (50)    NULL,
    [Togsysnavn]              VARCHAR (50)    NULL,
    [Togsysforkortelse]       VARCHAR (50)    NULL,
    [ICStraekning]            VARCHAR (50)    NULL,
    [Kontraktoperatoer]       VARCHAR (50)    NULL,
    [Tekniskoperatoer]        VARCHAR (50)    NULL,
    [erEkstraproduktion]      BIT             NULL,
    [erGennemgaaendeVogn]     BIT             NULL,
    [erPlaceringskoersel]     BIT             NULL,
    [erAflaast]               BIT             NULL,
    [erAflyst]                BIT             NULL,
    [erForstaerkning]         BIT             NULL,
    [erMaterielkoersel]       BIT             NULL,
    [erTomkoersel]            BIT             NULL,
    [Litrakm]                 DECIMAL (24, 6) NULL,
    [Litraminutter]           DECIMAL (24, 6) NULL,
    [Status]                  VARCHAR (50)    NULL,
    [Timestamp]               DATETIME        NULL
)
WITH (DATA_COMPRESSION = PAGE);




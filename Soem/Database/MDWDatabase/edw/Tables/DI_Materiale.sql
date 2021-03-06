﻿CREATE TABLE [edw].[DI_Materiale] (
    [PK_ID]                   INT          IDENTITY (1, 1) NOT NULL,
    [loebenr]                 INT          NOT NULL,
    [Nummer]                  VARCHAR (50) NULL,
    [Antal]                   INT          NULL,
    [Litra]                   VARCHAR (25) NOT NULL,
    [Type]                    VARCHAR (50) NULL,
    [Variant]                 VARCHAR (50) NULL,
    [Kaldenavn]               VARCHAR (50) NULL,
    [Egenavn]                 VARCHAR (50) NULL,
    [AntalVogne]              INT          NULL,
    [Hastighed]               INT          NULL,
    [FasteSiddepladser]       INT          NULL,
    [Klapsæder]               INT          NULL,
    [SiddepladserTotal]       INT          NULL,
    [Traktionssystem]         VARCHAR (50) NULL,
    [Ejerforhold]             VARCHAR (25) NULL,
    [BistroOgPantry]          VARCHAR (10) NULL,
    [Salgsautomater]          VARCHAR (10) NULL,
    [Greenspeed]              VARCHAR (10) NULL,
    [GodkendtTilTunnelkørsel] VARCHAR (10) NULL,
    [Source]                  VARCHAR (50) NULL,
    [Aktiv_fra]               DATETIME     NULL,
    [Aktiv_til]               DATETIME     NULL,
    CONSTRAINT [PK_DI_Materiale] PRIMARY KEY CLUSTERED ([PK_ID] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [UK_DI_Materiale] UNIQUE NONCLUSTERED ([loebenr] ASC, [Litra] ASC, [Aktiv_fra] ASC, [Aktiv_til] ASC)
);




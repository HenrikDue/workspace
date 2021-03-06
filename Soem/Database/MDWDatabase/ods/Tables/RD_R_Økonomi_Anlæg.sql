﻿CREATE TABLE [ods].[RD_R_Økonomi_Anlæg] (
    [HovednrUnr]            VARCHAR (50) NULL,
    [Firmakode]             VARCHAR (50) NULL,
    [AktiverDato]           DATETIME     NULL,
    [BetegnelseAnlaegAktiv] VARCHAR (50) NULL,
    [Balkonto]              VARCHAR (50) NULL,
    [AnlKlasse]             VARCHAR (50) NULL,
    [AkkAfskrPrimo]         FLOAT (53)   NULL,
    [AkkAfskrUltimo]        FLOAT (53)   NULL,
    [Afskrivning]           FLOAT (53)   NULL,
    [BogfoertVaerdiPrimo]   FLOAT (53)   NULL,
    [BogfoertVaerdiUltimo]  FLOAT (53)   NULL,
    [OmkStedUltimo]         VARCHAR (50) NULL,
    [OmkStedNavnUltimo]     VARCHAR (50) NULL,
    [Sats]                  FLOAT (53)   NULL,
    [AnskVaerdi]            FLOAT (53)   NULL,
    [Profitcenter]          VARCHAR (50) NULL,
    [AfskrivningerAM]       FLOAT (53)   NULL,
    [Afvigelse]             FLOAT (53)   NULL,
    [Forrentningsgrundlag]  FLOAT (53)   NULL,
    [Forrentning]           FLOAT (53)   NULL,
    [Timestamp]             DATETIME     NULL,
    [Periode]               VARCHAR (50) NULL,
    [kildefilogark]         VARCHAR (50) NULL,
    [indlæstTidspunkt]      DATETIME     DEFAULT (getdate()) NULL,
    [indlæstAf]             [sysname]    DEFAULT (suser_sname()) NULL
)
WITH (DATA_COMPRESSION = PAGE);




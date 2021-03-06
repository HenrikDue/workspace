﻿CREATE TABLE [ods].[td_pds_togsystem] (
    [PersonId]                 VARCHAR (50) NULL,
    [ArbejdsKode]              VARCHAR (50) NULL,
    [ArbejdsDato]              DATETIME     NULL,
    [TjenesteVarighed]         VARCHAR (50) NULL,
    [TjenesteMoadestedDepot]   VARCHAR (50) NULL,
    [OpgaveDatoTid]            DATETIME     NULL,
    [OpgaveKode]               VARCHAR (50) NULL,
    [OpgaveVarighed]           VARCHAR (50) NULL,
    [OpgaveStartSt]            VARCHAR (50) NULL,
    [OpgaveSlutSt]             VARCHAR (50) NULL,
    [OpgaveTogNr]              VARCHAR (50) NULL,
    [TimeStamp]                DATETIME     NULL,
    [togFra_frastation]        VARCHAR (50) NULL,
    [togTilstation_tilstation] VARCHAR (50) NULL,
    [togFra_fratidspunkt]      DATETIME     NULL,
    [togtil_tiltidspunkt]      DATETIME     NULL,
    [kilde]                    VARCHAR (50) NULL,
    [fratidspunkt]             DATETIME     NULL,
    [tiltidspunkt]             DATETIME     NULL,
    [frastation]               VARCHAR (50) NULL,
    [tilstation]               VARCHAR (50) NULL,
    [togsystem]                INT          NULL,
    [sekunder]                 INT          NULL,
    [tog_status]               VARCHAR (14) NOT NULL
)
WITH (DATA_COMPRESSION = PAGE);




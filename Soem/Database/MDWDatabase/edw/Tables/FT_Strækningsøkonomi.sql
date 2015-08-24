﻿CREATE TABLE [edw].[FT_Strækningsøkonomi] (
    [Ft_key]                         BIGINT        NOT NULL,
    [Periode]                        INT           NOT NULL,
    [Model_id]                       INT           NOT NULL,
    [DestcostGangetOp]               FLOAT (53)    NULL,
    [resource1_key]                  INT           NULL,
    [resource2_key]                  INT           NULL,
    [activity1_key]                  INT           NULL,
    [activity2_key]                  INT           NULL,
    [activity3_key]                  INT           NULL,
    [activity4_key]                  INT           NULL,
    [costobject1_key]                INT           NULL,
    [attRessourcetype_key]           INT           NULL,
    [attFunktionskunde_key]          INT           NULL,
    [AttSegment_key]                 INT           NULL,
    [AttProduktaktivitetsgruppe_key] INT           NULL,
    [AttProduktVariabilitet_key]     INT           NULL,
    [AttProduktLitra_key]            INT           NULL,
    [AttTogsystem_key]               INT           NULL,
    [Omkostningssted_key]            INT           NULL,
    [art_hierarki_key]               INT           NULL,
    [ordre_key]                      INT           NULL,
    [pspelement_key]                 INT           NULL,
    [profitcenter_key]               INT           NULL,
    [Artsgruppe_key]                 INT           NULL,
    [resBeløb]                       FLOAT (53)    NULL,
    [resSumBeløb]                    FLOAT (53)    NULL,
    [Beløb]                          FLOAT (53)    NULL,
    [RessourceportalJoin]            INT           NULL,
    [Dækningsbidrag_key]             INT           NULL,
    [Variabilitet_key]               INT           NULL,
    [Reversibilitet_key]             INT           NULL,
    [Tidsinterval_key]               INT           NULL,
    [Momsstatus]                     INT           NULL,
    [kilde_key]                      INT           NULL,
    [OprettetTidspunkt]              DATETIME      DEFAULT (getdate()) NULL,
    [OprettetAf]                     VARCHAR (256) DEFAULT (suser_sname()) NULL
) ON [Periode_All_to_primary] ([Periode]);


﻿CREATE TABLE [edw].[DI_Tid] (
    [uds_level]         VARCHAR (50) NOT NULL,
    [Reference]         VARCHAR (50) NOT NULL,
    [ParentReference]   VARCHAR (50) NOT NULL,
    [Name]              VARCHAR (50) NOT NULL,
    [Aar]               INT          NULL,
    [Halvaar]           INT          NULL,
    [Kvartal]           INT          NULL,
    [Maanedtekst]       VARCHAR (50) NULL,
    [MaanedNum]         INT          NULL,
    [UgedagTekst]       VARCHAR (50) NULL,
    [UgedagNum]         INT          NULL,
    [Maanedsdag]        INT          NULL,
    [Helligdag]         VARCHAR (50) NULL,
    [Alternativ1]       VARCHAR (50) NULL,
    [ParentHier2]       VARCHAR (50) NULL,
    [Dagenefter]        VARCHAR (50) NULL,
    [Dato]              DATETIME     NULL,
    [Maanedstekst_Kort] VARCHAR (3)  NULL,
    [HalvaarTekst]      VARCHAR (2)  NULL,
    [KvartalTekst]      VARCHAR (2)  NULL,
    [ReferenceName]     VARCHAR (50) NULL,
    CONSTRAINT [PK_DI_Tid] PRIMARY KEY CLUSTERED ([Reference] ASC) WITH (DATA_COMPRESSION = PAGE)
);




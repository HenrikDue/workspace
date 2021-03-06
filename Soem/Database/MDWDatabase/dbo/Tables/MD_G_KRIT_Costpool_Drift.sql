﻿CREATE TABLE [dbo].[MD_G_KRIT_Costpool_Drift] (
    [ID]               VARCHAR (50) NULL,
    [Costpool]         VARCHAR (50) NULL,
    [CostpoolNavn]     VARCHAR (50) NULL,
    [DelområdeFra]     VARCHAR (50) NULL,
    [DelområdeTil]     VARCHAR (50) NULL,
    [ArtFra]           VARCHAR (50) NULL,
    [ArtTil]           VARCHAR (50) NULL,
    [ArtGrpFra]        VARCHAR (50) NULL,
    [ArtGrpTil]        VARCHAR (50) NULL,
    [CeArtGrpFra]      VARCHAR (50) NULL,
    [CeArtGrpTil]      VARCHAR (50) NULL,
    [StationsnrFra]    VARCHAR (50) NULL,
    [StationsnrTil]    VARCHAR (50) NULL,
    [StationstypeFra]  VARCHAR (50) NULL,
    [StationstypeTil]  VARCHAR (50) NULL,
    [LitraFra]         VARCHAR (50) NULL,
    [LitraTil]         VARCHAR (50) NULL,
    [OrdreFra]         VARCHAR (50) NULL,
    [OrdreTil]         VARCHAR (50) NULL,
    [PSPFra]           VARCHAR (50) NULL,
    [PSPTil]           VARCHAR (50) NULL,
    [OmkStedFra]       VARCHAR (50) NULL,
    [OmkStedTil]       VARCHAR (50) NULL,
    [PctrFra]          VARCHAR (50) NULL,
    [PctrTil]          VARCHAR (50) NULL,
    [Model]            VARCHAR (50) NULL,
    [indlæstTidspunkt] DATETIME     CONSTRAINT [DF_MD_G_KRIT_Costpool_Drift_indlæstTidspunkt] DEFAULT (getdate()) NULL,
    [indlæstAf]        [sysname]    CONSTRAINT [DF_MD_G_KRIT_Costpool_Drift_indlæstAf] DEFAULT (suser_sname()) NULL
)
WITH (DATA_COMPRESSION = PAGE);




﻿CREATE TABLE [ods].[md_artshierarki_manuelle_tilføjelser_ny_dirk] (
    [Art]               VARCHAR (10)  NULL,
    [Artsnavn]          VARCHAR (255) NULL,
    [Parent]            VARCHAR (10)  NULL,
    [LoadTimeStamp]     DATETIME      NULL,
    [oprettetTidspunkt] DATETIME      DEFAULT (getdate()) NULL,
    [oprettetAf]        [sysname]     DEFAULT (suser_sname()) NOT NULL
)
WITH (DATA_COMPRESSION = PAGE);




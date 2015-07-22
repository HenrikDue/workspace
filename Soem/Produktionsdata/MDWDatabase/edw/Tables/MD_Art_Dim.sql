﻿CREATE TABLE [edw].[MD_Art_Dim] (
    [ArtID]             VARCHAR (255) NULL,
    [MemberName]        VARCHAR (255) NULL,
    [Parent]            VARCHAR (255) NULL,
    [oprettetTidspunkt] DATETIME      DEFAULT (getdate()) NULL,
    [oprettetAf]        [sysname]     DEFAULT (suser_sname()) NOT NULL
);


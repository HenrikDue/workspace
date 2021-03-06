﻿CREATE TABLE [edw].[Dim_Art_Hierarki] (
    [Pk_key]             INT           NULL,
    [Art]                VARCHAR (255) NULL,
    [Artsnavn]           VARCHAR (255) NULL,
    [Parent_Key]         INT           NULL,
    [Parent]             VARCHAR (255) NULL,
    [oprettetTidspunkt]  DATETIME      DEFAULT (getdate()) NULL,
    [oprettetAf]         [sysname]     DEFAULT (suser_sname()) NOT NULL,
    [opdateretTidspunkt] DATETIME      NULL,
    [opdateretAf]        [sysname]     NULL
)
WITH (DATA_COMPRESSION = PAGE);




GO
create trigger [edw].[Dim_Art_Hierarki_updated] on [edw].[Dim_Art_Hierarki]
 AFTER  UPDATE
AS  UPDATE [edw].[Dim_Art_Hierarki] SET opdateretTidspunkt = GETDATE(), opdateretAf = SUSER_SNAME() FROM inserted WHERE inserted.pk_key = [edw].[Dim_Art_Hierarki].pk_key
CREATE TABLE [edw].[Dim_Aendring_BU_150623_1_Efter_P05] (
    [Order_Num]   INT           NULL,
    [Kode]        VARCHAR (20)  NOT NULL,
    [KortNavn]    VARCHAR (20)  NULL,
    [Beskrivelse] VARCHAR (100) NULL,
    CONSTRAINT [PK_Dim_Aendring_Kode_BU_150623_1_Efter_P05] PRIMARY KEY CLUSTERED ([Kode] ASC)
);


CREATE TABLE [edw].[Dim_Aendring_BU_150803_1_Efter_P06] (
    [Order_Num]   INT           NULL,
    [Kode]        VARCHAR (20)  NOT NULL,
    [KortNavn]    VARCHAR (20)  NULL,
    [Beskrivelse] VARCHAR (100) NULL,
    CONSTRAINT [PK_Dim_Aendring_Kode_BU_150803_1_Efter_P06] PRIMARY KEY CLUSTERED ([Kode] ASC)
);


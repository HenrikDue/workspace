CREATE TABLE [edw].[Dim_Aendring_BU_150522_1_Efter_P04] (
    [Order_Num]   INT           NULL,
    [Kode]        VARCHAR (20)  NOT NULL,
    [KortNavn]    VARCHAR (20)  NULL,
    [Beskrivelse] VARCHAR (100) NULL,
    CONSTRAINT [PK_Dim_Aendring_Kode_BU_150522_1_Efter_P04] PRIMARY KEY CLUSTERED ([Kode] ASC)
);


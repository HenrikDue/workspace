CREATE TABLE [ods].[TD_RIM_Rejser] (
    [Dagstype]       CHAR (1)     NULL,
    [Dato]           VARCHAR (50) NULL,
    [Togsystem]      INT          NULL,
    [TogsystemNavn]  VARCHAR (50) NULL,
    [Straekning_Fra] VARCHAR (10) NULL,
    [Straekning_Til] VARCHAR (10) NULL,
    [Gruppe]         VARCHAR (20) NULL,
    [Billetart_Nr]   INT          NULL,
    [Billetart_Navn] VARCHAR (50) NULL,
    [Delrejser]      FLOAT (53)   NULL,
    [Indtaegt_sum]   FLOAT (53)   NULL,
    [Indtaegt_avg]   FLOAT (53)   NULL,
    [Timestamp]      DATETIME     NULL,
    [Ugedag]         INT          NULL
);


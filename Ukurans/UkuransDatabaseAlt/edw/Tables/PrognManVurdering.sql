CREATE TABLE [edw].[PrognManVurdering] (
    [FraTil_Tid]       VARCHAR (13)    NULL,
    [Dim_Fabrik]       VARCHAR (10)    NULL,
    [Dim_Materiale]    INT             NULL,
    [Materiale]        VARCHAR (18)    NULL,
    [Beholdning]       DECIMAL (18, 3) NOT NULL,
    [AnskVaerdi]       DECIMAL (18, 3) NOT NULL,
    [NedskrNetto]      DECIMAL (18, 3) NOT NULL,
    [DUF]              INT             NULL,
    [RID]              INT             NULL,
    [NytMatKorr]       DECIMAL (18, 3) NOT NULL,
    [IndkLgKorr]       DECIMAL (18, 3) NOT NULL,
    [N_Pct]            DECIMAL (7, 5)  NOT NULL,
    [PrognManVurdMgd]  DECIMAL (38, 6) NULL,
    [PrognNettoNedskr] DECIMAL (38, 6) NULL
);


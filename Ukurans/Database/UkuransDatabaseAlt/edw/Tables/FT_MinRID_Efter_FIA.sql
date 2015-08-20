CREATE TABLE [edw].[FT_MinRID_Efter_FIA] (
    [Dim_Fabrik]         VARCHAR (10)    NULL,
    [Materiale]          VARCHAR (18)    NULL,
    [Dim_Materiale]      INT             NULL,
    [Dim_Tid]            VARCHAR (8)     NOT NULL,
    [Forbr_pr_dag]       DECIMAL (18, 3) NULL,
    [FraTil_Tid]         VARCHAR (13)    NOT NULL,
    [Beh_Primo]          DECIMAL (18, 3) NULL,
    [Beh_Efter_Forbr]    DECIMAL (18, 3) NULL,
    [MinRID_Efter_Forbr] DECIMAL (18, 6) NULL,
    [Beh_Efter_Indk]     DECIMAL (18, 3) NULL,
    [MinRID_Efter_Indk]  DECIMAL (18, 6) NULL,
    [Beh_Ultimo]         DECIMAL (18, 3) NULL,
    [MinRID_Ultimo]      DECIMAL (18, 6) NULL
);


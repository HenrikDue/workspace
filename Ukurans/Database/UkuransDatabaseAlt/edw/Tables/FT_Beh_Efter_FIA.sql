CREATE TABLE [edw].[FT_Beh_Efter_FIA] (
    [Dim_Fabrik]      VARCHAR (10)    NULL,
    [Materiale]       VARCHAR (18)    NULL,
    [Dim_Materiale]   INT             NULL,
    [Dim_Tid]         VARCHAR (8)     NOT NULL,
    [FraTil_Tid]      VARCHAR (13)    NOT NULL,
    [Beh_Primo]       DECIMAL (18, 3) NULL,
    [Forbr_Mgd]       DECIMAL (18, 3) NULL,
    [Beh_Efter_Forbr] DECIMAL (18, 3) NULL,
    [Forbr_Vd_SP]     DECIMAL (18, 3) NULL,
    [Indk_Mgd]        DECIMAL (18, 3) NULL,
    [Beh_Efter_Indk]  DECIMAL (18, 3) NULL,
    [Indk_Vd_SP]      DECIMAL (18, 3) NULL,
    [Anden_Bev_Mgd]   DECIMAL (18, 3) NULL,
    [Beh_Ultimo]      DECIMAL (18, 3) NULL,
    [Anden_Bev_Vd_SP] DECIMAL (18, 3) NULL
);


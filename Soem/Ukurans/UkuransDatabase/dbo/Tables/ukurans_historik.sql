﻿CREATE TABLE [dbo].[ukurans_historik] (
    [01_Fb]                  VARCHAR (6)     NOT NULL,
    [02_Mat]                 VARCHAR (18)    NOT NULL,
    [03_Materialetekst]      VARCHAR (50)    NOT NULL,
    [04_Mart]                VARCHAR (6)     NOT NULL,
    [05a_Forr_beh_12md]      NUMERIC (18, 2) NULL,
    [06a_Beh_indk_12md]      NUMERIC (18, 2) NULL,
    [07a_Beh_forbr_12md]     NUMERIC (18, 2) NULL,
    [08a_Delta_beh_12md]     NUMERIC (18, 2) NULL,
    [09_Nuv_beh]             NUMERIC (18, 2) NULL,
    [10_Lav_Nedskr_type]     VARCHAR (6)     NOT NULL,
    [11a_Forr_Nedskr_type]   VARCHAR (6)     NULL,
    [12_Rækk_dage]           NUMERIC (10)    NULL,
    [13_Dage_u_forbr]        NUMERIC (6)     NULL,
    [14_Litragr]             VARCHAR (18)    NULL,
    [15_Statusgr]            VARCHAR (18)    NULL,
    [16_Akt_Nedskr_pct]      NUMERIC (18, 2) NULL,
    [17_Forr_Nedskr_pct]     NUMERIC (18, 2) NULL,
    [18_Karens]              VARCHAR (6)     NOT NULL,
    [19_Ansk_gr_stk]         VARCHAR (50)    NOT NULL,
    [20_Ansk_gr_beh]         VARCHAR (50)    NOT NULL,
    [21_Hitliste]            VARCHAR (6)     NOT NULL,
    [41a_ForrLogNedskr]      NUMERIC (18, 2) NULL,
    [42a_GenvSfaKass]        NUMERIC (18, 2) NULL,
    [44a_GenvSfaAfg]         NUMERIC (18, 2) NULL,
    [45a_ØgetUkurSfaTilg]    NUMERIC (18, 2) NULL,
    [46a_UkuUændrMgd]        NUMERIC (18, 2) NULL,
    [47a_UkurNyFbMatKomb]    NUMERIC (18, 2) NULL,
    [48a_NedskrFørKorr]      NUMERIC (18, 2) NULL,
    [49a_NedskrKorrModÆndr]  NUMERIC (18, 2) NULL,
    [50a_NedskrAfstem]       NUMERIC (18, 2) NULL,
    [51a_UltimoLogNedskr]    NUMERIC (18, 2) NULL,
    [52a_MedskrÅbnBal]       NUMERIC (18, 2) NULL,
    [53a_NedskrKorrIndk]     NUMERIC (18, 2) NULL,
    [54a_UltimoNedskr2]      NUMERIC (18, 2) NULL,
    [55a_NedskrKorrKarens]   NUMERIC (18, 2) NULL,
    [56a_NedskrUltimoNetto]  NUMERIC (18, 2) NULL,
    [57a_NedskrTilgang]      NUMERIC (18, 2) NULL,
    [71a_ForrBehVærdi]       NUMERIC (18, 2) NULL,
    [72a_KassBehVærdi]       NUMERIC (18, 2) NULL,
    [74a_AfgBehVærdi]        NUMERIC (18, 2) NULL,
    [75a_TilgBehVærdi]       NUMERIC (18, 2) NULL,
    [76a_DeltaVdUændrMgd]    NUMERIC (18, 2) NULL,
    [77a_BehVdNyFbMatKomb]   NUMERIC (18, 2) NULL,
    [78a_BehVdAfstem]        NUMERIC (18, 2) NULL,
    [79a_UltimoBehVærdi]     NUMERIC (18, 2) NULL,
    [80a_DeltaBehVdEksKass]  NUMERIC (18, 2) NULL,
    [81a_DeltaBehVærdi]      NUMERIC (18, 2) NULL,
    [82a_BehVdÅbnBal]        NUMERIC (18, 2) NULL,
    [84a_BehVdIndkøb]        NUMERIC (18, 2) NULL,
    [98_FO]                  VARCHAR (6)     NULL,
    [05b_Forr_beh_Kaar]      NUMERIC (18, 2) NULL,
    [06b_Beh_indk_Kaar]      NUMERIC (18, 2) NULL,
    [07b_Beh_forbr_Kaar]     NUMERIC (18, 2) NULL,
    [08b_Delta_beh_Kaar]     NUMERIC (18, 2) NULL,
    [11b_Forr_Nedskr_type]   VARCHAR (6)     NULL,
    [41b_ForrLogNedskr]      NUMERIC (18, 2) NULL,
    [42b_GenvSfaKass]        NUMERIC (18, 2) NULL,
    [44b_GenvSfaAfg]         NUMERIC (18, 2) NULL,
    [45b_ØgetUkurSfaTilg]    NUMERIC (18, 2) NULL,
    [46b_UkuUændrMgd]        NUMERIC (18, 2) NULL,
    [47b_UkurNyFbMatKomb]    NUMERIC (18, 2) NULL,
    [48b_NedskrFørKorr]      NUMERIC (18, 2) NULL,
    [49b_NedskrKorrModÆndr]  NUMERIC (18, 2) NULL,
    [50b_NedskrAfstem]       NUMERIC (18, 2) NULL,
    [51b_UltimoLogNedskr]    NUMERIC (18, 2) NULL,
    [52b_MedskrÅbnBal]       NUMERIC (18, 2) NULL,
    [53b_NedskrKorrIndk]     NUMERIC (18, 2) NULL,
    [54b_UltimoNedskr2]      NUMERIC (18, 2) NULL,
    [55b_NedskrKorrKarens]   NUMERIC (18, 2) NULL,
    [56b_NedskrUltimoNetto]  NUMERIC (18, 2) NULL,
    [57b_NedskrTilgang]      NUMERIC (18, 2) NULL,
    [71b_ForrBehVærdi]       NUMERIC (18, 2) NULL,
    [72b_KassBehVærdi]       NUMERIC (18, 2) NULL,
    [74b_AfgBehVærdi]        NUMERIC (18, 2) NULL,
    [75b_TilgBehVærdi]       NUMERIC (18, 2) NULL,
    [76b_DeltaVdUændrMgd]    NUMERIC (18, 2) NULL,
    [77b_BehVdNyFbMatKomb]   NUMERIC (18, 2) NULL,
    [78b_BehVdAfstem]        NUMERIC (18, 2) NULL,
    [79b_UltimoBehVærdi]     NUMERIC (18, 2) NULL,
    [80b_DeltaBehVdEksKass]  NUMERIC (18, 2) NULL,
    [81b_DeltaBehVærdi]      NUMERIC (18, 2) NULL,
    [82b_BehVdÅbnBal]        NUMERIC (18, 2) NULL,
    [84b_BehVdIndkøb]        NUMERIC (18, 2) NULL,
    [05c_Forr_beh_Akvt]      NUMERIC (18, 2) NULL,
    [06c_Beh_indk_Akvt]      NUMERIC (18, 2) NULL,
    [07c_Beh_forbr_Akvt]     NUMERIC (18, 2) NULL,
    [08c_Delta_beh_Akvt]     NUMERIC (18, 2) NULL,
    [11c_Forr_Nedskr_type]   VARCHAR (6)     NULL,
    [41c_ForrLogNedskr]      NUMERIC (18, 2) NULL,
    [42c_GenvSfaKass]        NUMERIC (18, 2) NULL,
    [44c_GenvSfaAfg]         NUMERIC (18, 2) NULL,
    [45c_ØgetUkurSfaTilg]    NUMERIC (18, 2) NULL,
    [46c_UkuUændrMgd]        NUMERIC (18, 2) NULL,
    [47c_UkurNyFbMatKomb]    NUMERIC (18, 2) NULL,
    [48c_NedskrFørKorr]      NUMERIC (18, 2) NULL,
    [49c_NedskrKorrModÆndr]  NUMERIC (18, 2) NULL,
    [50c_NedskrAfstem]       NUMERIC (18, 2) NULL,
    [51c_UltimoLogNedskr]    NUMERIC (18, 2) NULL,
    [52c_MedskrÅbnBal]       NUMERIC (18, 2) NULL,
    [53c_NedskrKorrIndk]     NUMERIC (18, 2) NULL,
    [54c_UltimoNedskr2]      NUMERIC (18, 2) NULL,
    [55c_NedskrKorrKarens]   NUMERIC (18, 2) NULL,
    [56c_NedskrUltimoNetto]  NUMERIC (18, 2) NULL,
    [57c_NedskrTilgang]      NUMERIC (18, 2) NULL,
    [71c_ForrBehVærdi]       NUMERIC (18, 2) NULL,
    [72c_KassBehVærdi]       NUMERIC (18, 2) NULL,
    [74c_AfgBehVærdi]        NUMERIC (18, 2) NULL,
    [75c_TilgBehVærdi]       NUMERIC (18, 2) NULL,
    [76c_DeltaVdUændrMgd]    NUMERIC (18, 2) NULL,
    [77c_BehVdNyFbMatKomb]   NUMERIC (18, 2) NULL,
    [78c_BehVdAfstem]        NUMERIC (18, 2) NULL,
    [79c_UltimoBehVærdi]     NUMERIC (18, 2) NULL,
    [80c_DeltaBehVdEksKass]  NUMERIC (18, 2) NULL,
    [81c_DeltaBehVærdi]      NUMERIC (18, 2) NULL,
    [82c_BehVdÅbnBal]        NUMERIC (18, 2) NULL,
    [84c_BehVdIndkøb]        NUMERIC (18, 2) NULL,
    [90_MRP_Contr]           VARCHAR (6)     NULL,
    [91_MRP_Type]            VARCHAR (6)     NULL,
    [92_ABC_IN]              VARCHAR (6)     NULL,
    [93_VareGrp]             VARCHAR (18)    NULL,
    [94_IK_Grp]              VARCHAR (6)     NULL,
    [95_VareGrpTekst]        VARCHAR (20)    NULL,
    [96a_Delta_beholdning]   NUMERIC (18, 2) NULL,
    [96b_Delta_Beh_værdi]    NUMERIC (18, 2) NULL,
    [96c_Delta_Nedskr_Log]   NUMERIC (18, 2) NULL,
    [96d_Delta_Nedskr_Netto] NUMERIC (18, 2) NULL,
    [96e_Forr_Nedskr_Type]   VARCHAR (6)     NULL,
    [96f_Forr_Rækk_dage]     NUMERIC (10)    NULL,
    [96g_Delta_Rækk_dage]    NUMERIC (10)    NULL,
    [96h_Forr_Dage_u_Forbr]  NUMERIC (6)     NULL,
    [96i_Delta_Dage_u_Forbr] NUMERIC (6)     NULL,
    [Beregning]              NVARCHAR (10)   NULL
);


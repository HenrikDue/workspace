
:CONNECT oesmsqlt01\soem
SELECT  *  
FROM  mdw_udv1.
[ods].[MD_G_STAM_Ejendomme]
--[ods].[MD_G_STAM_Togsystem]
--[ods].[MD_G_STAM_Timer_Grp_Togførertid]
--[ods].[MD_G_STAM_Timer_Grp_Lokoførertid_STog]
--[ods].[MD_G_STAM_Timer_Grp_Lokoførertid]
--[ods].[MD_G_STAM_Stationer]
--[ods].[MD_G_STAM_Litra]
--[ods].[MD_G_STAM_Ejendomme_udlejningsenheder]
--[ods].[MD_G_STAM_Depoter]
go

:CONNECT mssqlp01\alpha
SELECT  *  
FROM  mdw.
[ods].[MD_G_STAM_Ejendomme]
--[ods].[MD_G_STAM_Togsystem]
--[ods].[MD_G_STAM_Timer_Grp_Togførertid]
--[ods].[MD_G_STAM_Timer_Grp_Lokoførertid_STog]
--[ods].[MD_G_STAM_Timer_Grp_Lokoførertid]
--[ods].[MD_G_STAM_Stationer]
--[ods].[MD_G_STAM_Litra]
--[ods].[MD_G_STAM_Ejendomme_udlejningsenheder]
--[ods].[MD_G_STAM_Depoter]
go



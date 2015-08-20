﻿CREATE view [dbo].[vw_NedskrSfaStatPae_20141110]
as
-- Kalkuler nedskrivningsprocent som følge af ekstraordinær nedskrivning
Select ftd.Dim_Materiale, ftd.Materiale, ftd.Dim_Tid
,dsh.StatusGr2
,ftd.MinDuf
,dsh.DUF_NedskrAar as StatusDUF_NedskrAar	
,	Case when ftd.MinDUF Is Null and dsh.StatusGr2 <> 'USN' then 0
		when ftd.MinDUF < 366 and dsh.StatusGr2 <> 'USN' then 0
		when ftd.MinDUF > 2555 and dsh.StatusGr2 <> 'USN' then -1
		when dsh.DUF_NedskrAar = 3 then md.Tidshorisont3
		when dsh.DUF_NedskrAar = 5 then md.Tidshorisont5
		when dsh.DUF_NedskrAar = 7 then md.Tidshorisont7
		Else Null
	End as StatusNedskrPct
From edw.ft_MinDUF ftd 
Left Join [edw].[Dim_Materiale] dm 
On ftd.Materiale = dm.Materiale
   and (select convert(datetime, substring(replace(convert(varchar, dm.GyldigFra, 102), '.', '-'), 1, 8) + '01'))
		 <= (select left(Vaerdi, 8) + '01' from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') /*comparation date-parametrizes*/
   and dm.GyldigTil >= ( select Vaerdi from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')

Left Join edw.[Dim_Litra] dlh 
On dm.Litra_PKID = dlh.PK_ID
Left Join [ods].[MD_MatDUF_NedskrPct] md 
On ftd.MinDUF = md.DUF
Left Join [edw].[Dim_StatusHierarki] dsh 
on dm.StatusGr2 = dsh.StatusGr2 and dsh.GyldigTil = '9999-12-31'
Where 
ftd.Dim_Tid = (select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
and dm.OmlVare is null 
	and ftd.MinDUF > 365
	and dsh.StatusGr2 <> 'USN'
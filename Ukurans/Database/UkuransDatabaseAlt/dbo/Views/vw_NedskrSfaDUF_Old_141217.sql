CREATE view [dbo].[vw_NedskrSfaDUF_Old_141217]
as
Select ftm.Materiale, ftm.Dim_Materiale, ftm.Dim_Tid
,ftm.MinDuf
,dm.LitraGr2
,dlh.DUF_NedskrAar
,	Case when ftm.MinDUF < 366 then 0		-- Tilføjet 140505-1
		 when ftm.MinDUF > 2555 then -1
		 when dlh.DUF_NedskrAar = 3 then md.Tidshorisont3
		 when dlh.DUF_NedskrAar = 5 then md.Tidshorisont5
		 when dlh.DUF_NedskrAar = 7 then md.Tidshorisont7
		 Else Null
	End as LangNedskrPct
From [edw].[ft_MinDUF] ftm
Left Join [edw].[Dim_Materiale] dm
On ftm.Dim_Materiale = dm.pk_id 
Left Join edw.[Dim_Litra] dlh 
On dm.Litra_PKID = dlh.PK_ID
full outer Join [ods].[MD_MatDUF_NedskrPct] md 
On ftm.MinDUF = md.DUF
Where ftm.Dim_Tid= ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')
	and dm.OmlVare is null
--	and ftm.MinDUF > 365
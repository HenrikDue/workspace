
CREATE view [dbo].[vw_NedskrSfaRID_Efter_Forbr] -- OK
-- Oprettet 150818-1: Kalkuler nedskrivningsprocent som følge af lang rækkevidde efter forbrug
as
Select ftm.Dim_Fabrik															-- Nyt felt
,ftm.Materiale
,ftm.Dim_Materiale
,ftm.Dim_Tid
,dlh.LitraGr2
,dlh.RID_NedskrTekst
,dlh.RID_NedskrFaktor
,ftm.MinRID_Efter_Forbr															-- Andet feltnavn
,ftm.Forbr_pr_dag																-- Andet feltnavn
,Case	when ftm.MinRID_Efter_Forbr > 365										-- Andet feltnavn
		then Power(dlh.RID_NedskrFaktor,ftm.MinRID_Efter_Forbr)-1				-- Andet feltnavn
		else 0 
 end As RaekkeNedskrPct
From edw.FT_MinRID_Efter_FIA ftm												-- Anden tabel
Left join edw.Dim_Materiale dm On ftm.Dim_Materiale = dm.pk_id 
Left join edw.Dim_Litra dlh On dm.Litra_PKID = dlh.PK_ID
Where ftm.Dim_Tid =  ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')
	and dm.OmlVare is null 
--	and ftm.MinRID > 365
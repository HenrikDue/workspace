﻿









Create view [dbo].[vw_Flg_Indk12md] 
-- Oprettet 150220-1: Flag for hvilke materialer, der set fra Til-perioden har været købt beholdning til indenfor seneste 12 måneder
-- Ajourført 150311-1: Ændret kriterie til at være fra BogfDato >= til BogfDato >
-- Ajourført 150312-1: Ændret kriterie til at være fra beregnet ud fra ultimo periode - 365 hhv. 366 dage
-- Ajourført 150316-1: Ændret kriterie til at være fra BogfDato > til RegistrDato >
as
Select distinct q3.FraTil_Tid, q3.Materiale, max(q3.Flg_Indkoebte) as Flg_Indk12md
from (
Select distinct q2.FraTil_Tid, q2.Materiale,
case when max(q2.SidsteTransDato) <> '1900-01-01 00:00:00.000' and q2.BevArtType = 'Indkøb' then 1 else 0 end as Flg_Indkoebte
From
	(Select  distinct a.FraTil_Tid, q1.Materiale, max(isnull(q1.RegistrDato,0)) as SidsteTransDato, q1.BevArtType, count(*) as Antal
	From edw.FT_Forklaring a
	Left join (	Select distinct a.Materiale, a.FraTil_Tid, b.RegistrDato, c.BevArtType
				From edw.FT_Forklaring a
				Left join edw.FT_Transaktioner b on a.Materiale = b.Materiale
					and RegistrDato > (
									Select distinct cast(substring(a.FraTil_Tid,8,4)+'-'+substring(a.FraTil_Tid,12,2)+'-'
									+	case	when substring(a.FraTil_Tid,12,2) in ('01' , '03' , '05' , '07' , '08' , '10' , '12' )	then + '31'
												when substring(a.FraTil_Tid,12,2) in ('04' , '06' , '09' , '11' ) then + '30'
												else	case	when substring(a.FraTil_Tid,8,4) in ( '2016' , '2020' , '2024' , '2028' ) 
																then '29' 
																else '28' 
														end
												end	as datetime) + 1 - case when left(a.FraTil_Tid,4) in ( '2016' , '2020' , '2024' , '2028' ) 
																			then 366 
																			else 365 
																	   end
									--as Fra_dato
									)
					and RegistrDato <= (
									Select distinct cast(substring(a.FraTil_Tid,8,4)+'-'+substring(a.FraTil_Tid,12,2)+'-'
									+	case	when substring(a.FraTil_Tid,12,2) in ('01' , '03' , '05' , '07' , '08' , '10' , '12' )	then + '31'
												when substring(a.FraTil_Tid,12,2) in ('04' , '06' , '09' , '11' ) then + '30'
												else	case	when substring(a.FraTil_Tid,8,4) in ( '2016' , '2020' , '2024' , '2028' ) 
																then '29' 
																else '28' 
														end
												end	as datetime) + 1
									--as Fra_dato
									)												
				Left join edw.Dim_BevArt c on b.Dim_BevArt = c.BevArt
--				Where c.BevArtType = 'Indkøb'
				) q1 on a.FraTil_Tid = q1.FraTil_Tid and a.Materiale = q1.Materiale	
	Group by a.FraTil_Tid, q1.Materiale, q1.RegistrDato, q1.BevArtType
	--With rollup
--	Order by q1.Materiale, a.FraTil_Tid, max(isnull(q1.RegistrDato,0))
) q2
Where Materiale is not null
Group by q2.Materiale, q2.FraTil_Tid, q2.BevArtType
--Order by q2.Materiale, q2.FraTil_Tid
) q3
Group by q3.Materiale, q3.FraTil_Tid
--Order by q3.Materiale, q3.FraTil_Tid
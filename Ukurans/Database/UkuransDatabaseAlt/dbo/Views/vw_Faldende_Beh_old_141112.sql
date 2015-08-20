


CREATE view [dbo].[vw_Faldende_Beh_old_141112]
-- Ajourført 141112-1: Indarbejdet fradrag for kasserede materialer, der ikke skal medtages under faldende beholdninger

as
Select q1.Dim_Fabrik, q1.Dim_Materiale, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid, sum(q1.ly_Beholdning) as ly_Beholdning, sum(q1.Beholdning) Beholdning, 
sum(q1.Cy_Beholdning) as Cy_Beholdning, sum(q1.AnskVaerdi) AnskVaerdi, sum(q1.kas_AnskVaerdi) as kas_AnskVaerdi, Sum(q1.ly_LogNedBrutto) as ly_LogNedBrutto, sum(q1.kas_NedForPrinc) as kas_NedForPrinc,
sum(q1.NedForPrinc) NedForPrinc, sum(q1.NedskrNetto) NedskrNetto, sum(q1.Vaerdi_SP) Vaerdi_SP, sum(q1.ly_NedskrNetto) as ly_NedskrNetto, sum(q1.kas_NedskrNetto) as kas_NedskrNetto
from (
select  isnull(cy.Dim_Fabrik, isnull(ly.Dim_Fabrik, cy.Dim_Fabrik)) Dim_Fabrik, 
 isnull(cy.Dim_Materiale, isnull(ly.Dim_Materiale, cy.Dim_Materiale)) Dim_Materiale,
isnull(cy.Materiale, isnull(ly.Materiale, cy.Materiale)) Materiale,

ly.Beholdning as ly_Beholdning, cy.Beholdning as Cy_Beholdning, kas.AnskVaerdi as kas_AnskVaerdi, ly.LogNedBrutto as ly_LogNedBrutto, kas.NedForPrinc as kas_NedForPrinc,
ly.NedskrNetto as ly_NedskrNetto, kas.NedskrNetto as kas_NedskrNetto,

isnull(cy.LNType, 'AUB') as LNType,
isnull(ly.LNType, 'AEPD') as FLNType,
( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') + '-' +( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') FraTil_tid,
Case When isnull(ly.Beholdning, 0) > 0	
	 Then Case When	isnull(ly.Beholdning, 0) > isnull(cy.Beholdning, 0)	
			   Then Case When isnull(cy.Beholdning, 0) = 0	
						Then Case When	kas.Beholdning	is null	
								   Then (isnull(ly.Beholdning, 0) * -1)
								   Else	(isnull(ly.Beholdning, 0) * -1) - kas.Beholdning
								   End
						Else Case When kas.Beholdning	is null	
								   Then	isnull(cy.Beholdning, 0) -ly.Beholdning
								   Else	isnull(cy.Beholdning, 0) -ly.Beholdning - kas.Beholdning
								   End
						End
				Else	0
				End
		Else 0
		End as Beholdning,
Case When isnull(ly.Beholdning, 0) > 0	
	 Then Case When isnull(ly.Vaerdi_GP, 0) > 0	
			   Then Case When isnull(ly.Beholdning, 0) > isnull(cy.Beholdning, 0)
						 Then Case When isnull(cy.Beholdning, 0) = 0	
								   Then Case When kas.AnskVaerdi is null
											 Then (isnull(ly.Vaerdi_GP, 0) * -1) 
											 Else (isnull(ly.Vaerdi_GP, 0) * -1) - kas.AnskVaerdi
											 End
								   Else Case When kas.AnskVaerdi is null
											Then	(((isnull(ly.Vaerdi_GP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0) - isnull(cy.Beholdning, 0)))
											 Else	((isnull(ly.Vaerdi_GP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)) - kas.AnskVaerdi
											End
								   End
						 Else	0
						 End
				Else	0
				End
		Else 0
		End as AnskVaerdi,
Case When ly.Beholdning > 0	
	 Then Case When	isnull(ly.LogNedBrutto, 0) < 0	
			   Then Case When isnull(ly.Beholdning, 0) > isnull(cy.Beholdning, 0)	
						 Then Case When isnull(cy.Beholdning, 0) = 0	
								   Then Case When kas.AnskVaerdi is null
											 Then (isnull(ly.LogNedBrutto, 0) * -1) 
											 Else (isnull(ly.LogNedBrutto, 0) * -1) - kas.NedForPrinc
											 End
								   Else Case When kas.AnskVaerdi is null
											 Then (((isnull(ly.LogNedBrutto, 0) * -1) /isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)))---isnull(kas.NedskrNetto, 0)
											 Else ((isnull(ly.LogNedBrutto, 0) * -1) /isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)) - kas.NedForPrinc
											 End
								   End
						  Else	0
						  End
				Else 0	
				End
	  Else 0
      End as NedForPrinc,
Case When isnull(ly.Beholdning, 0) >	0	
	 Then Case When isnull(ly.LogNedBrutto, 0) <	0	
			   Then Case When isnull(ly.Beholdning, 0) > isnull(cy.Beholdning, 0)
						 Then Case When	isnull(cy.Beholdning, 0) =	0	
								   Then Case When kas.AnskVaerdi is null
											 Then (isnull(ly.NedskrNetto, 0) * -1) 
											 Else (isnull(ly.NedskrNetto, 0) * -1) - kas.NedskrNetto
											 End
								   Else Case When kas.AnskVaerdi is null
											Then	(((isnull(ly.NedskrNetto, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0) - isnull(cy.Beholdning, 0)))
											 Else	((isnull(ly.NedskrNetto, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)) - kas.NedskrNetto
											End
								   End
						 Else	0
						 End
				Else	0
				End
	 Else 0
	 End as	NedskrNetto,
Case When isnull(ly.Beholdning, 0) > 0	
	  Then Case When ly.Vaerdi_SP > 0	
				Then Case When isnull(ly.Beholdning, 0) > isnull(cy.Beholdning, 0)
						  Then Case When isnull(cy.Beholdning, 0) =	0	
								   Then Case When kas.AnskVaerdi is null
											 Then (isnull(ly.Vaerdi_SP, 0) * -1) 
											 Else (isnull(ly.Vaerdi_SP, 0) * -1) - kas.Vaerdi_SP
											 End
								   Else Case When kas.AnskVaerdi is null
											Then	(((isnull(ly.Vaerdi_SP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0) - isnull(cy.Beholdning, 0)))
											 Else	((isnull(ly.Vaerdi_SP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)) - kas.Vaerdi_SP
												End
								   End
   						  Else	0
						  End
				Else	0
				End
	  Else 0
	  End as Vaerdi_SP

from (select Dim_Fabrik, Dim_Materiale, Materiale, LogNedBrutto, NedskrNetto, LNType, LavNedPct,
			 Vaerdi_GP as Vaerdi_GP, beholdning as Beholdning, Vaerdi_SP
      from edw.ft_Nedskriv where Dim_Tid = ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
      and substring(Dim_Fabrik, 1, 2) = '21') ly
--on kas.Dim_Fabrik = ly.Dim_Fabrik and kas.Materiale = ly.Materiale
full outer join
(select Dim_Fabrik, Dim_Materiale, Materiale, LogNedBrutto, NedskrNetto, LNType, LavNedPct,
			 Vaerdi_GP, Vaerdi_SP, Beholdning
      from dbo.vw_Nedskriv
      where substring(Dim_Fabrik, 1, 2) = '21') cy
on ly.Dim_Fabrik = cy.Dim_Fabrik and ly.Materiale = cy.Materiale
full outer join dbo.[vw_kassation_Temp] kas
on ly.Dim_Fabrik = kas.Dim_Fabrik and ly.Dim_Materiale = kas.Dim_Materiale
--left join 
--     (select Dim_Fabrik, Dim_Materiale,  Materiale, LogNedBrutto, NedskrNetto, LNType, LavNedPct
--      from edw.ft_Nedskriv where Dim_Tid = '201311'
--      and substring(Dim_Fabrik, 1, 2) = '21') nsly
--on ly.Dim_Fabrik = nsly.Dim_Fabrik and ly.Materiale = nsly.Materiale
--where isnull(ly.Vaerdi_GP, 0) > 0
--and substring(ly.Dim_Fabrik, 1, 2) = '21'
) q1
where -- materiale in ('820605725', '773302610') and
 (isnull(q1.Beholdning, 0) <> 0 or isnull(q1.NedForPrinc, 0) <> 0
or isnull(q1.NedskrNetto, 0) <> 0 or isnull(q1.Vaerdi_SP, 0) <> 0 
)
group by q1.Dim_Fabrik, q1.Dim_Materiale, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid

-- Order by Materiale
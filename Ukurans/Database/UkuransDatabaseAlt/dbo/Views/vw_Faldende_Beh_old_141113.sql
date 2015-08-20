

CREATE view [dbo].[vw_Faldende_Beh_old_141113]


as
select q1.Dim_Fabrik, q1.Dim_Materiale, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid, sum(q1.Beholdning) Beholdning, 
sum(q1.AnskVaerdi) AnskVaerdi, sum(q1.NedForPrinc) NedForPrinc, sum(q1.NedskrNetto) NedskrNetto, sum(q1.Vaerdi_SP) Vaerdi_SP
from (
select  isnull(cy.Dim_Fabrik, isnull(ly.Dim_Fabrik, cy.Dim_Fabrik)) Dim_Fabrik, 
 isnull(cy.Dim_Materiale, isnull(ly.Dim_Materiale, cy.Dim_Materiale)) Dim_Materiale,
isnull(cy.Materiale, isnull(ly.Materiale, cy.Materiale)) Materiale,
isnull(cy.LNType, 'AUB') as LNType,
isnull(ly.LNType, 'AEPD') as FLNType,
( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') + '-' +( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') FraTil_tid,
Case When isnull(ly.Beholdning, 0) > 0	
	 Then Case When	isnull(ly.Beholdning, 0) > isnull(cy.Beholdning, 0)	
			   Then Case When isnull(cy.Beholdning, 0) = 0	
						-- Then Case When	kas.Beholdning	is not null	
						--		   Then (isnull(ly.Beholdning, 0) * -1)--- kas.Beholdning	
						--		   Else	(isnull(ly.Beholdning, 0) * -1)
						--		   End
						-- Else Case When kas.Beholdning	is not null	
								   Then	(isnull(ly.Beholdning, 0) * -1) + isnull(cy.Beholdning, 0) --- kas.Beholdning
								   Else	(isnull(ly.Beholdning, 0) * -1) + isnull(cy.Beholdning, 0)
								   End
						-- End
				Else	0
				End
		Else 0
		End as Beholdning,
Case When isnull(ly.Beholdning, 0) > 0	
	 Then Case When isnull(ly.Vaerdi_GP, 0) > 0	
			   Then Case When isnull(ly.Beholdning, 0) > isnull(cy.Beholdning, 0)
						 Then Case When isnull(cy.Beholdning, 0) = 0	
						--		   Then Case When kas.AnskVaerdi is not null
						--					 Then (isnull(ly.Vaerdi_GP, 0) * -1) --- isnull(kas.AnskVaerdi, 0)
						--					 Else (isnull(ly.Vaerdi_GP, 0) * -1)
						--					 End
						--		   Else Case When kas.AnskVaerdi is not null
											 Then	(((isnull(ly.Vaerdi_GP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0) - isnull(cy.Beholdning, 0)))--- isnull(kas.AnskVaerdi, 0)
											 Else	((isnull(ly.Vaerdi_GP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0))
											 End
						--		   End
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
--								   Then Case When isnull(kas.NedskrNetto, 0) is not null	
--											 Then (isnull(nsly.LogNedBrutto, 0) * -1) --- isnull(kas.NedskrNetto, 0)
--											 Else (isnull(nsly.LogNedBrutto, 0) * -1)
--											 End
--									Else Case When isnull(kas.NedskrNetto, 0)	is not null	
											  Then (((isnull(ly.LogNedBrutto, 0) * -1) /isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)))---isnull(kas.NedskrNetto, 0)
											  Else ((isnull(ly.LogNedBrutto, 0) * -1) /isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0))
											  End
--									End
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
--								   Then	Case When kas.NedskrNetto is not null	
--											 Then (isnull(nsly.LogNedBrutto, 0) * -1)--- kas.NedskrNetto	 		
--											 Else (isnull(nsly.LogNedBrutto, 0) * -1)
--											 End
--								   Else Case When kas.NedskrNetto is not null	
											 Then (((isnull(ly.LogNedBrutto, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)))--- kas.NedskrNetto
											 Else	((isnull(ly.LogNedBrutto, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0))
											 End
--								   End
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
--									Then Case When kas.AnskVaerdi is not null	
--											  Then (isnull(ly.Vaerdi_SP, 0) * -1)--- kas.AnskVaerdi	
--											  Else (isnull(ly.Vaerdi_SP, 0) * -1)
--											  End
--									Else Case When kas.AnskVaerdi is not null	
											  Then (((isnull(ly.Vaerdi_SP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0)))--- kas.AnskVaerdi
											  Else ((isnull(ly.Vaerdi_SP, 0) * -1)/isnull(ly.Beholdning, 0))*(isnull(ly.Beholdning, 0)-isnull(cy.Beholdning, 0))
											  End
--									End
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
			 Vaerdi_GP, Beholdning
      from dbo.vw_Nedskriv
      where substring(Dim_Fabrik, 1, 2) = '21') cy
on ly.Dim_Fabrik = cy.Dim_Fabrik and ly.Materiale = cy.Materiale
--full outer join dbo.[vw_kassation_201312-201401] kas
--on ly.Dim_Fabrik = kas.Dim_Fabrik and ly.Materiale = kas.Materiale
--left join 
--     (select Dim_Fabrik, Dim_Materiale,  Materiale, LogNedBrutto, NedskrNetto, LNType, LavNedPct
--      from edw.ft_Nedskriv where Dim_Tid = '201311'
--      and substring(Dim_Fabrik, 1, 2) = '21') nsly
--on ly.Dim_Fabrik = nsly.Dim_Fabrik and ly.Materiale = nsly.Materiale
--where isnull(ly.Vaerdi_GP, 0) > 0
--and substring(ly.Dim_Fabrik, 1, 2) = '21'
) q1
where isnull(q1.Beholdning, 0) <> 0 or isnull(q1.NedForPrinc, 0) <> 0
or isnull(q1.NedskrNetto, 0) <> 0 or isnull(q1.Vaerdi_SP, 0) <> 0
group by q1.Dim_Fabrik, q1.Dim_Materiale, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid
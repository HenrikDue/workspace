

CREATE view [dbo].[vw_Samme_Beh_old_150112]
as
-- Ajourført 150112-1: Ændret kriterie for ly-join til FraTil_Tid og rettet ly-periode med ny PrimoPrimoDatokriterie for ly-join 
--	til FraTil_Tid og rettet ly-periode med ny PrimoPrimoDato (efter tankeløs sletning)

select q1.Dim_Materiale, q1.Dim_Fabrik, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid, 
sum(q1.AnskVaerdi) AnskVaerdi,
0 Beholdning, sum(q1.NedForPrinc) NedForPrinc, sum(q1.NedskrNetto) NedskrNetto, sum(q1.Vaerdi_SP) Vaerdi_SP
from (
select 
isnull(cy.Dim_Materiale, isnull(ly.Dim_Materiale, cy.Dim_Materiale)) Dim_Materiale, 
isnull(cy.Dim_Fabrik, isnull(ly.Dim_Fabrik, cy.Dim_Fabrik)) Dim_Fabrik, 
isnull(cy.Materiale, isnull(ly.Materiale, cy.Materiale)) Materiale, 
isnull(cy.LNType, 'AUB') as LNType,
isnull(ly.LNType, 'AEPD') as FLNType,
cast(( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') 
+ '-' +( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') as varchar(13)) as FraTil_tid,
Case When cy.Beholdning > 0 and  ly.Beholdning >	0
	 Then Case When isnull(cy.Beholdning, 0) >= isnull(ly.Beholdning, 0)
			   Then ((isnull(cy.Vaerdi_GP, 0) / isnull(cy.Beholdning, 0)) - (isnull(ly.Vaerdi_GP, 0) / isnull(ly.Beholdning, 0))) * isnull(ly.Beholdning, 0)
			   Else ((isnull(cy.Vaerdi_GP, 0) / isnull(cy.Beholdning, 0)) - (isnull(ly.Vaerdi_GP, 0) / isnull(ly.Beholdning, 0))) * isnull(cy.Beholdning, 0)
			   End
	 Else	Null


	 End as	 AnskVaerdi,
Case When isnull(cy.Beholdning, 0) > 0 and isnull(ly.Beholdning, 0) > 0
	 		   Then Case When isnull(cy.Beholdning, 0) >= isnull(ly.Beholdning, 0)
						  Then ((isnull(cy.LogNedBruttoPae, 0) / isnull(cy.Beholdning, 0)) - (isnull(ly.LogNedBrutto, 0) / isnull(ly.Beholdning, 0))) * isnull(ly.Beholdning, 0)
						  Else ((isnull(cy.LogNedBruttoPae, 0) / isnull(cy.Beholdning, 0)) - (isnull(ly.LogNedBrutto, 0) / isnull(ly.Beholdning, 0))) * isnull(cy.Beholdning, 0)
						  End
				Else null
				End
	  as NedForPrinc,
Case When isnull(cy.Beholdning, 0) > 0 and isnull(ly.Beholdning, 0) > 0
	 Then Case When isnull(cy.Beholdning, 0) >= isnull(ly.Beholdning, 0)
			   Then (((isnull(cy.LogNedBrutto, 0) / isnull(cy.Beholdning, 0)) - (isnull(ly.LogNedBrutto, 0) / isnull(ly.Beholdning, 0)))) * isnull(ly.Beholdning, 0)
			   Else (((isnull(cy.LogNedBrutto, 0) / isnull(cy.Beholdning, 0)) - (isnull(ly.LogNedBrutto, 0) / isnull(ly.Beholdning, 0)))) * isnull(cy.Beholdning, 0)
			   End
	  Else	Null
	  End as NedskrNetto,
Case When isnull(cy.Vaerdi_SP, 0) > 0 and isnull(cy.Beholdning, 0) > 0 and isnull(ly.Beholdning, 0) > 0
	 Then Case When isnull(cy.Beholdning, 0) >= isnull(ly.Beholdning, 0)
			   Then (((isnull(cy.Vaerdi_SP, 0) / isnull(cy.Beholdning, 0)) - ( isnull(ly.Vaerdi_SP, 0) / isnull(ly.Beholdning, 0)))) * isnull(ly.Beholdning, 0)
			   Else (((isnull(cy.Vaerdi_SP, 0) / isnull(cy.Beholdning, 0)) - ( isnull(ly.Vaerdi_SP, 0) / isnull(ly.Beholdning, 0)))) * isnull(cy.Beholdning, 0)
			   End
	 Else 0
	 End as	Vaerdi_SP
from (select Dim_Fabrik, Dim_Materiale, Materiale, Vaerdi_GP, Beholdning, Vaerdi_SP, 
      LogNedBrutto, LogNedBruttoPae, NedskrNetto, LNType, LavNedPct
      from dbo.vw_Nedskriv) cy
full outer join
     (select Dim_Fabrik, Dim_Materiale, Materiale, Vaerdi_GP Vaerdi_GP, beholdning Beholdning, Vaerdi_SP,
      LogNedBrutto, NedskrNetto, LNType, LavNedPct
      from edw.ft_Nedskriv Where FraTil_Tid = (select replace(left(Vaerdi, 7), '-', '') 
													from [edw].[MD_Styringstabel] where parameter = 'PrimoPrimoDato') + '-' 
											     +(select replace(left(Vaerdi, 7), '-', '') 
													from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
      ) ly
on cy.Dim_Fabrik = ly.Dim_Fabrik and cy.Materiale = ly.Materiale
where
ly.Dim_Fabrik is not null and ly.Dim_Materiale is not null
) q1
group by q1.Dim_Materiale, q1.Dim_Fabrik, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid
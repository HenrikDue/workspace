﻿




CREATE view [dbo].[vw_Stigende_Beh_old_150115]
-- Ajourført 141114-1: Ændret FraTil_Tid med en Cast, da det fyldte 8000...
-- Ajourført 141117-1: Indarbejdet kassation i stigningen med en outer join og beregning i felterne fra Beholdning til NedskrNetto
-- Ajourført 141117-2: Forenklet case/when så der ikke analyseres på om der er beholdning hhv. værdi forrige periode
as
Select q1.Dim_Materiale, q1.Dim_Fabrik, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid, sum(q1.Beholdning) Beholdning, sum(q1.behly) ForrigBeh,
sum(q1.AnskVaerdi) AnskVaerdi, sum(q1.NedForPrinc) NedForPrinc, sum(q1.NedskrNetto) NedskrNetto, sum(q1.Vaerdi_SP) Vaerdi_SP
from (
	select isnull(cy.Dim_Materiale, isnull(ly.Dim_Materiale, cy.Dim_Materiale)) Dim_Materiale, 
	isnull(cy.Dim_Fabrik, isnull(ly.Dim_Fabrik, cy.Dim_Fabrik)) Dim_Fabrik, 
	isnull(cy.Materiale, isnull(ly.Materiale, cy.Materiale)) Materiale, ly.Beholdning behly,
	isnull(cy.LNType, 'AUB') as LNType,
	isnull(ly.LNType, 'AEPD') as FLNType,
	Cast(( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') 
		+ '-' +( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') 
		as Varchar (13)) as FraTil_tid,

	  Case	When (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0)) > isnull(ly.Beholdning, 0)	
			Then (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0)) - isnull(ly.Beholdning, 0)
							
			Else	0
	  End as Beholdning,

	  Case  When isnull(cy.Vaerdi_SP, 0) > 0
			Then Case	When (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0)) > isnull(ly.Beholdning, 0)
						Then (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0) - isnull(ly.Beholdning, 0)) 
						   * (isnull(cy.Vaerdi_SP, 0) / isnull(cy.Beholdning, 0)) 
						Else 0
				 End
			Else 0
	  End as Vaerdi_SP,

	  Case  When isnull(cy.Vaerdi_GP, 0) > 0
			Then Case	When (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0)) > isnull(ly.Beholdning, 0)
						Then (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0) - isnull(ly.Beholdning, 0)) 
						   * (isnull(cy.Vaerdi_GP, 0) / isnull(cy.Beholdning, 0)) 
						Else 0
				 End
			Else 0
	  End as AnskVaerdi,

	-- ly.LogNedBrutto as lyLogNedBr, cy.LogNedBrutto as nscyLogNedBr,

	  Case  When isnull(cy.LogNedBruttoPae, 0) < 0
			Then Case	When (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0)) > isnull(ly.Beholdning, 0)
						Then (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0) - isnull(ly.Beholdning, 0)) 
						   * (isnull(cy.LogNedBruttoPae, 0) / isnull(cy.Beholdning, 0)) 
						Else 0
				 End
			Else 0
	  End as NedForPrinc,

	  Case  When isnull(cy.LogNedBrutto, 0) < 0
			Then Case	When (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0)) > isnull(ly.Beholdning, 0)
						Then (isnull(cy.Beholdning, 0) - isnull(kas.Beholdning, 0) - isnull(ly.Beholdning, 0)) 
						   * (isnull(cy.LogNedBrutto, 0) / isnull(cy.Beholdning, 0)) 
						Else 0
				 End
			Else 0
	  End as NedskrNetto

	from 
	(select Dim_Fabrik, Dim_Materiale, Materiale,  LogNedBrutto, LogNedBruttoPae, NedskrNetto, LNType, LavNedPct, Vaerdi_GP, Vaerdi_SP, Beholdning
		  from dbo.vw_Nedskriv--( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')
		  where substring(Dim_Fabrik, 1, 2) = '21') cy

Full outer join
	(select Dim_Fabrik, Dim_Materiale, Materiale,  LogNedBrutto, LogNedBruttoPae, NedskrNetto, LNType, LavNedPct, Vaerdi_GP Vaerdi_GP, Vaerdi_SP, beholdning Beholdning
		  from edw.ft_Nedskriv where Dim_Tid = ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
		  and substring(Dim_Fabrik, 1, 2) = '21') ly
		on cy.Dim_Fabrik = ly.Dim_Fabrik and cy.Materiale = ly.Materiale 
Full outer join (select  Dim_Fabrik, Materiale from edw.ft_NySeneste3Aar 
				 where Dim_Tid = ( select replace(left(Vaerdi, 7), '-', '') 
				 from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')) ft3
	on cy.Dim_Fabrik = ft3.Dim_Fabrik and cy.Materiale = ft3.Materiale 
Full outer join dbo.[vw_kassation] kas
	on ly.Dim_Fabrik = kas.Dim_Fabrik and ly.Dim_Materiale = kas.Dim_Materiale
	where isnull(cy.Beholdning, 0) <> 0
	and	ft3.Dim_Fabrik is null and ft3.Materiale is null
) q1
Where
 (isnull(q1.Beholdning, 0) <> 0 or isnull(q1.AnskVaerdi, 0) <> 0 or isnull(q1.NedForPrinc, 0) <> 0
  or isnull(q1.NedskrNetto, 0) <> 0 or isnull(q1.Vaerdi_SP, 0) <> 0)
	
Group by q1.Dim_Materiale, q1.Dim_Fabrik, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid
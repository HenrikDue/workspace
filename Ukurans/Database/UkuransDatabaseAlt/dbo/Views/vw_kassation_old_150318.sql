

CREATE view [dbo].[vw_kassation_old_150318]
-- Ajourført 141113-1: NedskrNetto
-- Ajourført 141114-1: Ændret FraTil_Tid med en Cast, da det fyldte 8000...
-- Ajourført 141114-2: Indsat case for Beholdning, så der maks er kasseret sidste års beholdning
-- Ajourført 141124-1: NedForPrinC rettet så det er LogNedBrutto, der beregnes ud fra
-- Ajourført 141124-2: Ændret NedskrNetto til at blive beregnet ud fra LogNedBrutto
as
Select kas.Dim_Fabrik, kas.Dim_Materiale, kas.materiale, kas.FraTil_tid
,case	when kas.Maengde < lp.Beholdning * -1
		Then -lp.Beholdning
		Else kas.Maengde
end as Beholdning
, lp.Vaerdi_GP as Lp_Vaerdi_GP, lp.Beholdning as Lp_Beholdning,
Case When lp.Beholdning	> 0	and	lp.Vaerdi_GP > 0
	 Then case When	lp.Beholdning > kas.Maengde * -1
	 		   Then	kas.Maengde	* lp.Vaerdi_GP / lp.Beholdning
			   Else	lp.Vaerdi_GP * -1
	 		   End
	 Else 0
	 End as AnskVaerdi,
Case When kas.Maengde < 0	
	 Then Case When lp.Beholdning > 0 and lp.LogNedBrutto < 0
			   Then case When lp.Beholdning > kas.Maengde * -1
						 Then (kas.Maengde * -1) * (lp.LogNedBrutto * -1)	/ lp.Beholdning
						 Else lp.LogNedBrutto * -1
						 End
			   Else 0
			   End
	Else 0
	End as NedForPrinC,
Case When lp.Beholdning > 0 and lp.LogNedBrutto < 0
	 Then case When lp.Beholdning > kas.Maengde * -1	
			   Then	(kas.Maengde * -1) * (lp.LogNedBrutto * -1) / lp.Beholdning
			   Else	lp.LogNedBrutto * -1
			   End
	 Else 0
	 End NedskrNetto,
Case When kas.Maengde < 0 
	 Then Case When lp.Beholdning > 0 and lp.Vaerdi_SP	>	0	
			   Then case When lp.Beholdning >kas.Maengde * -1	
						 Then kas.Maengde * lp.Vaerdi_SP / lp.Beholdning
						 Else lp.Vaerdi_SP * -1
						 End
			   Else 0
			   End
	 Else 0
	 End Vaerdi_SP
from dbo.vw_Kasseret kas
left join
(select Dim_Fabrik, Dim_Materiale, Materiale, Vaerdi_GP Vaerdi_GP, beholdning Beholdning, Vaerdi_SP, LogNedBrutto, NedskrNetto
      from edw.ft_Nedskriv where Dim_Tid = ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
      and substring(Dim_Fabrik, 1, 2) = '21') lp
on kas.Dim_Fabrik = lp.Dim_Fabrik and kas.Dim_Materiale = lp.Dim_Materiale 
left join 
(select Dim_Fabrik, Dim_Materiale, Materiale, Vaerdi_GP, Beholdning, Vaerdi_SP, LogNedBrutto, LogNedBruttoPae, NedskrNetto, LNType, LavNedPct
      from dbo.vw_Nedskriv--( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')
      where substring(Dim_Fabrik, 1, 2) = '21') cp
on kas.Dim_Fabrik = cp.Dim_Fabrik and kas.Dim_Materiale = cp.Dim_Materiale 
where isnull(kas.Maengde, 0) < 0
-- and kas.materiale in ('820605725', '773302610')

-- Order by Materiale
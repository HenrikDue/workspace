
Create view [dbo].[vw_kassation_old_141113]
as
select kas.Dim_Fabrik, kas.Dim_Materiale, kas.materiale, kas.FraTil_tid, 
kas.Maengde Beholdning,
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
(select Dim_Fabrik, Dim_Materiale, Materiale, Vaerdi_GP Vaerdi_GP, beholdning Beholdning, Vaerdi_SP, LogNedBrutto
      from edw.ft_Nedskriv where Dim_Tid = ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
      and substring(Dim_Fabrik, 1, 2) = '21') lp
on kas.Dim_Fabrik = lp.Dim_Fabrik and kas.Dim_Materiale = lp.Dim_Materiale 
left join 
(select Dim_Fabrik, Dim_Materiale, Materiale, Vaerdi_GP, Beholdning, Vaerdi_SP, LogNedBrutto, LogNedBruttoPae, NedskrNetto, LNType, LavNedPct
      from dbo.vw_Nedskriv--( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')
      where substring(Dim_Fabrik, 1, 2) = '21') cp
on kas.Dim_Fabrik = cp.Dim_Fabrik and kas.Dim_Materiale = cp.Dim_Materiale 
where isnull(kas.Maengde, 0) < 0
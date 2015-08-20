CREATE view [dbo].[vw_UltBeh_Indk12md_old_140826]
as

Select q1.Dim_Materiale
,q1.Dim_Fabrik
,q1.Materiale
,q1.LNType
,q1.FLNType
,q1.FraTil_tid
,sum(q1.Beholdning) as Beholdning
,sum(q1.AnskVaerdi) as AnskVaerdi
,sum(q1.NedForPrinc) as NedForPrinc
,sum(q1.NedskrNetto) as NedskrNetto
,sum(q1.Vaerdi_SP) as Vaerdi_SP 
from 
(select fti.Dim_Materiale
,fti.Dim_Fabrik
,fti.Materiale
,isnull(cy.LNType, 'AUB') as LNType
,isnull(ly.LNType, 'AEPD') as FLNType
,(select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') + '-' 
		+( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') as FraTil_tid
,Case	When	cy.Beholdning	>		0	
		Then	cy.Beholdning
		Else	Null
 End	as Beholdning
,Case	When cy.Vaerdi_GP > 0
		Then Case When	cy.Beholdning > 0	
			   Then	fti.UltBehIndk12mdVd
			   Else	Null
			   End
		Else	Null
 End	as AnskVaerdi
,Case	When cy.Vaerdi_GP > 0	
		Then Case When cy.Beholdning >	 0	
				   Then	cy.NedKorrIndk
				   Else	0
				End
		Else	0
 End	as	NedForPrinC
,Case When cy.Vaerdi_GP > 0	
      Then Case When cy.Beholdning > 0	
			   Then cy.NedKorrIndk
			   Else	0
			   End
	 Else	0
 End as NedskrNetto
,Case When cy.Vaerdi_SP > 0	and isnull(cy.Beholdning, 0) > 0
      Then	isnull(cy.Vaerdi_SP, 0) / isnull(cy.Beholdning, 0) * isnull(cy.UltBehIndk12mdMgd, 0) 
	  Else	0
 End	as	Vaerdi_SP

From (Select Dim_Fabrik, Materiale, Dim_Materiale, BrutIndk12mdMgd, UltBehIndk12mdVd 
		from edw.FT_Indk12md 
		where Dim_Tid = (select replace(left(Vaerdi, 7), '-', '') 
						from [edw].[MD_Styringstabel] 
						where parameter = 'UltimoDato')) fti

Left join (select Dim_Fabrik, Dim_Materiale, Materiale, Vaerdi_GP, Vaerdi_SP, Beholdning,
			LogNedBrutto, LogNedBruttoPae, UltBehIndk12mdMgd, NedKorrIndk, NedKorrIndkPae, LNType, FLNType
		   from dbo.vw_Nedskriv where substring(Dim_Fabrik, 1, 2) = '21') cy
	on fti.Dim_Fabrik = cy.Dim_Fabrik and fti.Materiale = cy.Materiale 
Left join (select Dim_Fabrik, Dim_Materiale, Materiale, LNType 
           from edw.FT_Nedskriv where Dim_Tid = (select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')) ly
    on cy.Dim_Fabrik = ly.Dim_Fabrik and cy.Materiale = ly.Materiale 
	) q1

Where  isnull(q1.Beholdning, 0) <> 0 
	or isnull(q1.AnskVaerdi, 0) <> 0 
	or isnull(q1.NedForPrinc, 0) <> 0
	or isnull(q1.NedskrNetto, 0) <> 0 
	or isnull(q1.Vaerdi_SP, 0) <> 0

Group by q1.Dim_Materiale, q1.Dim_Fabrik, q1.Materiale, q1.LNType, q1.FLNType, q1.FraTil_tid

Having Dim_Materiale in (Select b.PK_ID 
	from (select distinct Dim_Materiale from edw.FT_Indk12md 
	where Dim_Tid = (select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')) a
	Left join edw.Dim_Materiale b on a.Dim_Materiale = b.PK_ID
	Left join edw.Dim_Litra c on b.Litra_PKID = c.PK_ID
		Where c.LitraNedskrPct is null)
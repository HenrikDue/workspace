﻿







CREATE view [dbo].[vw_Delta_Brutto_old_150320] 
-- Oprettet 150225-1: Nye Dim_Andring der skal vise ændringen i bruttonedskrivningen
as
Select 'DELTA_BRUTTO' as Dim_Aendring, a.Dim_Fabrik, a.Materiale, a.Dim_Materiale, a.LNType,  a.FLNType, a.FraTil_tid
, isnull(a.AnskVaerdi, 0)	- isnull(b.AnskVaerdi, 0) as AnskVaerdi
, isnull(a.NedForPrinc, 0)	- isnull(b.NedForPrinc, 0) as NedForPrinc
	,Case	When	isnull(a.NedskrNetto, 0) <> 0 
			Then	Case	When	isnull(a.NedForPrinc, 0)	<>	0 
							Then	(isnull(a.NedskrNetto, 0)	-	isnull(a.NedForPrinc, 0)) - (isnull(b.NedskrNetto, 0)	-	isnull(b.NedForPrinc, 0))
							Else	isnull(a.NedskrNetto, 0)	-	isnull(b.NedskrNetto, 0)
					End
			Else	Case	When	isnull(a.NedForPrinc, 0)	<>	0
							Then	(isnull(a.NedForPrinc, 0) * -1 ) - (isnull(b.NedForPrinc, 0) * -1 )
							Else	0
					End
	End as DSystAendr
	,isnull(a.NedskrNetto, 0)	-	isnull(b.NedskrNetto, 0) as NedskrNetto
	,isnull(a.Beholdning, 0)	-	isnull(b.Beholdning, 0) as Beholdning
	,isnull(a.Vaerdi_SP, 0)		-	isnull(b.Vaerdi_SP, 0) as Vaerdi_SP
	,(Isnull(a.AnskVaerdi, 0)	-	Isnull(b.AnskVaerdi, 0)) - (Isnull(a.Vaerdi_SP, 0)	-	Isnull(b.Vaerdi_SP, 0)) as Forskel
From dbo.vw_LogNedsBrutto a
Left join dbo.vw_Nedskriv_Primo_Brutto b on a.Dim_Fabrik = b.Dim_Fabrik and a.Materiale = b.Materiale and a.FraTil_Tid = b.FraTil_Tid

Union all

Select 'DELTA_BRUTTO' as Dim_Aendring, b.Dim_Fabrik, b.Materiale, b.Dim_Materiale, b.LNType,  b.FLNType, b.FraTil_tid
,isnull(a.AnskVaerdi, 0)	- isnull(b.AnskVaerdi, 0) as AnskVaerdi
,isnull(a.NedForPrinc, 0)	- isnull(b.NedForPrinc, 0) as NedForPrinc
	,Case	When	isnull(a.NedskrNetto, 0) <> 0 
			Then	Case	When	isnull(a.NedForPrinc, 0)	<>	0 
							Then	(isnull(a.NedskrNetto, 0)	-	isnull(a.NedForPrinc, 0)) - (isnull(b.NedskrNetto, 0)	-	isnull(b.NedForPrinc, 0))
							Else	isnull(a.NedskrNetto, 0)	-	isnull(b.NedskrNetto, 0)
					End
			Else	Case	When	isnull(a.NedForPrinc, 0)	<>	0
							Then	(isnull(a.NedForPrinc, 0) * -1 ) - (isnull(b.NedForPrinc, 0) * -1 )
							Else	0
					End
	End as DSystAendr
	,isnull(a.NedskrNetto, 0)	-	isnull(b.NedskrNetto, 0) as NedskrNetto
	,isnull(a.Beholdning, 0)	-	isnull(b.Beholdning, 0) as Beholdning
	,isnull(a.Vaerdi_SP, 0)		-	isnull(b.Vaerdi_SP, 0) as Vaerdi_SP
	,(Isnull(a.AnskVaerdi, 0)	-	Isnull(b.AnskVaerdi, 0)) - (Isnull(a.Vaerdi_SP, 0)	-	Isnull(b.Vaerdi_SP, 0)) as Forskel
From dbo.vw_Nedskriv_Primo_Brutto b
Left join dbo.vw_LogNedsBrutto a on a.Dim_Fabrik = b.Dim_Fabrik and a.Materiale = b.Materiale and a.FraTil_Tid = b.FraTil_Tid
Where a.Materiale is null and a.Dim_Fabrik is null and a.FraTil_Tid is null
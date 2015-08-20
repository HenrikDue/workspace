





Create view [dbo].[vw_Delta_Brutto_old_150226] 
-- Oprettet 150225-1: Nye Dim_Andring der skal vise ændringen i bruttonedskrivningen
as
Select 'DELTA_BRUTTO' as Dim_Aendring, a.Dim_Fabrik, a.Materiale, a.Dim_Materiale, a.LNType,  a.FLNType, a.FraTil_tid
, a.AnskVaerdi - isnull(b.AnskVaerdi, 0) as AnskVaerdi
, a.NedForPrinc - isnull(b.NedForPrinc, 0) as NedForPrinc
	,Case	When	a.NedskrNetto <> 0 
			Then	Case	When	a.NedForPrinc	<>	0 
							Then	(a.NedskrNetto	-	a.NedForPrinc) - (b.NedskrNetto	-	b.NedForPrinc)
							Else	a.NedskrNetto	-	b.NedskrNetto
					End
			Else	Case	When	a.NedForPrinc	<>	0
							Then	(a.NedForPrinc * -1 ) - (b.NedForPrinc * -1 )
							Else	0
					End
	End as DSystAendr
	,a.NedskrNetto	-	b.NedskrNetto as NedskrNetto
	,a.Beholdning	-	b.Beholdning as Beholdning
	,a.Vaerdi_SP	-	b.Vaerdi_SP as Vaerdi_SP
	,(Isnull(a.AnskVaerdi, 0) - Isnull(b.AnskVaerdi, 0)) - (Isnull(a.Vaerdi_SP, 0)	-	Isnull(b.Vaerdi_SP, 0)) as Forskel
From dbo.vw_LogNedsBrutto a
Left join dbo.vw_Nedskriv_Primo_Brutto b on a.Dim_Fabrik = b.Dim_Fabrik and a.Materiale = b.Materiale and a.FraTil_Tid = b.FraTil_Tid
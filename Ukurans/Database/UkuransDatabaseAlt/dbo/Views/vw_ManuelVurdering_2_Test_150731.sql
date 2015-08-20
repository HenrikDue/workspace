











CREATE VIEW [dbo].[vw_ManuelVurdering_2_Test_150731]
-- 150727-1: Oprettet for indlæggelse af manuel vurdering pba. vurderet forbrug restperiode frem til prognose (indlagt i edw.PrognManVurdering)
AS

Select a.Dim_Fabrik, a.Materiale, a.Dim_Materiale, a.LNType, a.FLNType, a.FraTil_tid
,Case	when	a.AnskVaerdi/ a.Beholdning * b.PrognBehMgd > 0
		then	a.AnskVaerdi/ a.Beholdning * b.PrognBehMgd
		else	0
 end as AnskVaerdi
,0 as NedForPrinc, b.ManVurdNedskNetto as DSystAnedr, b.ManVurdNedskNetto as NedskrNetto
,Case	when	a.AnskVaerdi/ a.Beholdning * b.PrognBehMgd > 0
		then	b.PrognBehMgd 
		else	0
 end as Beholdning	
,Case	when	a.AnskVaerdi/ a.Beholdning * b.PrognBehMgd > 0
		then	a.Vaerdi_SP/ a.Beholdning * b.PrognBehMgd 
		else	0
 end as Vaerdi_SP 
,Case	when	a.AnskVaerdi/ a.Beholdning * b.PrognBehMgd > 0
		then	b.PrognAnskVaerdi - (a.Vaerdi_SP/ a.Beholdning * b.PrognBehMgd) 
		else	0
 end as Forskel

From dbo.vw_LogNedsBrutto a
Left join dbo.vw_ManuelVurdering_1_Test b on a.Dim_Fabrik = b.Dim_Fabrik and a.Dim_Materiale = b.Dim_Materiale
Where b.Dim_Fabrik is not null and b.Dim_Materiale is not null
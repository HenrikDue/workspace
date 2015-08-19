




CREATE VIEW [dbo].[vw_ManuelVurdering_2_Test]
-- 150727-1: Oprettet for indlæggelse af manuel vurdering pba. vurderet forbrug restperiode frem til prognose (indlagt i edw.PrognManVurdering)
AS

Select a.Dim_Fabrik, a.Materiale, a.Dim_Materiale, a.LNType, a.FLNType, a.FraTil_tid, a.AnskVaerdi, a.NedForPrinc
,b.ManVurdNedskNetto as DSystAendr, b.ManVurdNedskNetto as NedskrNetto, a.Beholdning, a.Vaerdi_SP, a.Forskel

From dbo.vw_LogNedsBrutto a
Left join dbo.vw_ManuelVurdering_1_Test b on a.Dim_Fabrik = b.Dim_Fabrik and a.Dim_Materiale = b.Dim_Materiale
Where b.Dim_Fabrik is not null and b.Dim_Materiale is not null
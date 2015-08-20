

CREATE VIEW [dbo].[vw_LogNedsBrutto_old_150325]
-- 141114-1: Ajourført FraTil_Tid med en Cast, da det fyldte 8000...
-- 141121-1: Ændret kriterie for ly-join til FraTil_Tid og rettet nsly-periode med ny PrimoPrimoDato
AS
Select q1.Dim_Fabrik, q1.Materiale, q1.Dim_Materiale, 
isnull(q1.LNType, 'AUB') LNType, isnull(q1.FLNType, 'AEPD') FLNType,
q1.FraTil_tid, q1.AnskVaerdi,
q1.NedForPrinc, 
	Case	When	q1.NedskrNetto <> 0 
			Then	Case	When	q1.NedForPrinc	<>	0 
							Then	q1.NedskrNetto	-	q1.NedForPrinc
							Else	q1.NedskrNetto
					End
			Else	Case	When	q1.NedForPrinc	<>	0
							Then	q1.NedForPrinc * -1
							Else	0
					End
	End DSystAnedr,
q1.NedskrNetto, q1.Beholdning, q1.Vaerdi_SP, 
	Case	When	q1.AnskVaerdi <> 0 
			Then	Case	When	q1.Vaerdi_SP	<>	0 
							Then	q1.AnskVaerdi	-	q1.Vaerdi_SP
							Else	q1.AnskVaerdi
					End
			Else	Case	When	q1.Vaerdi_SP	<>	0
							Then	q1.Vaerdi_SP * -1
							Else	Null
					End
	End Forskel
from (
select nscy.Dim_Fabrik, nscy.Materiale, nscy.Dim_Materiale, 
nscy.LNType, nsly.LNType as FLNType,
Cast(( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') 
	+ '-' +( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') 
	as Varchar (13)) as FraTil_tid,
nscy.Vaerdi_GP AnskVaerdi, nscy.LogNedBruttoPae NedForPrinc, nscy.Beholdning,
nscy.LogNedBrutto NedskrNetto, nscy.Vaerdi_SP
from (select Dim_Fabrik, Dim_Materiale, Materiale, LNType, FLNType, Beholdning, Vaerdi_GP, LogNedBrutto, LogNedBruttoPae, Vaerdi_SP 
	  from dbo.vw_Nedskriv) nscy
full outer join 
     (select Dim_Fabrik, Dim_Materiale,  Materiale, beholdning, LogNedBruttoPae,
      LogNedBrutto, NedskrNetto, LNType, LavNedPct
      from edw.ft_Nedskriv where FraTil_Tid = (select replace(left(Vaerdi, 7), '-', '') 
												from [edw].[MD_Styringstabel] where parameter = 'PrimoPrimoDato') + '-' 
												+(select replace(left(Vaerdi, 7), '-', '') 
												from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
      /*and substring(Dim_Fabrik, 1, 2) = '21'*/) nsly
on nscy.Dim_Fabrik = nsly.Dim_Fabrik and nscy.Materiale = nsly.Materiale
) q1
where q1.Dim_Fabrik is not null and  q1.Dim_Materiale is not null
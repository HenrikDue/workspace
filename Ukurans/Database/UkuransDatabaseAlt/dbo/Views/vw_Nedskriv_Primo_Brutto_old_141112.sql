



Create view [dbo].[vw_Nedskriv_Primo_Brutto_old_141112]
as
SELECT Dim_Fabrik, Dim_Materiale, Materiale, LNType, FLNType,
( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') + '-' +( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') FraTil_tid,
sum(beholdning) Beholdning, sum(Vaerdi_GP) AnskVaerdi, sum(LogNedBrutto)  NedForPrinc, sum(LogNedBrutto) NedskrNetto, sum(Vaerdi_SP) Vaerdi_SP
  FROM edw.FT_Nedskriv
where Dim_Tid = ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
and (isnull(Vaerdi_GP, 0) <> 0 or isnull(Vaerdi_SP, 0) <> 0 or isnull(LogNedBrutto, 0) <> 0 
or isnull(LogNedBrutto, 0) <> 0 or isnull(beholdning, 0) <> 0)
group by Dim_Fabrik, Dim_Materiale, materiale, LNType, FLNType


CREATE view [dbo].[vw_Nedskriv_Primo_old_150319-2] 
-- Ajourført 150319-1: Ændret kriterie for ly-join til FraTil_Tid og rettet ly-periode med ny PrimoPrimoDato
-- Dette view er i grunden overflødig, da vw_Nedskriv_Primo_Brutto kan anvendes i afstemningen i stedet
as
SELECT Dim_Fabrik, Dim_Materiale, Materiale, LNType, FLNType,
cast (( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
 + '-' +( select Vaerdi from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') as varchar(13)) FraTil_tid,
sum(beholdning) Beholdning, sum(Vaerdi_GP) AnskVaerdi, sum(LogNedBrutto)  NedForPrinc, sum(LogNedBrutto) NedskrNetto, sum(Vaerdi_SP) Vaerdi_SP
  FROM edw.FT_Nedskriv where FraTil_Tid = (select replace(left(Vaerdi, 7), '-', '')										-- Rettelse 150319-1
											from [edw].[MD_Styringstabel] where parameter = 'PrimoPrimoDato') + '-'     -- Rettelse 150319-1
				   						 +(select replace(left(Vaerdi, 7), '-', '')										-- Rettelse 150319-1
											from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')				-- Rettelse 150319-1
and (isnull(Vaerdi_GP, 0) <> 0 or isnull(Vaerdi_SP, 0) <> 0 or isnull(LogNedBrutto, 0) <> 0 
or isnull(LogNedBrutto, 0) <> 0 or isnull(beholdning, 0) <> 0)
group by Dim_Fabrik, Dim_Materiale, materiale, LNType, FLNType
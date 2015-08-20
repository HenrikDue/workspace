﻿

CREATE view [dbo].[vw_Kasseret_old_150318]
as
-- Ajourført 150112-1: Ændret frakriterie til at være større end PrimoDato
select Dim_Fabrik, Dim_Materiale, materiale, 
cast((select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'PrimoDato') 
	+'-'+ ( select replace(left(Vaerdi, 7), '-', '') from [edw].[MD_Styringstabel] where parameter = 'UltimoDato') as varchar(13)) FraTil_Tid,
sum(Maengde) Maengde, sum(Vaerdi_SP) Vaerdi
from edw.FT_Transaktioner
left join edw.Dim_BevArt
on edw.FT_Transaktioner.Dim_BevArt = edw.Dim_BevArt.BevArt
where RegistrDato >		(select Vaerdi from [edw].[MD_Styringstabel] where parameter = 'PrimoDato')
	and RegistrDato <=  (select Vaerdi from [edw].[MD_Styringstabel] where parameter = 'UltimoDato')
	and BevArtType = 'Kassation'
group by Dim_Fabrik, Dim_Materiale, materiale
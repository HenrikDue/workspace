﻿


CREATE view [dbo].[vw_KorrFLUK_20141103]
as
Select /*distinct */ dim_materiale, Materiale
      ,sum(q1.Beholdning) as Beholdning
      ,avg(q1.GlidGnsPris) as GlidGnsPris
      ,sum(q1.Vaerdi_GP) as Vaerdi_GP
      ,'FLUK' as StatGr2
	  ,avg(q1.DUF) as DUF
      ,avg(q1.StatusDUF_NedskrAar) as StatusDUF_NedskrAar
      ,avg(q1.StatusNedskrPct) as StatusNedskrPct
      ,q1.Nuv_StatusGr2
      ,q1.Nuv_LNType
From 
(
select ult.Dim_Fabrik as Fabrik, ult.Materiale, ult.Dim_Materiale, ult.Beholdning, ult.GlidGnsPris, ult.Vaerdi_GP, /*'FLUK' as StatGr2,*/ ult.DUF,
dl.DUF_NedskrAar as StatusDUF_NedskrAar, pri.LavNedPct as  StatusNedskrPct, dm.StatusGr2 as Nuv_StatusGr2, ult.LNType as Nuv_LNType
from edw.ft_nedskriv ult
Left join edw.Dim_Materiale dm on ult.Materiale = dm.Materiale --and dm.Aktiv = 'J'
	and dm.GyldigFra >= (select left(vaerdi, 8) + '01' from edw.md_styringstabel where parameter = 'PrimoDato')
	and dm.GyldigTil <= (select vaerdi from edw.md_styringstabel where parameter = 'UltimoDato')
Left join edw.Dim_Litra dl on dm.LitraGr2 = dl.LitraGr2 and dl.GyldigTil = '9999-12-31'
left join (select Dim_Fabrik, Materiale, LavNedPct, LNType from edw.ft_Nedskriv 
           where dim_tid = (select replace(left(vaerdi, 7), '-', '') from edw.md_styringstabel where parameter = 'PrimoDato')
           ) pri on ult.Dim_Fabrik = pri.Dim_Fabrik and ult.Materiale = pri.materiale
Where ult.Dim_Tid = (select replace(left(vaerdi, 7), '-', '')  from edw.md_styringstabel where parameter = 'UltimoDato') 
and (left(pri.LNType,1) = 'R' and ult.LNType = 'Lang' and ult.LavNedPct > pri.LavNedPct + 0.05
     ) -- 5% karenstid, materialer der vil opnå samme nedskrivning i løbet af ca et halvt år, ændres ikke
or  (ult.Dim_Tid = (select replace(left(vaerdi, 7), '-', '')  from edw.md_styringstabel where parameter = 'UltimoDato') 
     and pri.LNType = 'Stat' and dm.StatusGr2 = 'FLUK' and ult.LNType = 'Lang' and ult.LavNedPct > pri.LavNedPct
	 )  
or  (ult.Dim_Tid = (select replace(left(vaerdi, 7), '-', '')  from edw.md_styringstabel where parameter = 'UltimoDato') 
     and dm.StatusGr2 = 'FLUK'-- : Nuværende status tilføjet, da materialet ellers falder tilbage til Lang ved et fornyet 2. gennemløb af modellen
	 )
  ) q1
Group by  dim_materiale, Materiale, Nuv_StatusGr2, Nuv_LNType
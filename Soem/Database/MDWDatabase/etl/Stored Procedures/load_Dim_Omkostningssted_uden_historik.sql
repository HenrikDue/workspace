
CREATE proc [etl].[load_Dim_Omkostningssted_uden_historik]
as
begin

insert into [ods].[Key_Dim_Omkostningssted_uden_historik] (omkostningssted)
select omkostningssted from  ods.td0_cd_g_etl5_ressourceportal_drift
except 
select omkostningssted from [ods].[Key_Dim_Omkostningssted_uden_historik]

insert into [ods].[Key_Dim_Omkostningssted_uden_historik] (omkostningssted)
select omkstedultimo from  ods.td0_CD_G_ETL5_Ressourceportal_Anlæg
except 
select omkostningssted from [ods].[Key_Dim_Omkostningssted_uden_historik]

insert into edw.Dim_Omkostningssted_uden_historik (pk_key, omkostningssted)
select distinct  k.pk_key, o.omkostningssted from 
ods.td0_cd_g_etl5_ressourceportal_drift o inner join
[ods].[Key_Dim_Omkostningssted_uden_historik] k on o.omkostningssted = k.omkostningssted
where o.omkostningssted not in (select omkostningssted from edw.Dim_Omkostningssted_uden_historik )

insert into edw.Dim_Omkostningssted_uden_historik (pk_key, omkostningssted)
select distinct  k.pk_key, o.omkstedUltimo from 
ods.td0_cd_g_etl5_ressourceportal_anlæg o inner join
[ods].[Key_Dim_Omkostningssted_uden_historik] k on o.omkstedUltimo = k.omkostningssted
where o.omkstedUltimo not in (select omkostningssted from edw.Dim_Omkostningssted_uden_historik )

update  x set x.omkostningsstednavn = y.omkstednavn, x.profitcenter = dbo.fjernforanstilledenuller(y.profitcenter) 
from edw.Dim_Omkostningssted_uden_historik x inner join  
ods.rd_sap_omkstedstam y on y.gyldigtildato = '31.12.9999' and dbo.fjernforanstilledenuller(y.omksted) = x.omkostningssted

end
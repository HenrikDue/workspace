
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
 CREATE PROCEDURE [etl].[InsertIntoFT_Soem]
AS
BEGIN
IF object_id('dbo.periode_tmp') is not null DROP TABLE dbo.periode_tmp
create table dbo.periode_tmp (periode varchar(8));
insert into dbo.periode_tmp values(201112);
insert into dbo.periode_tmp values(201212);
insert into dbo.periode_tmp values(201301);
insert into dbo.periode_tmp values(201302);
insert into dbo.periode_tmp values(201303);
insert into dbo.periode_tmp values(201304);
insert into dbo.periode_tmp values(201305);
insert into dbo.periode_tmp values(201306);
insert into dbo.periode_tmp values(201307);
insert into dbo.periode_tmp values(201308);
insert into dbo.periode_tmp values(201309);
insert into dbo.periode_tmp values(201310);
insert into dbo.periode_tmp values(201311);
insert into dbo.periode_tmp values(201312);
insert into dbo.periode_tmp values(201401);
insert into dbo.periode_tmp values(201402);
insert into dbo.periode_tmp values(201403);
insert into dbo.periode_tmp values(201404);
insert into dbo.periode_tmp values(201405);
insert into dbo.periode_tmp values(201406);
insert into dbo.periode_tmp values(201407);
insert into dbo.periode_tmp values(201408);
insert into dbo.periode_tmp values(201409);
insert into dbo.periode_tmp values(201410);
insert into dbo.periode_tmp values(201411);
insert into dbo.periode_tmp values(201412);
insert into dbo.periode_tmp values(201501);
insert into dbo.periode_tmp values(201502);
insert into dbo.periode_tmp values(201503);
insert into dbo.periode_tmp values(201504);
insert into dbo.periode_tmp values(201505);
insert into dbo.periode_tmp values(201506);

declare @periode varchar(8)
set @periode = '201212'
declare @SQL_command varchar(max)

declare cur cursor for 
select periode from dbo.periode_tmp
open cur

fetch next from cur into @periode
while (@@FETCH_STATUS = 0)
begin
set @SQL_command =
'Insert into edw.FT_Strækningsøkonomi (
            [Ft_key],
            [Periode],
            [Model_id],
            [DestcostGangetOp],
            [resource1_key],
            [resource2_key],
            [activity1_key],
            [activity2_key],
            [activity3_key],
            [activity4_key],
            [costobject1_key],
            [attRessourcetype_key],
            [attFunktionskunde_key],
            [AttSegment_key],
            [AttProduktaktivitetsgruppe_key],
            [AttProduktVariabilitet_key],
            [AttProduktLitra_key],
            [AttTogsystem_key],
            [Omkostningssted_key],
            [art_hierarki_key],
            [ordre_key],
            [pspelement_key],
            [profitcenter_key],
            [Artsgruppe_key],
            [resBeløb],
            [resSumBeløb],
            [Beløb],
            [RessourceportalJoin],
            [Dækningsbidrag_key],
            [Variabilitet_key],
            [Reversibilitet_key],
            [Tidsinterval_key],
            [Momsstatus],
            [kilde_key]
)
SELECT 
 next value for [edw].[ft_strækningsøkonomi_ft_key],   ---Ft_key
'+@periode+',   ---Periode
[Model_id],   ---Model_id
[DestcostGangetOp],   ---DestcostGangetOp
[resource1_key],   ---resource1_key
[resource2_key],   ---resource2_key
[activity1_key],   ---activity1_key
[activity2_key],   ---activity2_key
[activity3_key],   ---activity3_key
[activity4_key],   ---activity4_key
[costobject1_key],   ---costobject1_key
[attRessourcetype_key],   ---attRessourcetype_key
[attFunktionskunde_key],   ---attFunktionskunde_key
[AttSegment_key],   ---AttSegment_key
[AttProduktaktivitetsgruppe_key],   ---AttProduktaktivitetsgruppe_key
[AttProduktVariabilitet_key],   ---AttProduktVariabilitet_key
[AttProduktLitra_key],   ---AttProduktLitra_key
[AttTogsystem_key],   ---AttTogsystem_key
[Omkostningssted_key],   ---Omkostningssted_key
[art_hierarki_key],   ---art_hierarki_key
[ordre_key],   ---ordre_key
[pspelement_key],   ---pspelement_key
[profitcenter_key],   ---profitcenter_key
[Artsgruppe_key],   ---Artsgruppe_key
[resBeløb],   ---resBeløb
[resSumBeløb],   ---resSumBeløb
[Beløb],   ---Beløb
[RessourceportalJoin],   ---RessourceportalJoin
[Dækningsbidrag_key],   ---Dækningsbidrag_key
[Variabilitet_key],   ---Variabilitet_key
[Reversibilitet_key],   ---Reversibilitet_key
[Tidsinterval_key],   ---Tidsinterval_key
[Momsstatus],   ---Momsstatus
[kilde_key]   ---OprettetAf
From
edw.ft_strækningsøkonomi_'+@periode+'';

    --print(@periode)
	--print(@SQL_command)
	execute (@SQL_command)
    fetch next from cur into @periode
end
close cur
deallocate cur
  

IF object_id('dbo.periode_tmp') is not null DROP TABLE dbo.periode_tmp
END
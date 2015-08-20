--script_insert 'edw.FT_Strækningsøkonomi'
Insert into edw.FT_Strækningsøkonomi (
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
201404,   ---Periode
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
edw.ft_strækningsøkonomi_201404


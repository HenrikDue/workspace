create view [edw].[vw_dim_Aktivitet_1]
as
SELECT        PK_Key, Parent_Key, DimensionName, MemberName, MemberRefnum, MemberDisplayOrder, Drivername
FROM            edw.dim_member
WHERE        (DimensionName = 'Activity') AND (MemberRefnum LIKE 'A1%' OR
                         MemberRefnum IS NULL)
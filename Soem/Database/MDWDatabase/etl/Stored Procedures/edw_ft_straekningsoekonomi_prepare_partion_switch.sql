CREATE proc [etl].[edw_ft_straekningsoekonomi_prepare_partion_switch] @periode varchar(6) 
as
begin

declare @periodeInt int
set @periodeInt = convert(int, @periode)

declare @partition_number int
SELECT @partition_number = $PARTITION.[Periode] (@periode)

declare @partition_function_id int
select @partition_function_id = function_id from sys.partition_functions where name = 'Periode'
--select @partition_function_id

declare @splitSql varchar(max)

if not exists (select 'x' from sys.partition_range_values where function_id = @partition_function_id and value = @periodeInt)
begin
	if isdate(@periode+'01') = 1
		begin
			set @splitSql = 'ALTER PARTITION FUNCTION Periode() SPLIT RANGE ('+@periode+')'
			alter partition scheme Periode_All_to_primary next used [Primary]
			exec (@splitSql)
			--select 	@splitSql
		end
end


if exists (select 'x' from sys.objects where name = 'chk_FT_Strækningsøkonomi_Staging_partition' and parent_object_id = object_id('edw.FT_Strækningsøkonomi_Staging')) 
	ALTER TABLE [edw].[FT_Strækningsøkonomi_Staging] DROP  CONSTRAINT [chk_FT_Strækningsøkonomi_Staging_partition] 

declare @sqlAlter2 varchar(max)
set @sqlAlter2 = 'ALTER TABLE [edw].[FT_Strækningsøkonomi_Staging]  WITH CHECK ADD CONSTRAINT [chk_FT_Strækningsøkonomi_Staging_partition] CHECK  ([Periode]='+convert(varchar(6),@periode)+')'
--select @sqlAlter
exec (@sqlAlter2)
--ALTER TABLE [edw].[FT_Strækningsøkonomi_Staging]  WITH CHECK ADD  CONSTRAINT [chk_FT_Strækningsøkonomi_Staging_partition_33] CHECK  ([Periode]>N'201506' AND [Periode]<=N'201507')
ALTER TABLE [edw].[FT_Strækningsøkonomi_Staging] CHECK CONSTRAINT [chk_FT_Strækningsøkonomi_Staging_partition]

end
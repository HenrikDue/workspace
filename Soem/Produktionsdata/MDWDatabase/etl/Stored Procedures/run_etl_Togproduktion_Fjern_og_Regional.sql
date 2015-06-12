﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [etl].[run_etl_Togproduktion_Fjern_og_Regional]
	@ssisdb_folder varchar(50),
	@output_status varchar(50) output
AS
BEGIN
declare @status varchar(50);
declare @execution_id bigint;
 exec ssisdb.catalog.create_execution 
  @folder_name = @ssisdb_folder
 ,@project_name = '010-ETL_Togproduktion_Fjern_og_Regional'
 ,@package_name = '001_KOER_ALLE_PAKKER_TOGPROD_F_R.dtsx'
 ,@reference_id=NULL
 ,@use32bitruntime=FALSE    
 ,@execution_id = @execution_id output

 EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
        @execution_id=@execution_id,  
        @object_type=50, 
        @parameter_name=N'SYNCHRONIZED', 
        @parameter_value=1; -- true

 exec ssisdb.catalog.start_execution @execution_id
 --set @output_execution_id = @execution_id

/*hent resultat af kørsel*/
SELECT 
    @status = CASE [STATUS]
	when 1 then 'Oprettet'--'Created'
	when 2 then 'Kører'--'Running'
	when 3 then 'Annulleret'--'Cancelled'
	when 4 then 'Fejlet'--'Failed'
	when 5 then 'Afventer'--'Pending'
	when 6 then 'Aflsuttet uventet'--'Ended Unexpectedly'
	when 7 then 'Afsluttet uden fejl'--'Success'
	when 8 then 'Stopper'--'Stopping'
	when 9 then 'Komplet'--'Complete'
 end
FROM [SSISDB].[internal].[operations]
WHERE operation_id = @execution_id;
set @output_status = @status;

--/* eksempel til logning
select
 Pakkenavn = 'ETL_Togproduktion_ Fjern_og_Regional',
  Resultat = convert(char(20), CASE in_op.[status]
	when 1 then 'Oprettet'--'Created'
	when 2 then 'Kører'--'Running'
	when 3 then 'Annulleret'--'Cancelled'
	when 4 then 'Fejlet'--'Failed'
	when 5 then 'Afventer'--'Pending'
	when 6 then 'Aflsuttet uventet'--'Ended Unexpectedly'
	when 7 then 'Afsluttet uden fejl'--'Success'
	when 8 then 'Stopper'--'Stopping'
	when 9 then 'Komplet'--'Complete'
 END) ,		
 Startet = convert(char(20), format(in_op.start_time,'dd-MM-yyyy ')+CONVERT(VARCHAR(8),in_op.start_time,108)),
 Afsluttet = convert(char(20), format(in_op.end_time,'dd-MM-yyyy ')+CONVERT(VARCHAR(8),in_op.end_time,108)),
 Varighed_sek = convert(char(20), datediff(s,in_op.start_time,in_op.end_time))
from [SSISDB].[internal].[operations] in_op
where [operation_id] = @execution_id
--*/

END
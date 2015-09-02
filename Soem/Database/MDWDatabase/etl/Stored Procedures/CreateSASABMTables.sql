-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [etl].[CreateSASABMTables]
	@model varchar(50),
	@tableName varchar(50),
	@database varchar(50)



AS
BEGIN
Declare @strTable varchar(max)
Declare @sqlCommand varchar(max)
Declare @tableColumns varchar(max)
Declare @checkTable bit=1
Declare @trunkTable varchar(max)
Set @strTable = '[dbo].['+@model+'_'+@tableName+']'
Set @checkTable=COALESCE(object_id(@database+'.'+@strTable),0)
Set @trunkTable =
	'USE ['+@database+']' + CHAR(13) +
	'TRUNCATE TABLE '+@strTable + CHAR(13)
IF @tableName = 'Costelement'
Set @tableColumns = 
	'[Id] [int] NOT NULL, ' + CHAR(13) + 
    '[PeriodId] [smallint] NOT NULL, ' + CHAR(13) +
	'[ScenarioId] [smallint] NOT NULL, ' + CHAR(13) +
	'[SourceId] [int] NULL, ' + CHAR(13) +
	'[DestinationId] [int] NOT NULL, ' + CHAR(13) +
	'[Refnum] [dbo].[string256] NULL, ' + CHAR(13) +
	'[Name] [dbo].[string256] NULL, ' + CHAR(13) +
	'[Type] [smallint] NOT NULL, ' + CHAR(13) +
	'[FixedCost] [float] NULL, ' + CHAR(13) +
	'[VariableCost] [float] NULL, ' + CHAR(13) +
	'[AllocatedCost] [float] NULL, ' + CHAR(13) +
	'[IdleCost] [float] NULL, ' + CHAR(13) +
	'[FixedQuantity] [float] NULL, ' + CHAR(13) +
	'[VariableQuantity] [float] NULL, ' + CHAR(13) +
	'[FixedWeight] [float] NULL, ' + CHAR(13) +
	'[VariableWeight] [float] NULL, ' + CHAR(13) +
	'[QuantityBasic] [float] NULL, ' + CHAR(13) +
	'[QuantityCalculated] [float] NULL, ' + CHAR(13) +
	'[UserIdleQuantity] [float] NULL, ' + CHAR(13) +
	'[AssignedIdleQuantity] [float] NULL, ' + CHAR(13) +
	' CONSTRAINT [PK_'+@model+'_CostElement] PRIMARY KEY NONCLUSTERED ' + CHAR(13) + 
	'( ' + CHAR(13) +
	'[PeriodId] ASC, ' + CHAR(13) +
	'[ScenarioId] ASC, ' + CHAR(13) +
	'[Id] ASC) ' + CHAR(13) 
ELSE IF @tableName = 'Dimension'
Set @tableColumns =
	'[Id] [int] NOT NULL, ' + CHAR(13) +
	'[Name] [dbo].[string64] NOT NULL, ' + CHAR(13) +
	'[OdbcColumnName] [dbo].[string64] NOT NULL, ' + CHAR(13) +
	'[Refnum] [dbo].[string64] NULL, ' + CHAR(13) +
	'[ShortRefnum] [nvarchar](18) NULL, ' + CHAR(13) +
	'[Icon] [int] NOT NULL CONSTRAINT [DF_'+@model+'_Dimension_Icon]  DEFAULT ((0)), ' + CHAR(13) +
	'[Description] [ntext] NULL, ' + CHAR(13) +
	'CONSTRAINT [PK_'+@model+'_Dimension] PRIMARY KEY NONCLUSTERED ' + CHAR(13) + 
	'( ' + CHAR(13) +
	'[Id] ASC ' + CHAR(13) +
	') ' + CHAR(13) 
ELSE IF @tableName = 'AccountCenter' 
Set @tableColumns = 
	'[Id] [int] NOT NULL, ' + CHAR(13) + 
	'[Type] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_AccountCenter_ItemTypeId]  DEFAULT ((3)), ' + CHAR(13) +
	'[SourceId] [int] NULL, ' + CHAR(13) +
	'[DestinationId] [int] NULL, ' + CHAR(13) +
	'[BalAdjType] [smallint] NULL, ' + CHAR(13) +
	'[ModuleId] [smallint] NOT NULL, ' + CHAR(13) +
	'[PeriodId] [smallint] NOT NULL, ' + CHAR(13) +
	'[ScenarioId] [smallint] NOT NULL, ' + CHAR(13) +
	'[DriverId] [int] NULL, ' + CHAR(13) +
	'[Refnum] [dbo].[string256] NULL, ' + CHAR(13) +
	'[Name] [dbo].[string256] NULL, ' + CHAR(13) +
	'[Note] [ntext] NULL, ' + CHAR(13) +
	'[CostPrimaryEntered] [float] NULL, ' + CHAR(13) +
	'[CostPrimaryAssigned] [float] NULL, ' + CHAR(13) +
	'[CostPrimaryBOC] [float] NULL, ' + CHAR(13) +
	'[CostReceivedBOC] [float] NULL, ' + CHAR(13) +
	'[CostReceivedAssigned] [float] NULL, ' + CHAR(13) +
	'[CostGivenBOC] [float] NULL, ' + CHAR(13) +
	'[CostGivenAssigned] [float] NULL, ' + CHAR(13) +
	'[UnitCostEntered] [float] NULL, ' + CHAR(13) +
	'[IdleCost] [float] NULL, ' + CHAR(13) +
	'[Revenue] [float] NULL, ' + CHAR(13) +
	'[TotalDriverQuantityBasic] [float] NULL, ' + CHAR(13) +
	'[TotalDriverQuantityCalculated] [float] NULL, ' + CHAR(13) +
	'[UserTotalDriverQuantity] [float] NULL, ' + CHAR(13) +
	'[SoldQuantity] [float] NULL, ' + CHAR(13) +
	'[UserInputQuantity] [float] NULL, ' + CHAR(13) +
	'[UserOutputQuantity] [float] NULL, ' + CHAR(13) +
	'[Measure] [dbo].[string64] NULL, ' + CHAR(13) +
	'[UnitCostType] [bit] NULL CONSTRAINT [DF_'+@model+'_AccountCenter_UnitCostType]  DEFAULT ((0)), ' + CHAR(13) +
	'[AllocatedCostIn] [float] NULL, ' + CHAR(13) +
	'[AllocatedCost] [float] NULL, ' + CHAR(13) +
	'[AssignedIdleQuantity] [float] NULL, ' + CHAR(13) +
	'[UnassignedCost] [float] NULL, ' + CHAR(13) +
	'[CalcError] [smallint] NULL, ' + CHAR(13) +
	'[PublishName] [dbo].[string64] NULL, ' + CHAR(13) +
	'[IsBehavior] [int] NULL, ' + CHAR(13) +
	'[Dim1001] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1001] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1001]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1002] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1002] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1002]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1003] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1003] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1003]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1004] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1004] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1004]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1005] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1005] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1005]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1006] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1006] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1006]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1007] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1007] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1007]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1008] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1008] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1008]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1009] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1009] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1009]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1010] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1010] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1010]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1011] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1011] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1011]  DEFAULT ((0)), ' + CHAR(13) +
	'[Dim1012] [int] NULL, ' + CHAR(13) +
	'[IsSystemDim1012] [smallint] NULL CONSTRAINT ['+@model+'_DF_IsSystemDim1012]  DEFAULT ((0)), ' + CHAR(13) +
	' CONSTRAINT [PK_'+@model+'_AccountCenter] PRIMARY KEY NONCLUSTERED ' + CHAR(13) + 
	'( ' + CHAR(13) +
	'[PeriodId] ASC, ' + CHAR(13) +
	'[ScenarioId] ASC, ' + CHAR(13) +
	'[Id] ASC) ' + CHAR(13) 
ELSE IF @tableName = 'Driver' 
Set @tableColumns = 
	'[Id] [int] NOT NULL, ' + CHAR(13) + 
	'[Name] [dbo].[string64] NOT NULL, ' + CHAR(13) +
	'[Type] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_Type]  DEFAULT ((6)), ' + CHAR(13) +
	'[ParentId] [int] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_ParentId]  DEFAULT ((0)), ' + CHAR(13) +
	'[Description] [nvarchar](1024) NOT NULL CONSTRAINT [DF_'+@model+'_Driver_DriverDescription]  DEFAULT (''''), ' + CHAR(13) +
	'[ImplementationType] [int] NULL, ' + CHAR(13) +
	'[QuantityType] [int] NULL, ' + CHAR(13) +
	'[Formula] [ntext] NULL, ' + CHAR(13) +
	'[UseFixedQuantities] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_UseFixedQuantities]  DEFAULT ((1)), ' + CHAR(13) +
	'[UseVariableQuantities] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_UseVariableQuantities]  DEFAULT ((0)), ' + CHAR(13) +
	'[UseWeightedQuantities] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_UseWeightedQuantities]  DEFAULT ((0)), ' + CHAR(13) +
	'[IdleFlowMethod] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_IdleFlowMethod]  DEFAULT ((0)), ' + CHAR(13) +
	'[SequenceNo] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_SequenceNo]  DEFAULT ((1)), ' + CHAR(13) +
	'[FixedDQOverride] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_FixedDQOverride]  DEFAULT ((0)), ' + CHAR(13) +
	'[VariableDQOverride] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_VariableDQOverride]  DEFAULT ((0)), ' + CHAR(13) +
	'[UserEnteredCostAllocation] [smallint] NOT NULL CONSTRAINT [DF_'+@model+'_Driver_UserEnteredCostAllocation]  DEFAULT ((0)), ' + CHAR(13) +
	'[RuleFormula] [ntext] NULL, ' + CHAR(13) +
	'[UseRuleFormula] [smallint] NOT NULL, ' + CHAR(13) +
	'CONSTRAINT [PK_'+@model+'_Driver] PRIMARY KEY NONCLUSTERED ' + CHAR(13) + 
	'( ' + CHAR(13) +
	'[Id] ASC ' + CHAR(13) +
	') ' + CHAR(13)
ELSE IF @tableName = 'DimMember' 
Set @tableColumns = 
	'[Id] [int] NOT NULL, ' + CHAR(13) + 
	'[DimensionId] [int] NOT NULL, ' + CHAR(13) +
	'[ParentId] [int] NOT NULL, ' + CHAR(13) +
	'[Name] [dbo].[string64] NOT NULL, ' + CHAR(13) +
	'[Refnum] [dbo].[string64] NOT NULL, ' + CHAR(13) +
	'[LevelId] [smallint] NOT NULL, ' + CHAR(13) +
	'[DisplayOrder] [float] NULL, ' + CHAR(13) +
	'CONSTRAINT [PK_'+@model+'_DimMember] PRIMARY KEY NONCLUSTERED ' + CHAR(13) + 
	'( ' + CHAR(13) +
	'[Id] ASC ' + CHAR(13) +
	') ' + CHAR(13)
Set @sqlCommand =
	'USE ['+@database+'] ' + CHAR(13) +
	'CREATE TABLE '+@strTable+'(' + CHAR(13) +
	''+@tableColumns+'' + CHAR(13) +
	') ON [PRIMARY]' +CHAR(13)

IF @checkTable=1 --tabel eksisterer
execute(@trunkTable)
ELSE
execute(@sqlCommand)

END
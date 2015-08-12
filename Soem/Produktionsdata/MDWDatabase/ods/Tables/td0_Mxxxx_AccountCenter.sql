﻿CREATE TABLE [ods].[td0_Mxxxx_AccountCenter] (
    [Id]                            INT           NULL,
    [Type]                          SMALLINT      NULL,
    [SourceId]                      INT           NULL,
    [DestinationId]                 INT           NULL,
    [BalAdjType]                    SMALLINT      NULL,
    [ModuleId]                      SMALLINT      NULL,
    [PeriodId]                      SMALLINT      NULL,
    [ScenarioId]                    SMALLINT      NULL,
    [DriverId]                      INT           NULL,
    [Refnum]                        VARCHAR (256) NULL,
    [Name]                          VARCHAR (256) NULL,
    [Note]                          TEXT          NULL,
    [CostPrimaryEntered]            FLOAT (53)    NULL,
    [CostPrimaryAssigned]           FLOAT (53)    NULL,
    [CostPrimaryBOC]                FLOAT (53)    NULL,
    [CostReceivedBOC]               FLOAT (53)    NULL,
    [CostReceivedAssigned]          FLOAT (53)    NULL,
    [CostGivenBOC]                  FLOAT (53)    NULL,
    [CostGivenAssigned]             FLOAT (53)    NULL,
    [UnitCostEntered]               FLOAT (53)    NULL,
    [IdleCost]                      FLOAT (53)    NULL,
    [InventoryCost]                 FLOAT (53)    NULL,
    [Revenue]                       FLOAT (53)    NULL,
    [TotalDriverQuantityBasic]      FLOAT (53)    NULL,
    [TotalDriverQuantityCalculated] FLOAT (53)    NULL,
    [UserTotalDriverQuantity]       FLOAT (53)    NULL,
    [SoldQuantity]                  FLOAT (53)    NULL,
    [UserInputQuantity]             FLOAT (53)    NULL,
    [UserOutputQuantity]            FLOAT (53)    NULL,
    [ConsumedBOCQuantity]           FLOAT (53)    NULL,
    [Measure]                       VARCHAR (64)  NULL,
    [UnitCostType]                  BIT           NULL,
    [AllocatedCostIn]               FLOAT (53)    NULL,
    [AllocatedCost]                 FLOAT (53)    NULL,
    [AssignedIdleQuantity]          FLOAT (53)    NULL,
    [UnassignedCost]                FLOAT (53)    NULL,
    [CalcError]                     SMALLINT      NULL,
    [PublishName]                   VARCHAR (64)  NULL,
    [IsBehavior]                    INT           NULL,
    [Dim1001]                       INT           NULL,
    [Dim1002]                       INT           NULL,
    [Dim1003]                       INT           NULL,
    [Dim1004]                       INT           NULL,
    [Dim1005]                       INT           NULL,
    [Dim1006]                       INT           NULL,
    [Dim1007]                       INT           NULL,
    [Dim1008]                       INT           NULL,
    [Dim1009]                       INT           NULL,
    [Dim1010]                       INT           NULL,
    [Dim1011]                       INT           NULL,
    [Dim1012]                       INT           NULL,
    [Drivername]                    VARCHAR (64)  NULL
)
WITH (DATA_COMPRESSION = PAGE);




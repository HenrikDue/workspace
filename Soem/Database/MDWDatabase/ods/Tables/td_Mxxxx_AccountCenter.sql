﻿CREATE TABLE [ods].[td_Mxxxx_AccountCenter] (
    [AllocatedCost]                 FLOAT (53)    NULL,
    [AllocatedCostIn]               FLOAT (53)    NULL,
    [AssignedIdleQuantity]          FLOAT (53)    NULL,
    [BalAdjType]                    SMALLINT      NULL,
    [CalcError]                     SMALLINT      NULL,
    [ConsumedBOCQuantity]           FLOAT (53)    NULL,
    [CostGivenAssigned]             FLOAT (53)    NULL,
    [CostGivenBOC]                  FLOAT (53)    NULL,
    [CostPrimaryAssigned]           FLOAT (53)    NULL,
    [CostPrimaryBOC]                FLOAT (53)    NULL,
    [CostPrimaryEntered]            FLOAT (53)    NULL,
    [CostReceivedAssigned]          FLOAT (53)    NULL,
    [CostReceivedBOC]               FLOAT (53)    NULL,
    [DestinationId]                 INT           NULL,
    [DriverId]                      INT           NULL,
    [Drivername]                    VARCHAR (64)  NULL,
    [Id]                            INT           NULL,
    [IdleCost]                      FLOAT (53)    NULL,
    [InventoryCost]                 FLOAT (53)    NULL,
    [IsBehavior]                    INT           NULL,
    [Measure]                       VARCHAR (64)  NULL,
    [ModuleId]                      SMALLINT      NULL,
    [Name]                          VARCHAR (256) NULL,
    [Note]                          TEXT          NULL,
    [PeriodId]                      SMALLINT      NULL,
    [PublishName]                   VARCHAR (64)  NULL,
    [Refnum]                        VARCHAR (256) NULL,
    [Revenue]                       FLOAT (53)    NULL,
    [ScenarioId]                    SMALLINT      NULL,
    [SoldQuantity]                  FLOAT (53)    NULL,
    [SourceId]                      INT           NULL,
    [TotalDriverQuantityBasic]      FLOAT (53)    NULL,
    [TotalDriverQuantityCalculated] FLOAT (53)    NULL,
    [Type]                          SMALLINT      NULL,
    [UnassignedCost]                FLOAT (53)    NULL,
    [UnitCostEntered]               FLOAT (53)    NULL,
    [UnitCostType]                  BIT           NULL,
    [UserInputQuantity]             FLOAT (53)    NULL,
    [UserOutputQuantity]            FLOAT (53)    NULL,
    [UserTotalDriverQuantity]       FLOAT (53)    NULL,
    [Produktlitra]                  INT           NULL,
    [Segment]                       INT           NULL,
    [Prodgruppe]                    INT           NULL,
    [Togsystem]                     INT           NULL,
    [Funktionskun]                  INT           NULL,
    [Produktvaria]                  INT           NULL,
    [Ressourcetyp]                  INT           NULL,
    [Activity]                      INT           NULL,
    [CostObject]                    INT           NULL,
    [ExternalUnit]                  INT           NULL,
    [MængdeEnhed]                   INT           NULL,
    [Resource]                      INT           NULL
);




GO
CREATE CLUSTERED INDEX [refnum]
    ON [ods].[td_Mxxxx_AccountCenter]([Refnum] ASC) WITH (DATA_COMPRESSION = PAGE);




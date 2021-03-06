﻿CREATE TABLE [dbo].[ABC_R_DRDEF_Manuelle] (
    [DriverName]                  VARCHAR (50)  NOT NULL,
    [DriverType]                  VARCHAR (50)  NULL,
    [Formula]                     VARCHAR (255) NULL,
    [SequenceNumber]              NUMERIC (12)  NULL,
    [FixedDriverQuantityOverride] VARCHAR (50)  NULL,
    [UseWeightedQuantities]       INT           NULL,
    [Periode]                     VARCHAR (50)  NOT NULL
)
WITH (DATA_COMPRESSION = PAGE);




CREATE TABLE [ods].[ctl_dataload_dummy_fk_to_avoid_truncate] (
    [kilde_system] VARCHAR (12) NOT NULL,
    [variable]     VARCHAR (50) NOT NULL,
    CONSTRAINT [FK_dummy] FOREIGN KEY ([kilde_system], [variable]) REFERENCES [ods].[CTL_Dataload] ([Kilde_System], [Variable])
);


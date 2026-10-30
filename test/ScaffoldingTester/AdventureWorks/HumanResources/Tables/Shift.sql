CREATE TABLE [HumanResources].[Shift] (
    [ShiftID] TINYINT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [StartTime] TIME (7) NOT NULL,
    [EndTime] TIME (7) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Shift_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Shift_ShiftID] PRIMARY KEY CLUSTERED ([ShiftID] ASC)
);

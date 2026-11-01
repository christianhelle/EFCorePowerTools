CREATE TABLE [Production].[Location] (
    [LocationID] SMALLINT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [CostRate] SMALLMONEY CONSTRAINT [DF_Location_CostRate] DEFAULT ((0.00)) NOT NULL,
    [Availability] DECIMAL (8, 2) CONSTRAINT [DF_Location_Availability] DEFAULT ((0.00)) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Location_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Location_LocationID] PRIMARY KEY CLUSTERED ([LocationID] ASC)
);

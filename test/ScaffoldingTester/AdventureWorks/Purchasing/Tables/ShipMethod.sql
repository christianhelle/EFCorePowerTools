CREATE TABLE [Purchasing].[ShipMethod] (
    [ShipMethodID] INT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [ShipBase] MONEY CONSTRAINT [DF_ShipMethod_ShipBase] DEFAULT ((0.00)) NOT NULL,
    [ShipRate] MONEY CONSTRAINT [DF_ShipMethod_ShipRate] DEFAULT ((0.00)) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_ShipMethod_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ShipMethod_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ShipMethod_ShipMethodID] PRIMARY KEY CLUSTERED ([ShipMethodID] ASC)
);

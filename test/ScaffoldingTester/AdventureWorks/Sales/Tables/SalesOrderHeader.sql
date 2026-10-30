CREATE TABLE [Sales].[SalesOrderHeader] (
    [SalesOrderID] INT IDENTITY (1, 1) NOT NULL,
    [RevisionNumber] TINYINT CONSTRAINT [DF_SalesOrderHeader_RevisionNumber] DEFAULT ((0)) NOT NULL,
    [OrderDate] DATETIME CONSTRAINT [DF_SalesOrderHeader_OrderDate] DEFAULT (getdate()) NOT NULL,
    [DueDate] DATETIME NOT NULL,
    [ShipDate] DATETIME NULL,
    [Status] TINYINT CONSTRAINT [DF_SalesOrderHeader_Status] DEFAULT ((1)) NOT NULL,
    [OnlineOrderFlag] BIT CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag] DEFAULT ((1)) NOT NULL,
    [SalesOrderNumber] AS (isnull(N'SO' + CONVERT([nvarchar](23), [SalesOrderID]), N'*** ERROR ***')),
    [PurchaseOrderNumber] NVARCHAR (25) NULL,
    [AccountNumber] NVARCHAR (15) NULL,
    [CustomerID] INT NOT NULL,
    [SalesPersonID] INT NULL,
    [TerritoryID] INT NULL,
    [BillToAddressID] INT NOT NULL,
    [ShipToAddressID] INT NOT NULL,
    [ShipMethodID] INT NOT NULL,
    [CreditCardID] INT NULL,
    [CurrencyCode] NCHAR (3) NULL,
    [SubTotal] MONEY CONSTRAINT [DF_SalesOrderHeader_SubTotal] DEFAULT ((0.00)) NOT NULL,
    [TaxAmt] MONEY CONSTRAINT [DF_SalesOrderHeader_TaxAmt] DEFAULT ((0.00)) NOT NULL,
    [Freight] MONEY CONSTRAINT [DF_SalesOrderHeader_Freight] DEFAULT ((0.00)) NOT NULL,
    [TotalDue] AS (isnull(([SubTotal] + [TaxAmt]) + [Freight], (0))),
    [Comment] NVARCHAR (128) NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_SalesOrderHeader_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_SalesOrderHeader_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY CLUSTERED ([SalesOrderID] ASC),
    CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID] FOREIGN KEY ([BillToAddressID]) REFERENCES [Person].[Address] ([AddressID]),
    CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID] FOREIGN KEY ([ShipToAddressID]) REFERENCES [Person].[Address] ([AddressID]),
    CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID] FOREIGN KEY ([CreditCardID]) REFERENCES [Sales].[CreditCard] ([CreditCardID]),
    CONSTRAINT [FK_SalesOrderHeader_Currency_CurrencyCode] FOREIGN KEY ([CurrencyCode]) REFERENCES [Sales].[Currency] ([CurrencyCode]),
    CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer] ([CustomerID]),
    CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID]),
    CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID]),
    CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([ShipMethodID]) REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])
);


GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderHeader_CustomerID]
    ON [Sales].[SalesOrderHeader]([CustomerID] ASC);

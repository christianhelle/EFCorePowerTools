CREATE TABLE [Sales].[SalesPerson] (
    [BusinessEntityID] INT NOT NULL,
    [TerritoryID] INT NULL,
    [SalesQuota] MONEY NULL,
    [Bonus] MONEY CONSTRAINT [DF_SalesPerson_Bonus] DEFAULT ((0.00)) NOT NULL,
    [CommissionPct] SMALLMONEY CONSTRAINT [DF_SalesPerson_CommissionPct] DEFAULT ((0.00)) NOT NULL,
    [SalesYTD] MONEY CONSTRAINT [DF_SalesPerson_SalesYTD] DEFAULT ((0.00)) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_SalesPerson_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_SalesPerson_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
);

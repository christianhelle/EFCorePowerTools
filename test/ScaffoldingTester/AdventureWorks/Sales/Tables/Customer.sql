CREATE TABLE [Sales].[Customer] (
    [CustomerID] INT IDENTITY (1, 1) NOT NULL,
    [PersonID] INT NULL,
    [StoreID] INT NULL,
    [TerritoryID] INT NULL,
    [AccountNumber] AS (isnull('AW' + right('00000000' + CONVERT([varchar](10), [CustomerID]), (8)), '')),
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID] ASC),
    CONSTRAINT [FK_Customer_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person].[Person] ([BusinessEntityID]),
    CONSTRAINT [FK_Customer_Store_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [Sales].[Store] ([BusinessEntityID]),
    CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
);

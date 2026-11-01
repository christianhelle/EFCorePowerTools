CREATE TABLE [Sales].[SalesTerritory] (
    [TerritoryID] INT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [CountryRegionCode] NVARCHAR (3) NOT NULL,
    [Group] NVARCHAR (50) NOT NULL,
    [SalesYTD] MONEY CONSTRAINT [DF_SalesTerritory_SalesYTD] DEFAULT ((0.00)) NOT NULL,
    [SalesLastYear] MONEY CONSTRAINT [DF_SalesTerritory_SalesLastYear] DEFAULT ((0.00)) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_SalesTerritory_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_SalesTerritory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED ([TerritoryID] ASC),
    CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [Person].[CountryRegion] ([CountryRegionCode])
);

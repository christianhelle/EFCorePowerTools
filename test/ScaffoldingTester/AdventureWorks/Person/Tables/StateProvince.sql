CREATE TABLE [Person].[StateProvince] (
    [StateProvinceID] INT IDENTITY (1, 1) NOT NULL,
    [StateProvinceCode] NCHAR (3) NOT NULL,
    [CountryRegionCode] NVARCHAR (3) NOT NULL,
    [IsOnlyStateProvinceFlag] BIT CONSTRAINT [DF_StateProvince_IsOnlyStateProvinceFlag] DEFAULT ((1)) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [TerritoryID] INT NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_StateProvince_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_StateProvince_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_StateProvince_StateProvinceID] PRIMARY KEY CLUSTERED ([StateProvinceID] ASC),
    CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [Person].[CountryRegion] ([CountryRegionCode]),
    CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
);

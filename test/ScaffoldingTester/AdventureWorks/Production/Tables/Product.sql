CREATE TABLE [Production].[Product] (
    [ProductID] INT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [ProductNumber] NVARCHAR (25) NOT NULL,
    [MakeFlag] BIT CONSTRAINT [DF_Product_MakeFlag] DEFAULT ((1)) NOT NULL,
    [FinishedGoodsFlag] BIT CONSTRAINT [DF_Product_FinishedGoodsFlag] DEFAULT ((1)) NOT NULL,
    [Color] NVARCHAR (15) NULL,
    [SafetyStockLevel] SMALLINT NOT NULL,
    [ReorderPoint] SMALLINT NOT NULL,
    [StandardCost] MONEY NOT NULL,
    [ListPrice] MONEY NOT NULL,
    [Size] NVARCHAR (5) NULL,
    [SizeUnitMeasureCode] NCHAR (3) NULL,
    [WeightUnitMeasureCode] NCHAR (3) NULL,
    [Weight] DECIMAL (8, 2) NULL,
    [DaysToManufacture] INT NOT NULL,
    [ProductSubcategoryID] INT NULL,
    [ProductModelID] INT NULL,
    [SellStartDate] DATETIME NOT NULL,
    [SellEndDate] DATETIME NULL,
    [DiscontinuedDate] DATETIME NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_Product_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [CK_Product_ListPrice] CHECK ([ListPrice] >= (0.00)),
    CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [Production].[ProductModel] ([ProductModelID]),
    CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY ([ProductSubcategoryID]) REFERENCES [Production].[ProductSubcategory] ([ProductSubcategoryID]),
    CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY ([SizeUnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode]),
    CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode] FOREIGN KEY ([WeightUnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_Product_ProductNumber]
    ON [Production].[Product]([ProductNumber] ASC);

CREATE TABLE [Production].[ProductSubcategory] (
    [ProductSubcategoryID] INT IDENTITY (1, 1) NOT NULL,
    [ProductCategoryID] INT NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_ProductSubcategory_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ProductSubcategory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID] PRIMARY KEY CLUSTERED ([ProductSubcategoryID] ASC),
    CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [Production].[ProductCategory] ([ProductCategoryID])
);

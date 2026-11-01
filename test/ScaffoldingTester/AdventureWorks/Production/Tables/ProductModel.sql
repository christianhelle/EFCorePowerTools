CREATE TABLE [Production].[ProductModel] (
    [ProductModelID] INT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [CatalogDescription] NVARCHAR (MAX) NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_ProductModel_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ProductModel_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED ([ProductModelID] ASC)
);

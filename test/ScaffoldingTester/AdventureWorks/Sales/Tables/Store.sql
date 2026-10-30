CREATE TABLE [Sales].[Store] (
    [BusinessEntityID] INT NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [SalesPersonID] INT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_Store_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Store_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Store_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [FK_Store_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID]),
    CONSTRAINT [FK_Store_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
);

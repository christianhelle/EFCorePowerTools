CREATE TABLE [Purchasing].[ProductVendor] (
    [ProductID] INT NOT NULL,
    [BusinessEntityID] INT NOT NULL,
    [AverageLeadTime] INT NOT NULL,
    [StandardPrice] MONEY NOT NULL,
    [LastReceiptCost] MONEY NULL,
    [MinOrderQty] INT NOT NULL,
    [MaxOrderQty] INT NOT NULL,
    [UnitMeasureCode] NCHAR (3) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ProductVendor_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID] PRIMARY KEY CLUSTERED ([ProductID] ASC, [BusinessEntityID] ASC),
    CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([UnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode]),
    CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
);

CREATE TABLE [Purchasing].[PurchaseOrderDetail] (
    [PurchaseOrderID] INT NOT NULL,
    [PurchaseOrderDetailID] INT IDENTITY (1, 1) NOT NULL,
    [DueDate] DATETIME NOT NULL,
    [OrderQty] SMALLINT NOT NULL,
    [ProductID] INT NOT NULL,
    [UnitPrice] MONEY NOT NULL,
    [LineTotal] AS (isnull([OrderQty] * [UnitPrice], (0.00))),
    [ReceivedQty] DECIMAL (8, 2) NOT NULL,
    [RejectedQty] DECIMAL (8, 2) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] PRIMARY KEY CLUSTERED ([PurchaseOrderID] ASC, [PurchaseOrderDetailID] ASC),
    CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID] FOREIGN KEY ([PurchaseOrderID]) REFERENCES [Purchasing].[PurchaseOrderHeader] ([PurchaseOrderID])
);

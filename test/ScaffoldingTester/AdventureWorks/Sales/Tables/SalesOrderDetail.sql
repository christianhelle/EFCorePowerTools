CREATE TABLE [Sales].[SalesOrderDetail] (
    [SalesOrderID] INT NOT NULL,
    [SalesOrderDetailID] INT IDENTITY (1, 1) NOT NULL,
    [CarrierTrackingNumber] NVARCHAR (25) NULL,
    [OrderQty] SMALLINT NOT NULL,
    [ProductID] INT NOT NULL,
    [SpecialOfferID] INT NOT NULL,
    [UnitPrice] MONEY NOT NULL,
    [UnitPriceDiscount] MONEY CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount] DEFAULT ((0.0)) NOT NULL,
    [LineTotal] AS (isnull(([UnitPrice] * ((1.0) - [UnitPriceDiscount])) * [OrderQty], (0.0))),
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_SalesOrderDetail_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_SalesOrderDetail_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED ([SalesOrderID] ASC, [SalesOrderDetailID] ASC),
    CONSTRAINT [FK_SalesOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID]),
    CONSTRAINT [FK_SalesOrderDetail_SpecialOffer_SpecialOfferID] FOREIGN KEY ([SpecialOfferID]) REFERENCES [Sales].[SpecialOffer] ([SpecialOfferID])
);

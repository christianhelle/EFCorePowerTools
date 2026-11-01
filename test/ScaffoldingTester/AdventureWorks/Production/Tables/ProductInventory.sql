CREATE TABLE [Production].[ProductInventory] (
    [ProductID] INT NOT NULL,
    [LocationID] SMALLINT NOT NULL,
    [Shelf] NVARCHAR (10) NOT NULL,
    [Bin] TINYINT NOT NULL,
    [Quantity] SMALLINT CONSTRAINT [DF_ProductInventory_Quantity] DEFAULT ((0)) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_ProductInventory_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ProductInventory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductInventory_ProductID_LocationID] PRIMARY KEY CLUSTERED ([ProductID] ASC, [LocationID] ASC),
    CONSTRAINT [FK_ProductInventory_Location_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [Production].[Location] ([LocationID]),
    CONSTRAINT [FK_ProductInventory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);

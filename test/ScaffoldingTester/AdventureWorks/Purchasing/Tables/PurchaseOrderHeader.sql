CREATE TABLE [Purchasing].[PurchaseOrderHeader] (
    [PurchaseOrderID] INT IDENTITY (1, 1) NOT NULL,
    [RevisionNumber] TINYINT CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber] DEFAULT ((0)) NOT NULL,
    [Status] TINYINT CONSTRAINT [DF_PurchaseOrderHeader_Status] DEFAULT ((1)) NOT NULL,
    [EmployeeID] INT NOT NULL,
    [VendorID] INT NOT NULL,
    [ShipMethodID] INT NOT NULL,
    [OrderDate] DATETIME CONSTRAINT [DF_PurchaseOrderHeader_OrderDate] DEFAULT (getdate()) NOT NULL,
    [ShipDate] DATETIME NULL,
    [SubTotal] MONEY CONSTRAINT [DF_PurchaseOrderHeader_SubTotal] DEFAULT ((0.00)) NOT NULL,
    [TaxAmt] MONEY CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt] DEFAULT ((0.00)) NOT NULL,
    [Freight] MONEY CONSTRAINT [DF_PurchaseOrderHeader_Freight] DEFAULT ((0.00)) NOT NULL,
    [TotalDue] AS (isnull(([SubTotal] + [TaxAmt]) + [Freight], (0))) PERSISTED NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY CLUSTERED ([PurchaseOrderID] ASC),
    CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([ShipMethodID]) REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID]),
    CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY ([VendorID]) REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
);

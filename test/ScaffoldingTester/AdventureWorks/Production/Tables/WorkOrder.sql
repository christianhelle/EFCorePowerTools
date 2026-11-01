CREATE TABLE [Production].[WorkOrder] (
    [WorkOrderID] INT IDENTITY (1, 1) NOT NULL,
    [ProductID] INT NOT NULL,
    [OrderQty] INT NOT NULL,
    [StockedQty] AS (isnull([OrderQty] - [ScrappedQty], (0))),
    [ScrappedQty] SMALLINT NOT NULL,
    [StartDate] DATETIME NOT NULL,
    [EndDate] DATETIME NULL,
    [DueDate] DATETIME NOT NULL,
    [ScrapReasonID] SMALLINT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_WorkOrder_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_WorkOrder_WorkOrderID] PRIMARY KEY CLUSTERED ([WorkOrderID] ASC),
    CONSTRAINT [FK_WorkOrder_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID] FOREIGN KEY ([ScrapReasonID]) REFERENCES [Production].[ScrapReason] ([ScrapReasonID])
);

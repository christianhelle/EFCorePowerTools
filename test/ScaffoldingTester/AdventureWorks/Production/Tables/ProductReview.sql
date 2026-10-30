CREATE TABLE [Production].[ProductReview] (
    [ProductReviewID] INT IDENTITY (1, 1) NOT NULL,
    [ProductID] INT NOT NULL,
    [ReviewerName] NVARCHAR (50) NOT NULL,
    [ReviewDate] DATETIME CONSTRAINT [DF_ProductReview_ReviewDate] DEFAULT (getdate()) NOT NULL,
    [EmailAddress] NVARCHAR (50) NOT NULL,
    [Rating] INT NOT NULL,
    [Comments] NVARCHAR (3850) NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ProductReview_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductReview_ProductReviewID] PRIMARY KEY CLUSTERED ([ProductReviewID] ASC),
    CONSTRAINT [CK_ProductReview_Rating] CHECK ([Rating] >= (1) AND [Rating] <= (5)),
    CONSTRAINT [FK_ProductReview_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);

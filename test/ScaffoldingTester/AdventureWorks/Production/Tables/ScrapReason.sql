CREATE TABLE [Production].[ScrapReason] (
    [ScrapReasonID] SMALLINT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_ScrapReason_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ScrapReason_ScrapReasonID] PRIMARY KEY CLUSTERED ([ScrapReasonID] ASC)
);

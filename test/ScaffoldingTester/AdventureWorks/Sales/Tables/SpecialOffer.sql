CREATE TABLE [Sales].[SpecialOffer] (
    [SpecialOfferID] INT IDENTITY (1, 1) NOT NULL,
    [Description] NVARCHAR (255) NOT NULL,
    [DiscountPct] SMALLMONEY CONSTRAINT [DF_SpecialOffer_DiscountPct] DEFAULT ((0.00)) NOT NULL,
    [Type] NVARCHAR (50) NOT NULL,
    [Category] NVARCHAR (50) NOT NULL,
    [StartDate] DATETIME NOT NULL,
    [EndDate] DATETIME NOT NULL,
    [MinQty] INT CONSTRAINT [DF_SpecialOffer_MinQty] DEFAULT ((0)) NOT NULL,
    [MaxQty] INT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_SpecialOffer_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_SpecialOffer_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SpecialOffer_SpecialOfferID] PRIMARY KEY CLUSTERED ([SpecialOfferID] ASC)
);

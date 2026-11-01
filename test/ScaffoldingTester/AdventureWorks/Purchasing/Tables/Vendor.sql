CREATE TABLE [Purchasing].[Vendor] (
    [BusinessEntityID] INT NOT NULL,
    [AccountNumber] NVARCHAR (15) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [CreditRating] TINYINT NOT NULL,
    [PreferredVendorStatus] BIT CONSTRAINT [DF_Vendor_PreferredVendorStatus] DEFAULT ((1)) NOT NULL,
    [ActiveFlag] BIT CONSTRAINT [DF_Vendor_ActiveFlag] DEFAULT ((1)) NOT NULL,
    [PurchasingWebServiceURL] NVARCHAR (1024) NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Vendor_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Vendor_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);

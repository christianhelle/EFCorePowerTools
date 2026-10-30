CREATE TABLE [Person].[AddressType] (
    [AddressTypeID] INT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_AddressType_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_AddressType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_AddressType_AddressTypeID] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC)
);

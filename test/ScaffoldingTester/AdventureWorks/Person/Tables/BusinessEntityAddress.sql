CREATE TABLE [Person].[BusinessEntityAddress] (
    [BusinessEntityID] INT NOT NULL,
    [AddressID] INT NOT NULL,
    [AddressTypeID] INT NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_BusinessEntityAddress_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_BusinessEntityAddress_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC, [AddressID] ASC, [AddressTypeID] ASC),
    CONSTRAINT [FK_BusinessEntityAddress_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Person].[Address] ([AddressID]),
    CONSTRAINT [FK_BusinessEntityAddress_AddressType_AddressTypeID] FOREIGN KEY ([AddressTypeID]) REFERENCES [Person].[AddressType] ([AddressTypeID]),
    CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);

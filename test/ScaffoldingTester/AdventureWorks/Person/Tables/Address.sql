CREATE TABLE [Person].[Address] (
    [AddressID] INT IDENTITY (1, 1) NOT NULL,
    [AddressLine1] NVARCHAR (60) NOT NULL,
    [AddressLine2] NVARCHAR (60) NULL,
    [City] NVARCHAR (30) NOT NULL,
    [StateProvinceID] INT NOT NULL,
    [PostalCode] NVARCHAR (15) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_Address_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressID] ASC),
    CONSTRAINT [FK_Address_StateProvince_StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [Person].[StateProvince] ([StateProvinceID])
);


GO

CREATE NONCLUSTERED INDEX [IX_Address_StateProvinceID]
    ON [Person].[Address]([StateProvinceID] ASC);

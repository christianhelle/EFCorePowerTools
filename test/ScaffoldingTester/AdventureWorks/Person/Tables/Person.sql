CREATE TABLE [Person].[Person] (
    [BusinessEntityID] INT NOT NULL,
    [PersonType] NCHAR (2) NOT NULL,
    [NameStyle] BIT CONSTRAINT [DF_Person_NameStyle] DEFAULT ((0)) NOT NULL,
    [Title] NVARCHAR (8) NULL,
    [FirstName] NVARCHAR (50) NOT NULL,
    [MiddleName] NVARCHAR (50) NULL,
    [LastName] NVARCHAR (50) NOT NULL,
    [Suffix] NVARCHAR (10) NULL,
    [EmailPromotion] INT CONSTRAINT [DF_Person_EmailPromotion] DEFAULT ((0)) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_Person_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Person_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [CK_Person_EmailPromotion] CHECK ([EmailPromotion] >= (0) AND [EmailPromotion] <= (2)),
    CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);


GO

CREATE NONCLUSTERED INDEX [IX_Person_LastName_FirstName_MiddleName]
    ON [Person].[Person]([LastName] ASC, [FirstName] ASC, [MiddleName] ASC);


GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'Person';

CREATE TABLE [HumanResources].[Employee] (
    [BusinessEntityID] INT NOT NULL,
    [NationalIDNumber] NVARCHAR (15) NOT NULL,
    [LoginID] NVARCHAR (256) NOT NULL,
    [JobTitle] NVARCHAR (50) NOT NULL,
    [BirthDate] DATE NOT NULL,
    [MaritalStatus] NCHAR (1) NOT NULL,
    [Gender] NCHAR (1) NOT NULL,
    [HireDate] DATE NOT NULL,
    [SalariedFlag] BIT CONSTRAINT [DF_Employee_SalariedFlag] DEFAULT ((1)) NOT NULL,
    [VacationHours] SMALLINT CONSTRAINT [DF_Employee_VacationHours] DEFAULT ((0)) NOT NULL,
    [SickLeaveHours] SMALLINT CONSTRAINT [DF_Employee_SickLeaveHours] DEFAULT ((0)) NOT NULL,
    [CurrentFlag] BIT CONSTRAINT [DF_Employee_CurrentFlag] DEFAULT ((1)) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER CONSTRAINT [DF_Employee_rowguid] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [CK_Employee_Gender] CHECK (upper([Gender]) = 'F' OR upper([Gender]) = 'M'),
    CONSTRAINT [CK_Employee_MaritalStatus] CHECK (upper([MaritalStatus]) = 'S' OR upper([MaritalStatus]) = 'M'),
    CONSTRAINT [FK_Employee_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_LoginID]
    ON [HumanResources].[Employee]([LoginID] ASC);

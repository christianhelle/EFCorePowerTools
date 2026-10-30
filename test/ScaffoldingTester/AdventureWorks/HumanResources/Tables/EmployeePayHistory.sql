CREATE TABLE [HumanResources].[EmployeePayHistory] (
    [BusinessEntityID] INT NOT NULL,
    [RateChangeDate] DATETIME NOT NULL,
    [Rate] MONEY NOT NULL,
    [PayFrequency] TINYINT NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_EmployeePayHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC, [RateChangeDate] ASC),
    CONSTRAINT [FK_EmployeePayHistory_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
);

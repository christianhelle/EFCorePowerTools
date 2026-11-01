CREATE TABLE [HumanResources].[Department] (
    [DepartmentID] SMALLINT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [GroupName] NVARCHAR (50) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_Department_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);

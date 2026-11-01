CREATE TABLE [Person].[PhoneNumberType] (
    [PhoneNumberTypeID] INT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_PhoneNumberType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PhoneNumberType_PhoneNumberTypeID] PRIMARY KEY CLUSTERED ([PhoneNumberTypeID] ASC)
);

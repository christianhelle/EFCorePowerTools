CREATE TABLE [Person].[CountryRegion] (
    [CountryRegionCode] NVARCHAR (3) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [ModifiedDate] DATETIME CONSTRAINT [DF_CountryRegion_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY CLUSTERED ([CountryRegionCode] ASC)
);


GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_CountryRegion_Name]
    ON [Person].[CountryRegion]([Name] ASC);

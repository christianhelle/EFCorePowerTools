CREATE VIEW [HumanResources].[vEmployee]
AS
SELECT
    e.[BusinessEntityID],
    p.[Title],
    p.[FirstName],
    p.[MiddleName],
    p.[LastName],
    p.[Suffix],
    e.[JobTitle],
    ea.[EmailAddress],
    p.[EmailPromotion]
FROM [HumanResources].[Employee] e
    INNER JOIN [Person].[Person] p
    ON p.[BusinessEntityID] = e.[BusinessEntityID]
    LEFT OUTER JOIN [Person].[EmailAddress] ea
    ON p.[BusinessEntityID] = ea.[BusinessEntityID];

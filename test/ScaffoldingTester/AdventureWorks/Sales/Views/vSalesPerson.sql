CREATE VIEW [Sales].[vSalesPerson]
AS
SELECT
    s.[BusinessEntityID],
    p.[FirstName],
    p.[LastName],
    e.[JobTitle],
    st.[Name] AS [TerritoryName],
    st.[Group] AS [TerritoryGroup],
    s.[SalesQuota],
    s.[SalesYTD]
FROM [Sales].[SalesPerson] s
    INNER JOIN [HumanResources].[Employee] e
    ON e.[BusinessEntityID] = s.[BusinessEntityID]
    INNER JOIN [Person].[Person] p
    ON p.[BusinessEntityID] = s.[BusinessEntityID]
    LEFT OUTER JOIN [Sales].[SalesTerritory] st
    ON st.[TerritoryID] = s.[TerritoryID];

CREATE PROCEDURE [HumanResources].[uspGetEmployeesByDepartment]
    @DepartmentID SMALLINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT e.[BusinessEntityID], e.[JobTitle], h.[StartDate]
    FROM [HumanResources].[Employee] e
        INNER JOIN [HumanResources].[EmployeeDepartmentHistory] h
        ON h.[BusinessEntityID] = e.[BusinessEntityID]
    WHERE h.[DepartmentID] = @DepartmentID
        AND h.[EndDate] IS NULL;
END;

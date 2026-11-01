CREATE FUNCTION [Sales].[ufnGetCustomerOrderCount](@CustomerID INT)
RETURNS INT
AS
BEGIN
    DECLARE @ret INT;

    SELECT @ret = COUNT(*)
    FROM [Sales].[SalesOrderHeader] h
    WHERE h.[CustomerID] = @CustomerID;

    RETURN @ret;
END;

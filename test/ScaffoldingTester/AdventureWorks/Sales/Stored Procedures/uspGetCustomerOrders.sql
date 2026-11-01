CREATE PROCEDURE [Sales].[uspGetCustomerOrders]
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT h.[SalesOrderID], h.[OrderDate], h.[Status], h.[TotalDue]
    FROM [Sales].[SalesOrderHeader] h
    WHERE h.[CustomerID] = @CustomerID;
END;

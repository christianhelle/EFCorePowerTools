CREATE FUNCTION [dbo].[ufnGetStock](@ProductID INT)
RETURNS INT
AS
BEGIN
    DECLARE @ret INT;

    SELECT @ret = SUM(p.[Quantity])
    FROM [Production].[ProductInventory] p
    WHERE p.[ProductID] = @ProductID
        AND p.[LocationID] = '6';

    IF (@ret IS NULL)
        SET @ret = 0;

    RETURN @ret;
END;

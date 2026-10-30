CREATE PROCEDURE [HumanResources].[uspUpdateEmployeeHireInfo]
    @BusinessEntityID INT,
    @JobTitle NVARCHAR(50),
    @HireDate DATETIME,
    @RateChangeDate DATETIME,
    @Rate MONEY,
    @PayFrequency TINYINT,
    @CurrentFlag BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    UPDATE [HumanResources].[Employee]
    SET [JobTitle] = @JobTitle,
        [HireDate] = @HireDate,
        [CurrentFlag] = @CurrentFlag
    WHERE [BusinessEntityID] = @BusinessEntityID;

    INSERT INTO [HumanResources].[EmployeePayHistory]
        ([BusinessEntityID], [RateChangeDate], [Rate], [PayFrequency])
    VALUES (@BusinessEntityID, @RateChangeDate, @Rate, @PayFrequency);

    COMMIT TRANSACTION;
END;

CREATE PROCEDURE [dbo].[DW_MergeDimEmployee]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE de
    SET [LastName]        = se.[LastName]
       ,[FirstName]       = se.[FirstName]
       ,[FullName]        = se.[FullName]
       ,[Title]           = se.[Title]
       ,[TitleOfCourtesy] = se.[TitleOfCourtesy]
       ,[BirthDate]       = se.[BirthDate]
       ,[HireDate]        = se.[HireDate]
       ,[City]            = se.[City]
       ,[Region]          = se.[Region]
       ,[Country]         = se.[Country]
       ,[ReportsTo]       = se.[ReportsTo]
       ,[SupervisorName]  = se.[SupervisorName]
    FROM [dbo].[DimEmployee] de
        INNER JOIN [staging].[employee] se ON de.[EmployeeID] = se.[EmployeeID];
END
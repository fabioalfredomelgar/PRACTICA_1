CREATE PROCEDURE [dbo].[DW_MergedDimEmployee]
AS
BEGIN
    UPDATE de
    SET [EmployeeID]       = se.[EmployeeID]
        ,[LastName]        = se.[LastName]
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
    INNER JOIN [staging].[employee] se ON (de.[EmployeeKey] = se.[EmployeeKey])
END
GO
CREATE PROCEDURE [dbo].[GetEmployeeChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT e.[EmployeeID]
        ,e.[LastName]
        ,e.[FirstName]
        ,[FullName] = e.[FirstName] + N' ' + e.[LastName]
        ,e.[Title]
        ,e.[TitleOfCourtesy]
        ,[BirthDate] = CONVERT(DATE, e.[BirthDate])
        ,[HireDate] = CONVERT(DATE, e.[HireDate])
        ,e.[City]
        ,e.[Region]
        ,e.[Country]
        ,e.[ReportsTo]
        ,[SupervisorName] = s.[FirstName] + N' ' + s.[LastName]
    FROM [dbo].[Employees] e
        LEFT JOIN [dbo].[Employees] s ON e.[ReportsTo] = s.[EmployeeID]
    WHERE (e.[rowversion] > CONVERT(ROWVERSION, @startRow) AND e.[rowversion] <= CONVERT(ROWVERSION, @endRow))
       OR (s.[rowversion] > CONVERT(ROWVERSION, @startRow) AND s.[rowversion] <= CONVERT(ROWVERSION, @endRow))
END
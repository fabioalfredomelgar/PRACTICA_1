CREATE PROCEDURE [dbo].[GetCustomerChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT c.[CustomerID]
        ,c.[CompanyName]
        ,c.[ContactName]
        ,c.[ContactTitle]
        ,c.[Address]
        ,c.[City]
        ,c.[Region]
        ,c.[PostalCode]
        ,c.[Country]
        ,c.[Phone]
        ,c.[Fax]
    FROM [dbo].[Customers] c
    WHERE c.[rowversion] > CONVERT(ROWVERSION, @startRow)
      AND c.[rowversion] <= CONVERT(ROWVERSION, @endRow)
END
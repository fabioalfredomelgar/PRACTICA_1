CREATE PROCEDURE [dbo].[GetProductChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT p.[ProductID]
        ,p.[ProductName]
        ,s.[CompanyName]
        ,c.[CategoryName]
        ,p.[QuantityPerUnit]
        ,p.[UnitPrice]
        ,p.[UnitsInStock]
        ,p.[UnitsOnOrder]
        ,p.[ReorderLevel]
        ,p.[Discontinued]
    FROM
        [dbo].[Products] p
        INNER JOIN [dbo].[Categories] c ON p.CategoryID = c.CategoryID
        INNER JOIN [dbo].[Suppliers] s ON p.SupplierID = s.SupplierID
    WHERE
        (p.[rowversion] > CONVERT(ROWVERSION, @startRow) AND p.[rowversion] <= CONVERT(ROWVERSION, @endRow))
        OR (c.[rowversion] > CONVERT(ROWVERSION, @startRow) AND c.[rowversion] <= CONVERT(ROWVERSION, @endRow))
        OR (s.[rowversion] > CONVERT(ROWVERSION, @startRow) AND s.[rowversion] <= CONVERT(ROWVERSION, @endRow))
END
CREATE PROCEDURE [dbo].[GetLastPackageRowVersion]
(
    @tableName NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [LastRowVersion]
    FROM [dbo].[PackageConfig]
    WHERE [TableName] = @tableName;
END
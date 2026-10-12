CREATE PROCEDURE [dbo].[GetLastRowVersion]
(
    @TableName NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [LastRowVersion]
    FROM [dbo].[PackageConfig]
    WHERE [TableName] = @TableName;
END
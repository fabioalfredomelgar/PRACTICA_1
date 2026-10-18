CREATE PROCEDURE [dbo].[UpdateLastPackageRowVersion]
(
    @tableName NVARCHAR(100),
    @lastRowVersion BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[PackageConfig]
    SET [LastRowVersion] = @lastRowVersion,
        [LastLoadDate] = GETDATE()
    WHERE [TableName] = @tableName;
END
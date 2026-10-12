CREATE PROCEDURE [dbo].[UpdateLastRowVersion]
(
    @TableName NVARCHAR(100),
    @LastRowVersion BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[PackageConfig]
    SET [LastRowVersion] = @LastRowVersion,
        [LastLoadDate] = GETDATE()
    WHERE [TableName] = @TableName;
END
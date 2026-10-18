CREATE TABLE [dbo].[PackageConfig](
    [TableName] [nvarchar](100) NOT NULL,
    [LastRowVersion] [bigint] NOT NULL CONSTRAINT [DF_PackageConfig_LastRowVersion] DEFAULT ((0)),
    [LastLoadDate] [datetime] NULL,
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([TableName] ASC)
);
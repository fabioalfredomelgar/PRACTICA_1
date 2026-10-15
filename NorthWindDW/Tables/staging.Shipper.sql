CREATE TABLE [staging].[DimShipper](
    [ShipperKey] [int] NOT NULL,
    [ShipperID] [int] NOT NULL,
    [CompanyName] [nvarchar](40) NOT NULL,
    [Phone] [nvarchar](24) NULL,
    [LoadDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [staging].[DimShipper] ADD CONSTRAINT [DF_staging_DimShipper_LoadDate] DEFAULT (getdate()) FOR [LoadDate]
GO
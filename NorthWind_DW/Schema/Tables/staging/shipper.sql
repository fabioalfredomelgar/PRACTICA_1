CREATE TABLE [staging].[shipper](
    [ShipperID] [int] NOT NULL,
    [CompanyName] [nvarchar](40) NOT NULL,
    [Phone] [nvarchar](24) NULL,
    CONSTRAINT [PK_staging_shipper] PRIMARY KEY CLUSTERED ([ShipperID] ASC)
);
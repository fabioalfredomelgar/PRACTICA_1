CREATE TABLE [dbo].[DimShipper](
    [ShipperKey] [int] IDENTITY(1,1) NOT NULL,
    [ShipperID] [int] NOT NULL,
    [CompanyName] [nvarchar](40) NOT NULL,
    [Phone] [nvarchar](24) NULL,
    [LoadDate] [datetime] NOT NULL CONSTRAINT [DF_DimShipper_LoadDate] DEFAULT (getdate()),
    CONSTRAINT [PK_DimShipper] PRIMARY KEY CLUSTERED ([ShipperKey] ASC),
    CONSTRAINT [UQ_DimShipper_ShipperID] UNIQUE NONCLUSTERED ([ShipperID] ASC)
);
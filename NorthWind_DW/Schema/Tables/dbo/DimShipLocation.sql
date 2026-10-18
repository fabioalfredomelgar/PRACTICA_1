CREATE TABLE [dbo].[DimShipLocation](
    [ShipLocationKey] [int] IDENTITY(1,1) NOT NULL,
    [ShipCity] [nvarchar](15) NOT NULL CONSTRAINT [DF_DimShipLocation_City] DEFAULT (N'Unknown'),
    [ShipRegion] [nvarchar](15) NOT NULL CONSTRAINT [DF_DimShipLocation_Region] DEFAULT (N'Unknown'),
    [ShipCountry] [nvarchar](15) NOT NULL CONSTRAINT [DF_DimShipLocation_Country] DEFAULT (N'Unknown'),
    [ShipPostalCode] [nvarchar](10) NOT NULL CONSTRAINT [DF_DimShipLocation_Postal] DEFAULT (N'Unknown'),
    [LoadDate] [datetime] NOT NULL CONSTRAINT [DF_DimShipLocation_LoadDate] DEFAULT (getdate()),
    CONSTRAINT [PK_DimShipLocation] PRIMARY KEY CLUSTERED ([ShipLocationKey] ASC),
    CONSTRAINT [UQ_DimShipLocation] UNIQUE NONCLUSTERED ([ShipCity] ASC, [ShipRegion] ASC, [ShipCountry] ASC, [ShipPostalCode] ASC)
);
CREATE TABLE [dbo].[DimShipLocation](
	[ShipLocationKey] [int] IDENTITY(1,1) NOT NULL,
	[ShipCity] [nvarchar](15) NOT NULL,
	[ShipRegion] [nvarchar](15) NOT NULL,
	[ShipCountry] [nvarchar](15) NOT NULL,
	[ShipPostalCode] [nvarchar](10) NOT NULL,
	[LoadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_DimShipLocation] PRIMARY KEY CLUSTERED 
(
	[ShipLocationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_DimShipLocation] UNIQUE NONCLUSTERED 
(
	[ShipCity] ASC,
	[ShipRegion] ASC,
	[ShipCountry] ASC,
	[ShipPostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DimShipLocation] ADD  CONSTRAINT [DF_DimShipLocation_City]  DEFAULT (N'Unknown') FOR [ShipCity]
GO

ALTER TABLE [dbo].[DimShipLocation] ADD  CONSTRAINT [DF_DimShipLocation_Region]  DEFAULT (N'Unknown') FOR [ShipRegion]
GO

ALTER TABLE [dbo].[DimShipLocation] ADD  CONSTRAINT [DF_DimShipLocation_Country]  DEFAULT (N'Unknown') FOR [ShipCountry]
GO

ALTER TABLE [dbo].[DimShipLocation] ADD  CONSTRAINT [DF_DimShipLocation_Postal]  DEFAULT (N'Unknown') FOR [ShipPostalCode]
GO

ALTER TABLE [dbo].[DimShipLocation] ADD  CONSTRAINT [DF_DimShipLocation_LoadDate]  DEFAULT (getdate()) FOR [LoadDate]
GO
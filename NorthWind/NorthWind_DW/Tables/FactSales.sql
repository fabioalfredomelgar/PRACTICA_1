
CREATE TABLE [dbo].[FactSales](
	[SalesKey] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[RequiredDateKey] [int] NOT NULL,
	[ShippedDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ProductKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[ShipperKey] [int] NOT NULL,
	[ShipLocationKey] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [decimal](5, 4) NOT NULL,
	[AllocatedFreight] [decimal](18, 2) NOT NULL,
	[GrossAmount]  AS (CONVERT([decimal](18,2),[UnitPrice]*[Quantity])) PERSISTED,
	[DiscountAmount]  AS (CONVERT([decimal](18,2),([UnitPrice]*[Quantity])*[Discount])) PERSISTED,
	[NetSales]  AS (CONVERT([decimal](18,2),([UnitPrice]*[Quantity])*((1)-[Discount]))) PERSISTED,
	[DaysToShip] [int] NULL,
	[DaysLate] [int] NULL,
	[LoadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_FactSales] PRIMARY KEY CLUSTERED 
(
	[SalesKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_FactSales_Line] UNIQUE NONCLUSTERED 
(
	[OrderID] ASC,
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactSales] ADD  CONSTRAINT [DF_FactSales_Discount]  DEFAULT ((0)) FOR [Discount]
GO

ALTER TABLE [dbo].[FactSales] ADD  CONSTRAINT [DF_FactSales_AllocatedFreight]  DEFAULT ((0)) FOR [AllocatedFreight]
GO

ALTER TABLE [dbo].[FactSales] ADD  CONSTRAINT [DF_FactSales_LoadDate]  DEFAULT (getdate()) FOR [LoadDate]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_Customer] FOREIGN KEY([CustomerKey])
REFERENCES [dbo].[DimCustomer] ([CustomerKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_Customer]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_Employee] FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[DimEmployee] ([EmployeeKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_Employee]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_OrderDate] FOREIGN KEY([OrderDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_OrderDate]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_Product] FOREIGN KEY([ProductKey])
REFERENCES [dbo].[DimProduct] ([ProductKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_Product]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_RequiredDate] FOREIGN KEY([RequiredDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_RequiredDate]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_ShipLocation] FOREIGN KEY([ShipLocationKey])
REFERENCES [dbo].[DimShipLocation] ([ShipLocationKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_ShipLocation]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_ShippedDate] FOREIGN KEY([ShippedDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_ShippedDate]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_Shipper] FOREIGN KEY([ShipperKey])
REFERENCES [dbo].[DimShipper] ([ShipperKey])
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_Shipper]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [CK_FactSales_Discount] CHECK  (([Discount]>=(0) AND [Discount]<=(1)))
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [CK_FactSales_Discount]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [CK_FactSales_Freight] CHECK  (([AllocatedFreight]>=(0)))
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [CK_FactSales_Freight]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [CK_FactSales_Price] CHECK  (([UnitPrice]>=(0)))
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [CK_FactSales_Price]
GO

ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [CK_FactSales_Quantity] CHECK  (([Quantity]>(0)))
GO

ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [CK_FactSales_Quantity]
GO



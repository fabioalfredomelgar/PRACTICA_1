CREATE TABLE [staging].[Sales](
    [SalesKey] [bigint] NOT NULL,
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
    [GrossAmount] [decimal](18, 2) NULL,
    [DiscountAmount] [decimal](18, 2) NULL,
    [NetSales] [decimal](18, 2) NULL,
    [DaysToShip] [int] NULL,
    [DaysLate] [int] NULL,
    [LoadDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [staging].[Sales] ADD CONSTRAINT [DF_staging_Sales_Discount] DEFAULT ((0)) FOR [Discount]
GO

ALTER TABLE [staging].[Sales] ADD CONSTRAINT [DF_staging_Sales_AllocatedFreight] DEFAULT ((0)) FOR [AllocatedFreight]
GO

ALTER TABLE [staging].[Sales] ADD CONSTRAINT [DF_staging_Sales_LoadDate] DEFAULT (getdate()) FOR [LoadDate]
GO
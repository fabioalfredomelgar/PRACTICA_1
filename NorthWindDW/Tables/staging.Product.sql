CREATE TABLE [staging].[DimProduct](
    [ProductKey] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductName] [nvarchar](40) NOT NULL,
    [QuantityPerUnit] [nvarchar](20) NULL,
    [CurrentListPrice] [decimal](18, 2) NULL,
    [Discontinued] [bit] NOT NULL,
    [CategoryID] [int] NULL,
    [CategoryName] [nvarchar](15) NULL,
    [CategoryDescription] [nvarchar](max) NULL,
    [SupplierID] [int] NULL,
    [SupplierCompanyName] [nvarchar](40) NULL,
    [SupplierContactName] [nvarchar](30) NULL,
    [SupplierCity] [nvarchar](15) NULL,
    [SupplierCountry] [nvarchar](15) NULL,
    [LoadDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [staging].[DimProduct] ADD CONSTRAINT [DF_staging_DimProduct_Discontinued] DEFAULT ((0)) FOR [Discontinued]
GO

ALTER TABLE [staging].[DimProduct] ADD CONSTRAINT [DF_staging_DimProduct_LoadDate] DEFAULT (getdate()) FOR [LoadDate]
GO
CREATE TABLE [dbo].[DimProduct](
    [ProductKey] [int] IDENTITY(1,1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [ProductName] [nvarchar](40) NOT NULL,
    [QuantityPerUnit] [nvarchar](20) NULL,
    [CurrentListPrice] [decimal](18, 2) NULL,
    [Discontinued] [bit] NOT NULL CONSTRAINT [DF_DimProduct_Discontinued] DEFAULT ((0)),
    [CategoryID] [int] NULL,
    [CategoryName] [nvarchar](15) NULL,
    [CategoryDescription] [nvarchar](max) NULL,
    [SupplierID] [int] NULL,
    [SupplierCompanyName] [nvarchar](40) NULL,
    [SupplierContactName] [nvarchar](30) NULL,
    [SupplierCity] [nvarchar](15) NULL,
    [SupplierCountry] [nvarchar](15) NULL,
    [LoadDate] [datetime] NOT NULL CONSTRAINT [DF_DimProduct_LoadDate] DEFAULT (getdate()),
    CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED ([ProductKey] ASC),
    CONSTRAINT [UQ_DimProduct_ProductID] UNIQUE NONCLUSTERED ([ProductID] ASC)
);
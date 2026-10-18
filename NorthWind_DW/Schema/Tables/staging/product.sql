CREATE TABLE [staging].[product](
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
    CONSTRAINT [PK_staging_product] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);
CREATE SCHEMA staging;
GO

CREATE TABLE [staging].[DimCustomer](
    [CustomerKey] [int] NOT NULL,
    [CustomerID] [nchar](5) NOT NULL,
    [CompanyName] [nvarchar](40) NOT NULL,
    [ContactName] [nvarchar](30) NULL,
    [ContactTitle] [nvarchar](30) NULL,
    [Address] [nvarchar](60) NULL,
    [City] [nvarchar](15) NULL,
    [Region] [nvarchar](15) NULL,
    [PostalCode] [nvarchar](10) NULL,
    [Country] [nvarchar](15) NULL,
    [Phone] [nvarchar](24) NULL,
    [Fax] [nvarchar](24) NULL,
    [LoadDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [staging].[DimCustomer] ADD CONSTRAINT [DF_staging_DimCustomer_LoadDate] DEFAULT (getdate()) FOR [LoadDate]
GO
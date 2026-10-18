CREATE TABLE [dbo].[Suppliers](
    [SupplierID] [int] IDENTITY(1,1) NOT NULL,
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
    [HomePage] [nvarchar](max) NULL,
    [rowversion] [timestamp] NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY ([SupplierID] ASC)
);
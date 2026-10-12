CREATE TABLE [dbo].[DimCustomer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL
   ,[CustomerID] [nchar](5)           NOT NULL
   ,[CompanyName] [nvarchar](40)      NOT NULL
   ,[ContactName] [nvarchar](30)      NULL
   ,[ContactTitle] [nvarchar](30)     NULL
   ,[Address] [nvarchar](60)          NULL
   ,[City] [nvarchar](15)             NULL
   ,[Region] [nvarchar](15)           NULL
   ,[PostalCode] [nvarchar](10)       NULL
   ,[Country] [nvarchar](15)          NULL
   ,[Phone] [nvarchar](24)            NULL
   ,[Fax] [nvarchar](24)              NULL
   ,[LoadDate] [datetime]             NOT NULL
 CONSTRAINT [PK_DimCustomer] PRIMARY KEY       ([CustomerKey] ASC),
 CONSTRAINT [UQ_DimCustomer_CustomerID] UNIQUE ([CustomerID] ASC)                                     
);

CREATE TABLE [dbo].[CustomerCustomerDemo](
    [CustomerID] [nchar](5) NOT NULL,
    [CustomerTypeID] [nchar](10) NOT NULL,
    [rowversion] [timestamp] NULL,
    CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY NONCLUSTERED
    (
        [CustomerID] ASC,
        [CustomerTypeID] ASC
    ),
    CONSTRAINT [FK_CustomerCustomerDemo]
        FOREIGN KEY ([CustomerTypeID])
        REFERENCES [dbo].[CustomerDemographics] ([CustomerTypeID]),
    CONSTRAINT [FK_CustomerCustomerDemo_Customers]
        FOREIGN KEY ([CustomerID])
        REFERENCES [dbo].[Customers] ([CustomerID])
)


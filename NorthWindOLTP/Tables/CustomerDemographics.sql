CREATE TABLE [dbo].[CustomerDemographics](
    [CustomerTypeID] [nchar](10) NOT NULL,
    [CustomerDesc] [nvarchar](max) NULL,
    [rowversion] [timestamp] NULL,
    CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY NONCLUSTERED ([CustomerTypeID] ASC)
);
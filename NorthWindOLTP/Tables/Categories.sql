CREATE TABLE [dbo].[Categories](
    [CategoryID] [int] IDENTITY(1,1) NOT NULL,
    [CategoryName] [nvarchar](15) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [Picture] [image] NULL,
    [rowversion] [timestamp] NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
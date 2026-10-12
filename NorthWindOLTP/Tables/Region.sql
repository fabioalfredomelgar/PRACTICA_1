CREATE TABLE [dbo].[Region](
    [RegionID] [int] NOT NULL,
    [RegionDescription] [nchar](50) NOT NULL,
    [rowversion] [timestamp] NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED ([RegionID] ASC)
);
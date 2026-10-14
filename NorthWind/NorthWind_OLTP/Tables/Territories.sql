CREATE TABLE [dbo].[Territories](
    [TerritoryID] [nvarchar](20) NOT NULL,
    [TerritoryDescription] [nchar](50) NOT NULL,
    [RegionID] [int] NOT NULL,
    [rowversion] [timestamp] NULL,
    CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED ([TerritoryID] ASC),
    CONSTRAINT [FK_Territories_Region] FOREIGN KEY ([RegionID]) REFERENCES [dbo].[Region] ([RegionID])
);
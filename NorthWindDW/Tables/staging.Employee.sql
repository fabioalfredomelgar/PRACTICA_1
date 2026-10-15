CREATE TABLE [staging].[DimEmployee](
    [EmployeeKey] [int] NOT NULL,
    [EmployeeID] [int] NOT NULL,
    [LastName] [nvarchar](20) NOT NULL,
    [FirstName] [nvarchar](10) NOT NULL,
    [FullName] [nvarchar](31) NOT NULL,
    [Title] [nvarchar](30) NULL,
    [TitleOfCourtesy] [nvarchar](25) NULL,
    [BirthDate] [date] NULL,
    [HireDate] [date] NULL,
    [City] [nvarchar](15) NULL,
    [Region] [nvarchar](15) NULL,
    [Country] [nvarchar](15) NULL,
    [ReportsTo] [int] NULL,
    [SupervisorName] [nvarchar](31) NULL,
    [LoadDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [staging].[DimEmployee] ADD CONSTRAINT [DF_staging_DimEmployee_LoadDate] DEFAULT (getdate()) FOR [LoadDate]
GO
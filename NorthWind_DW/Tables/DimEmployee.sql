CREATE TABLE [dbo].[DimEmployee](
    [EmployeeKey] [int] IDENTITY(1,1) NOT NULL,
    [EmployeeID] [int] NOT NULL,
    [LastName] [nvarchar](20) NOT NULL,
    [FirstName] [nvarchar](20) NOT NULL,
    [FullName] [nvarchar](41) NOT NULL,
    [Title] [nvarchar](30) NULL,
    [TitleOfCourtesy] [nvarchar](25) NULL,
    [BirthDate] [date] NULL,
    [HireDate] [date] NULL,
    [City] [nvarchar](15) NULL,
    [Region] [nvarchar](15) NULL,
    [Country] [nvarchar](15) NULL,
    [ReportsTo] [int] NULL,
    [SupervisorName] [nvarchar](41) NULL,
    [LoadDate] [datetime] NOT NULL CONSTRAINT [DF_DimEmployee_LoadDate] DEFAULT (getdate()),
    CONSTRAINT [PK_DimEmployee] PRIMARY KEY CLUSTERED ([EmployeeKey] ASC),
    CONSTRAINT [UQ_DimEmployee_EmployeeID] UNIQUE NONCLUSTERED ([EmployeeID] ASC)
);
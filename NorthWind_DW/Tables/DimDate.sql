CREATE TABLE [dbo].[DimDate](
    [DateKey] [int] NOT NULL,
    [FullDate] [date] NOT NULL,
    [Year] [smallint] NOT NULL,
    [Semester] [tinyint] NOT NULL,
    [Quarter] [tinyint] NOT NULL,
    [QuarterName] [nvarchar](10) NOT NULL,
    [Month] [tinyint] NOT NULL,
    [MonthName] [nvarchar](15) NOT NULL,
    [YearMonth] [int] NOT NULL,
    [WeekOfYear] [tinyint] NOT NULL,
    [DayOfMonth] [tinyint] NOT NULL,
    [DayOfWeek] [tinyint] NOT NULL,
    [DayName] [nvarchar](15) NOT NULL,
    [IsWeekend] [bit] NOT NULL CONSTRAINT [DF_DimDate_IsWeekend] DEFAULT ((0)),
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC),
    CONSTRAINT [UQ_DimDate_FullDate] UNIQUE NONCLUSTERED ([FullDate] ASC)
);
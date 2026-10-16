/*
Script de implementación para NorthWindDW

Este código lo generó una herramienta.
Los cambios en este archivo pueden provocar un comportamiento incorrecto y se perderán si
el código se vuelve a generar.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "NorthWindDW"
:setvar DefaultFilePrefix "NorthWindDW"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detecte el modo SQLCMD y deshabilite la ejecución de scripts si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
ESTABLECER NOEXEC DESACTIVADO; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creando Esquema [staging]...';


GO
CREATE SCHEMA [staging]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Tabla [staging].[Sales]...';


GO
CREATE TABLE [staging].[Sales] (
    [SalesKey]         BIGINT          NOT NULL,
    [OrderDateKey]     INT             NOT NULL,
    [RequiredDateKey]  INT             NOT NULL,
    [ShippedDateKey]   INT             NOT NULL,
    [CustomerKey]      INT             NOT NULL,
    [ProductKey]       INT             NOT NULL,
    [EmployeeKey]      INT             NOT NULL,
    [ShipperKey]       INT             NOT NULL,
    [ShipLocationKey]  INT             NOT NULL,
    [OrderID]          INT             NOT NULL,
    [UnitPrice]        DECIMAL (18, 2) NOT NULL,
    [Quantity]         SMALLINT        NOT NULL,
    [Discount]         DECIMAL (5, 4)  NOT NULL,
    [AllocatedFreight] DECIMAL (18, 2) NOT NULL,
    [GrossAmount]      DECIMAL (18, 2) NULL,
    [DiscountAmount]   DECIMAL (18, 2) NULL,
    [NetSales]         DECIMAL (18, 2) NULL,
    [DaysToShip]       INT             NULL,
    [DaysLate]         INT             NULL,
    [LoadDate]         DATETIME        NOT NULL
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[DimShipper]...';


GO
CREATE TABLE [staging].[DimShipper] (
    [ShipperKey]  INT           NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    [LoadDate]    DATETIME      NOT NULL
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[DimShipLocation]...';


GO
CREATE TABLE [staging].[DimShipLocation] (
    [ShipLocationKey] INT           NOT NULL,
    [ShipCity]        NVARCHAR (15) NOT NULL,
    [ShipRegion]      NVARCHAR (15) NOT NULL,
    [ShipCountry]     NVARCHAR (15) NOT NULL,
    [ShipPostalCode]  NVARCHAR (10) NOT NULL,
    [LoadDate]        DATETIME      NOT NULL
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[DimProduct]...';


GO
CREATE TABLE [staging].[DimProduct] (
    [ProductKey]          INT             NOT NULL,
    [ProductID]           INT             NOT NULL,
    [ProductName]         NVARCHAR (40)   NOT NULL,
    [QuantityPerUnit]     NVARCHAR (20)   NULL,
    [CurrentListPrice]    DECIMAL (18, 2) NULL,
    [Discontinued]        BIT             NOT NULL,
    [CategoryID]          INT             NULL,
    [CategoryName]        NVARCHAR (15)   NULL,
    [CategoryDescription] NVARCHAR (MAX)  NULL,
    [SupplierID]          INT             NULL,
    [SupplierCompanyName] NVARCHAR (40)   NULL,
    [SupplierContactName] NVARCHAR (30)   NULL,
    [SupplierCity]        NVARCHAR (15)   NULL,
    [SupplierCountry]     NVARCHAR (15)   NULL,
    [LoadDate]            DATETIME        NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[DimEmployee]...';


GO
CREATE TABLE [staging].[DimEmployee] (
    [EmployeeKey]     INT           NOT NULL,
    [EmployeeID]      INT           NOT NULL,
    [LastName]        NVARCHAR (20) NOT NULL,
    [FirstName]       NVARCHAR (10) NOT NULL,
    [FullName]        NVARCHAR (31) NOT NULL,
    [Title]           NVARCHAR (30) NULL,
    [TitleOfCourtesy] NVARCHAR (25) NULL,
    [BirthDate]       DATE          NULL,
    [HireDate]        DATE          NULL,
    [City]            NVARCHAR (15) NULL,
    [Region]          NVARCHAR (15) NULL,
    [Country]         NVARCHAR (15) NULL,
    [ReportsTo]       INT           NULL,
    [SupervisorName]  NVARCHAR (31) NULL,
    [LoadDate]        DATETIME      NOT NULL
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[DimCustomer]...';


GO
CREATE TABLE [staging].[DimCustomer] (
    [CustomerKey]  INT           NOT NULL,
    [CustomerID]   NCHAR (5)     NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [Address]      NVARCHAR (60) NULL,
    [City]         NVARCHAR (15) NULL,
    [Region]       NVARCHAR (15) NULL,
    [PostalCode]   NVARCHAR (10) NULL,
    [Country]      NVARCHAR (15) NULL,
    [Phone]        NVARCHAR (24) NULL,
    [Fax]          NVARCHAR (24) NULL,
    [LoadDate]     DATETIME      NOT NULL
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimCustomer]...';


GO
CREATE TABLE [dbo].[DimCustomer] (
    [CustomerKey]  INT           IDENTITY (1, 1) NOT NULL,
    [CustomerID]   NCHAR (5)     NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [Address]      NVARCHAR (60) NULL,
    [City]         NVARCHAR (15) NULL,
    [Region]       NVARCHAR (15) NULL,
    [PostalCode]   NVARCHAR (10) NULL,
    [Country]      NVARCHAR (15) NULL,
    [Phone]        NVARCHAR (24) NULL,
    [Fax]          NVARCHAR (24) NULL,
    [LoadDate]     DATETIME      NOT NULL,
    CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED ([CustomerKey] ASC) ON [PRIMARY],
    CONSTRAINT [UQ_DimCustomer_CustomerID] UNIQUE NONCLUSTERED ([CustomerID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimDate]...';


GO
CREATE TABLE [dbo].[DimDate] (
    [DateKey]     INT           NOT NULL,
    [FullDate]    DATE          NOT NULL,
    [Year]        SMALLINT      NOT NULL,
    [Semester]    TINYINT       NOT NULL,
    [Quarter]     TINYINT       NOT NULL,
    [QuarterName] NVARCHAR (10) NOT NULL,
    [Month]       TINYINT       NOT NULL,
    [MonthName]   NVARCHAR (15) NOT NULL,
    [YearMonth]   INT           NOT NULL,
    [WeekOfYear]  TINYINT       NOT NULL,
    [DayOfMonth]  TINYINT       NOT NULL,
    [DayOfWeek]   TINYINT       NOT NULL,
    [DayName]     NVARCHAR (15) NOT NULL,
    [IsWeekend]   BIT           NOT NULL,
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC) ON [PRIMARY],
    CONSTRAINT [UQ_DimDate_FullDate] UNIQUE NONCLUSTERED ([FullDate] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimEmployee]...';


GO
CREATE TABLE [dbo].[DimEmployee] (
    [EmployeeKey]     INT           IDENTITY (1, 1) NOT NULL,
    [EmployeeID]      INT           NOT NULL,
    [LastName]        NVARCHAR (20) NOT NULL,
    [FirstName]       NVARCHAR (20) NOT NULL,
    [FullName]        NVARCHAR (41) NOT NULL,
    [Title]           NVARCHAR (30) NULL,
    [TitleOfCourtesy] NVARCHAR (25) NULL,
    [BirthDate]       DATE          NULL,
    [HireDate]        DATE          NULL,
    [City]            NVARCHAR (15) NULL,
    [Region]          NVARCHAR (15) NULL,
    [Country]         NVARCHAR (15) NULL,
    [ReportsTo]       INT           NULL,
    [SupervisorName]  NVARCHAR (41) NULL,
    [LoadDate]        DATETIME      NOT NULL,
    CONSTRAINT [PK_DimEmployee] PRIMARY KEY CLUSTERED ([EmployeeKey] ASC) ON [PRIMARY],
    CONSTRAINT [UQ_DimEmployee_EmployeeID] UNIQUE NONCLUSTERED ([EmployeeID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimFactSales]...';


GO
CREATE TABLE [dbo].[DimFactSales] (
    [Id] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimProduct]...';


GO
CREATE TABLE [dbo].[DimProduct] (
    [ProductKey]          INT             IDENTITY (1, 1) NOT NULL,
    [ProductID]           INT             NOT NULL,
    [ProductName]         NVARCHAR (40)   NOT NULL,
    [QuantityPerUnit]     NVARCHAR (20)   NULL,
    [CurrentListPrice]    DECIMAL (18, 2) NULL,
    [Discontinued]        BIT             NOT NULL,
    [CategoryID]          INT             NULL,
    [CategoryName]        NVARCHAR (15)   NULL,
    [CategoryDescription] NVARCHAR (MAX)  NULL,
    [SupplierID]          INT             NULL,
    [SupplierCompanyName] NVARCHAR (40)   NULL,
    [SupplierContactName] NVARCHAR (30)   NULL,
    [SupplierCity]        NVARCHAR (15)   NULL,
    [SupplierCountry]     NVARCHAR (15)   NULL,
    [LoadDate]            DATETIME        NOT NULL,
    CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED ([ProductKey] ASC) ON [PRIMARY],
    CONSTRAINT [UQ_DimProduct_ProductID] UNIQUE NONCLUSTERED ([ProductID] ASC) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimShipLocation]...';


GO
CREATE TABLE [dbo].[DimShipLocation] (
    [ShipLocationKey] INT           IDENTITY (1, 1) NOT NULL,
    [ShipCity]        NVARCHAR (15) NOT NULL,
    [ShipRegion]      NVARCHAR (15) NOT NULL,
    [ShipCountry]     NVARCHAR (15) NOT NULL,
    [ShipPostalCode]  NVARCHAR (10) NOT NULL,
    [LoadDate]        DATETIME      NOT NULL,
    CONSTRAINT [PK_DimShipLocation] PRIMARY KEY CLUSTERED ([ShipLocationKey] ASC) ON [PRIMARY],
    CONSTRAINT [UQ_DimShipLocation] UNIQUE NONCLUSTERED ([ShipCity] ASC, [ShipRegion] ASC, [ShipCountry] ASC, [ShipPostalCode] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimShipper]...';


GO
CREATE TABLE [dbo].[DimShipper] (
    [ShipperKey]  INT           IDENTITY (1, 1) NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    [LoadDate]    DATETIME      NOT NULL,
    CONSTRAINT [PK_DimShipper] PRIMARY KEY CLUSTERED ([ShipperKey] ASC) ON [PRIMARY],
    CONSTRAINT [UQ_DimShipper_ShipperID] UNIQUE NONCLUSTERED ([ShipperID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[FactSales]...';


GO
CREATE TABLE [dbo].[FactSales] (
    [SalesKey]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [OrderDateKey]     INT             NOT NULL,
    [RequiredDateKey]  INT             NOT NULL,
    [ShippedDateKey]   INT             NOT NULL,
    [CustomerKey]      INT             NOT NULL,
    [ProductKey]       INT             NOT NULL,
    [EmployeeKey]      INT             NOT NULL,
    [ShipperKey]       INT             NOT NULL,
    [ShipLocationKey]  INT             NOT NULL,
    [OrderID]          INT             NOT NULL,
    [UnitPrice]        DECIMAL (18, 2) NOT NULL,
    [Quantity]         SMALLINT        NOT NULL,
    [Discount]         DECIMAL (5, 4)  NOT NULL,
    [AllocatedFreight] DECIMAL (18, 2) NOT NULL,
    [GrossAmount]      AS              (CONVERT (DECIMAL (18, 2), [UnitPrice] * [Quantity])) PERSISTED,
    [DiscountAmount]   AS              (CONVERT (DECIMAL (18, 2), ([UnitPrice] * [Quantity]) * [Discount])) PERSISTED,
    [NetSales]         AS              (CONVERT (DECIMAL (18, 2), ([UnitPrice] * [Quantity]) * ((1) - [Discount]))) PERSISTED,
    [DaysToShip]       INT             NULL,
    [DaysLate]         INT             NULL,
    [LoadDate]         DATETIME        NOT NULL,
    CONSTRAINT [PK_FactSales] PRIMARY KEY CLUSTERED ([SalesKey] ASC) ON [PRIMARY],
    CONSTRAINT [UQ_FactSales_Line] UNIQUE NONCLUSTERED ([OrderID] ASC, [ProductKey] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [PackageID]      INT          IDENTITY (1, 1) NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL,
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([PackageID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_Sales_Discount]...';


GO
ALTER TABLE [staging].[Sales]
    ADD CONSTRAINT [DF_staging_Sales_Discount] DEFAULT ((0)) FOR [Discount];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_Sales_AllocatedFreight]...';


GO
ALTER TABLE [staging].[Sales]
    ADD CONSTRAINT [DF_staging_Sales_AllocatedFreight] DEFAULT ((0)) FOR [AllocatedFreight];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_Sales_LoadDate]...';


GO
ALTER TABLE [staging].[Sales]
    ADD CONSTRAINT [DF_staging_Sales_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimShipper_LoadDate]...';


GO
ALTER TABLE [staging].[DimShipper]
    ADD CONSTRAINT [DF_staging_DimShipper_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimShipLocation_City]...';


GO
ALTER TABLE [staging].[DimShipLocation]
    ADD CONSTRAINT [DF_staging_DimShipLocation_City] DEFAULT (N'Unknown') FOR [ShipCity];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimShipLocation_Region]...';


GO
ALTER TABLE [staging].[DimShipLocation]
    ADD CONSTRAINT [DF_staging_DimShipLocation_Region] DEFAULT (N'Unknown') FOR [ShipRegion];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimShipLocation_Country]...';


GO
ALTER TABLE [staging].[DimShipLocation]
    ADD CONSTRAINT [DF_staging_DimShipLocation_Country] DEFAULT (N'Unknown') FOR [ShipCountry];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimShipLocation_Postal]...';


GO
ALTER TABLE [staging].[DimShipLocation]
    ADD CONSTRAINT [DF_staging_DimShipLocation_Postal] DEFAULT (N'Unknown') FOR [ShipPostalCode];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimShipLocation_LoadDate]...';


GO
ALTER TABLE [staging].[DimShipLocation]
    ADD CONSTRAINT [DF_staging_DimShipLocation_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimProduct_Discontinued]...';


GO
ALTER TABLE [staging].[DimProduct]
    ADD CONSTRAINT [DF_staging_DimProduct_Discontinued] DEFAULT ((0)) FOR [Discontinued];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimProduct_LoadDate]...';


GO
ALTER TABLE [staging].[DimProduct]
    ADD CONSTRAINT [DF_staging_DimProduct_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimEmployee_LoadDate]...';


GO
ALTER TABLE [staging].[DimEmployee]
    ADD CONSTRAINT [DF_staging_DimEmployee_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [staging].[DF_staging_DimCustomer_LoadDate]...';


GO
ALTER TABLE [staging].[DimCustomer]
    ADD CONSTRAINT [DF_staging_DimCustomer_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimCustomer_LoadDate]...';


GO
ALTER TABLE [dbo].[DimCustomer]
    ADD CONSTRAINT [DF_DimCustomer_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimDate_IsWeekend]...';


GO
ALTER TABLE [dbo].[DimDate]
    ADD CONSTRAINT [DF_DimDate_IsWeekend] DEFAULT ((0)) FOR [IsWeekend];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimEmployee_LoadDate]...';


GO
ALTER TABLE [dbo].[DimEmployee]
    ADD CONSTRAINT [DF_DimEmployee_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimProduct_Discontinued]...';


GO
ALTER TABLE [dbo].[DimProduct]
    ADD CONSTRAINT [DF_DimProduct_Discontinued] DEFAULT ((0)) FOR [Discontinued];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimProduct_LoadDate]...';


GO
ALTER TABLE [dbo].[DimProduct]
    ADD CONSTRAINT [DF_DimProduct_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimShipLocation_City]...';


GO
ALTER TABLE [dbo].[DimShipLocation]
    ADD CONSTRAINT [DF_DimShipLocation_City] DEFAULT (N'Unknown') FOR [ShipCity];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimShipLocation_Region]...';


GO
ALTER TABLE [dbo].[DimShipLocation]
    ADD CONSTRAINT [DF_DimShipLocation_Region] DEFAULT (N'Unknown') FOR [ShipRegion];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimShipLocation_Country]...';


GO
ALTER TABLE [dbo].[DimShipLocation]
    ADD CONSTRAINT [DF_DimShipLocation_Country] DEFAULT (N'Unknown') FOR [ShipCountry];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimShipLocation_Postal]...';


GO
ALTER TABLE [dbo].[DimShipLocation]
    ADD CONSTRAINT [DF_DimShipLocation_Postal] DEFAULT (N'Unknown') FOR [ShipPostalCode];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimShipLocation_LoadDate]...';


GO
ALTER TABLE [dbo].[DimShipLocation]
    ADD CONSTRAINT [DF_DimShipLocation_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_DimShipper_LoadDate]...';


GO
ALTER TABLE [dbo].[DimShipper]
    ADD CONSTRAINT [DF_DimShipper_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_FactSales_Discount]...';


GO
ALTER TABLE [dbo].[FactSales]
    ADD CONSTRAINT [DF_FactSales_Discount] DEFAULT ((0)) FOR [Discount];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_FactSales_AllocatedFreight]...';


GO
ALTER TABLE [dbo].[FactSales]
    ADD CONSTRAINT [DF_FactSales_AllocatedFreight] DEFAULT ((0)) FOR [AllocatedFreight];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_FactSales_LoadDate]...';


GO
ALTER TABLE [dbo].[FactSales]
    ADD CONSTRAINT [DF_FactSales_LoadDate] DEFAULT (getdate()) FOR [LoadDate];


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_Customer]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_Customer] FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer] ([CustomerKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_Employee]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_Employee] FOREIGN KEY ([EmployeeKey]) REFERENCES [dbo].[DimEmployee] ([EmployeeKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_OrderDate]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_OrderDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_Product]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_Product] FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct] ([ProductKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_RequiredDate]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_RequiredDate] FOREIGN KEY ([RequiredDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_ShipLocation]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_ShipLocation] FOREIGN KEY ([ShipLocationKey]) REFERENCES [dbo].[DimShipLocation] ([ShipLocationKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_ShippedDate]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_ShippedDate] FOREIGN KEY ([ShippedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactSales_Shipper]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [FK_FactSales_Shipper] FOREIGN KEY ([ShipperKey]) REFERENCES [dbo].[DimShipper] ([ShipperKey]);


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_FactSales_Discount]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [CK_FactSales_Discount] CHECK (([Discount]>=(0) AND [Discount]<=(1)));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_FactSales_Freight]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [CK_FactSales_Freight] CHECK (([AllocatedFreight]>=(0)));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_FactSales_Price]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [CK_FactSales_Price] CHECK (([UnitPrice]>=(0)));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_FactSales_Quantity]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [CK_FactSales_Quantity] CHECK (([Quantity]>(0)));


GO
PRINT N'Creando Procedimiento [dbo].[DW_MergedDimCustomer]...';


GO
CREATE PROCEDURE [dbo].[DW_MergedDimCustomer]
AS
BEGIN
    UPDATE dc
    SET [CustomerID]   = sc.[CustomerID]
        ,[CompanyName] = sc.[CompanyName]
        ,[ContactName] = sc.[ContactName]
        ,[ContactTitle]= sc.[ContactTitle]
        ,[Address]     = sc.[Address]
        ,[City]        = sc.[City]
        ,[Region]      = sc.[Region]
        ,[PostalCode]  = sc.[PostalCode]
        ,[Country]     = sc.[Country]
        ,[Phone]       = sc.[Phone]
        ,[Fax]         = sc.[Fax]
    FROM [dbo].[DimCustomer] dc
    INNER JOIN [staging].[customer] sc ON (dc.[CustomerKey] = sc.[CustomerKey])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergedDimEmployee]...';


GO
CREATE PROCEDURE [dbo].[DW_MergedDimEmployee]
AS
BEGIN
    UPDATE de
    SET [EmployeeID]       = se.[EmployeeID]
        ,[LastName]        = se.[LastName]
        ,[FirstName]       = se.[FirstName]
        ,[FullName]        = se.[FullName]
        ,[Title]           = se.[Title]
        ,[TitleOfCourtesy] = se.[TitleOfCourtesy]
        ,[BirthDate]       = se.[BirthDate]
        ,[HireDate]        = se.[HireDate]
        ,[City]            = se.[City]
        ,[Region]          = se.[Region]
        ,[Country]         = se.[Country]
        ,[ReportsTo]       = se.[ReportsTo]
        ,[SupervisorName]  = se.[SupervisorName]
    FROM [dbo].[DimEmployee] de
    INNER JOIN [staging].[employee] se ON (de.[EmployeeKey] = se.[EmployeeKey])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergedDimProduct]...';


GO
CREATE PROCEDURE [dbo].[DW_MergedDimProduct]
AS
BEGIN
    UPDATE dp
    SET [ProductID]           = sp.[ProductID]
        ,[ProductName]        = sp.[ProductName]
        ,[QuantityPerUnit]    = sp.[QuantityPerUnit]
        ,[CurrentListPrice]   = sp.[CurrentListPrice]
        ,[Discontinued]       = sp.[Discontinued]
        ,[CategoryID]         = sp.[CategoryID]
        ,[CategoryName]       = sp.[CategoryName]
        ,[CategoryDescription]= sp.[CategoryDescription]
        ,[SupplierID]         = sp.[SupplierID]
        ,[SupplierCompanyName]= sp.[SupplierCompanyName]
        ,[SupplierContactName]= sp.[SupplierContactName]
        ,[SupplierCity]       = sp.[SupplierCity]
        ,[SupplierCountry]    = sp.[SupplierCountry]
    FROM [dbo].[DimProduct] dp
    INNER JOIN [staging].[product] sp ON (dp.[ProductKey] = sp.[ProductKey])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergedDimShipLocation]...';


GO
CREATE PROCEDURE [dbo].[DW_MergedDimShipLocation]
AS
BEGIN
    UPDATE dsl
    SET [ShipCity]       = ssl.[ShipCity]
        ,[ShipRegion]    = ssl.[ShipRegion]
        ,[ShipCountry]   = ssl.[ShipCountry]
        ,[ShipPostalCode]= ssl.[ShipPostalCode]
    FROM [dbo].[DimShipLocation] dsl
    INNER JOIN [staging].[shiplocation] ssl ON (dsl.[ShipLocationKey] = ssl.[ShipLocationKey])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergedDimShipper]...';


GO
CREATE PROCEDURE [dbo].[DW_MergedDimShipper]
AS
BEGIN
    UPDATE ds
    SET [ShipperID]    = ss.[ShipperID]
        ,[CompanyName] = ss.[CompanyName]
        ,[Phone]       = ss.[Phone]
    FROM [dbo].[DimShipper] ds
    INNER JOIN [staging].[shipper] ss ON (ds.[ShipperKey] = ss.[ShipperKey])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergedSales]...';


GO
CREATE PROCEDURE [dbo].[DW_MergedSales]
AS
BEGIN
    UPDATE fs
    SET [OrderDateKey]     = sfs.[OrderDateKey]
        ,[RequiredDateKey] = sfs.[RequiredDateKey]
        ,[ShippedDateKey]  = sfs.[ShippedDateKey]
        ,[CustomerKey]     = sfs.[CustomerKey]
        ,[ProductKey]      = sfs.[ProductKey]
        ,[EmployeeKey]     = sfs.[EmployeeKey]
        ,[ShipperKey]      = sfs.[ShipperKey]
        ,[ShipLocationKey] = sfs.[ShipLocationKey]
        ,[UnitPrice]       = sfs.[UnitPrice]
        ,[Quantity]        = sfs.[Quantity]
        ,[Discount]        = sfs.[Discount]
        ,[AllocatedFreight]= sfs.[AllocatedFreight]
        ,[DaysToShip]      = sfs.[DaysToShip]
        ,[DaysLate]        = sfs.[DaysLate]
    FROM [dbo].[Sales] fs
    INNER JOIN [staging].[sales] sfs ON (fs.[OrderID] = sfs.[OrderID] AND fs.[ProductKey] = sfs.[ProductKey])
END
GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_Customer];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_Employee];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_OrderDate];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_Product];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_RequiredDate];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_ShipLocation];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_ShippedDate];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [FK_FactSales_Shipper];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [CK_FactSales_Discount];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [CK_FactSales_Freight];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [CK_FactSales_Price];

ALTER TABLE [dbo].[FactSales] WITH CHECK CHECK CONSTRAINT [CK_FactSales_Quantity];


GO
PRINT N'Actualización completada.';


GO

/*
Script de implementación para NorthWindOLTP

Este código lo generó una herramienta.
Los cambios en este archivo pueden provocar un comportamiento incorrecto y se perderán si
el código se vuelve a generar.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "NorthWindOLTP"
:setvar DefaultFilePrefix "NorthWindOLTP"
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
    CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED ([CustomerKey] ASC),
    CONSTRAINT [UQ_DimCustomer_CustomerID] UNIQUE NONCLUSTERED ([CustomerID] ASC)
);


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
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC),
    CONSTRAINT [UQ_DimDate_FullDate] UNIQUE NONCLUSTERED ([FullDate] ASC)
);


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
    CONSTRAINT [PK_DimEmployee] PRIMARY KEY CLUSTERED ([EmployeeKey] ASC),
    CONSTRAINT [UQ_DimEmployee_EmployeeID] UNIQUE NONCLUSTERED ([EmployeeID] ASC)
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
    CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED ([ProductKey] ASC),
    CONSTRAINT [UQ_DimProduct_ProductID] UNIQUE NONCLUSTERED ([ProductID] ASC)
);


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
    CONSTRAINT [PK_DimShipLocation] PRIMARY KEY CLUSTERED ([ShipLocationKey] ASC),
    CONSTRAINT [UQ_DimShipLocation] UNIQUE NONCLUSTERED ([ShipCity] ASC, [ShipRegion] ASC, [ShipCountry] ASC, [ShipPostalCode] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimShipper]...';


GO
CREATE TABLE [dbo].[DimShipper] (
    [ShipperKey]  INT           IDENTITY (1, 1) NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    [LoadDate]    DATETIME      NOT NULL,
    CONSTRAINT [PK_DimShipper] PRIMARY KEY CLUSTERED ([ShipperKey] ASC),
    CONSTRAINT [UQ_DimShipper_ShipperID] UNIQUE NONCLUSTERED ([ShipperID] ASC)
);


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
    CONSTRAINT [PK_FactSales] PRIMARY KEY CLUSTERED ([SalesKey] ASC),
    CONSTRAINT [UQ_FactSales_Line] UNIQUE NONCLUSTERED ([OrderID] ASC, [ProductKey] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [TableName]      NVARCHAR (100) NOT NULL,
    [LastRowVersion] BIGINT         NOT NULL,
    [LastLoadDate]   DATETIME       NULL,
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([TableName] ASC)
);


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
PRINT N'Creando Restricción DEFAULT [dbo].[DF_PackageConfig_LastRowVersion]...';


GO
ALTER TABLE [dbo].[PackageConfig]
    ADD CONSTRAINT [DF_PackageConfig_LastRowVersion] DEFAULT ((0)) FOR [LastRowVersion];


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
    ADD CONSTRAINT [CK_FactSales_Discount] CHECK ([Discount] >= (0) AND [Discount] <= (1));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_FactSales_Freight]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [CK_FactSales_Freight] CHECK ([AllocatedFreight] >= (0));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_FactSales_Price]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [CK_FactSales_Price] CHECK ([UnitPrice] >= (0));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_FactSales_Quantity]...';


GO
ALTER TABLE [dbo].[FactSales] WITH NOCHECK
    ADD CONSTRAINT [CK_FactSales_Quantity] CHECK ([Quantity] > (0));


GO
PRINT N'Creando Procedimiento [dbo].[GetLastRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetLastRowVersion]
(
    @TableName NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [LastRowVersion]
    FROM [dbo].[PackageConfig]
    WHERE [TableName] = @TableName;
END
GO
PRINT N'Creando Procedimiento [dbo].[UpdateLastRowVersion]...';


GO
CREATE PROCEDURE [dbo].[UpdateLastRowVersion]
(
    @TableName NVARCHAR(100),
    @LastRowVersion BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[PackageConfig]
    SET [LastRowVersion] = @LastRowVersion,
        [LastLoadDate] = GETDATE()
    WHERE [TableName] = @TableName;
END
GO
/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.			
 Ejemplo:      :r .\miArchivo.sql								
 Use la sintaxis de SQLCMD para hacer referencia a una variable en el script posterior a la implementación.		
 Ejemplo:      :setvar TableName miTabla							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-- Fila "fecha desconocida" (pedidos sin enviar)
IF NOT EXISTS (SELECT 1 FROM [dbo].[DimDate] WHERE [DateKey] = 19000101)
INSERT INTO [dbo].[DimDate]
    ([DateKey],[FullDate],[Year],[Semester],[Quarter],[QuarterName],[Month],[MonthName],
     [YearMonth],[WeekOfYear],[DayOfMonth],[DayOfWeek],[DayName],[IsWeekend])
VALUES
    (19000101,'19000101',1900,1,1,N'Q1',1,N'January',190001,1,1,1,N'Monday',0);

-- Fechas 1996-2030
;WITH Fechas AS (
    SELECT CAST('19960101' AS DATE) AS d
    UNION ALL
    SELECT DATEADD(DAY, 1, d) FROM Fechas WHERE d < '20301231'
)
INSERT INTO [dbo].[DimDate]
    ([DateKey],[FullDate],[Year],[Semester],[Quarter],[QuarterName],[Month],[MonthName],
     [YearMonth],[WeekOfYear],[DayOfMonth],[DayOfWeek],[DayName],[IsWeekend])
SELECT
    YEAR(d) * 10000 + MONTH(d) * 100 + DAY(d),
    d,
    YEAR(d),
    CASE WHEN MONTH(d) <= 6 THEN 1 ELSE 2 END,
    DATEPART(QUARTER, d),
    N'Q' + CAST(DATEPART(QUARTER, d) AS NVARCHAR(1)),
    MONTH(d),
    CHOOSE(MONTH(d), N'January',N'February',N'March',N'April',N'May',N'June',
                     N'July',N'August',N'September',N'October',N'November',N'December'),
    YEAR(d) * 100 + MONTH(d),
    DATEPART(ISO_WEEK, d),
    DAY(d),
    (DATEDIFF(DAY, '19000101', d) % 7) + 1,   -- 1 = lunes ... 7 = domingo
    CHOOSE((DATEDIFF(DAY, '19000101', d) % 7) + 1, N'Monday',N'Tuesday',N'Wednesday',
                     N'Thursday',N'Friday',N'Saturday',N'Sunday'),
    CASE WHEN (DATEDIFF(DAY, '19000101', d) % 7) + 1 >= 6 THEN 1 ELSE 0 END
FROM Fechas
WHERE NOT EXISTS (SELECT 1 FROM [dbo].[DimDate] x WHERE x.[FullDate] = Fechas.d)
OPTION (MAXRECURSION 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Customers')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Customers', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Employees')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Employees', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Products')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Products', 0);
GO

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

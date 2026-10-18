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

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Shippers')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Shippers', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Orders')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Orders', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'ShipLocations')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'ShipLocations', 0);
GO

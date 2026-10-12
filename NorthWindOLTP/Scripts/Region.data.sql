PRINT 'Populating brands table';
SET NOCOUNT ON;
SET IDENTITY_INSERT [dbo].[Region] ON 
INSERT [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (1, N'Eastern                                           ')

INSERT [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (2, N'Western                                           ')

INSERT [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (3, N'Northern                                          ')

INSERT [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (4, N'Southern                                          ')

SET IDENTITY_INSERT [dbo].[Region] OFF
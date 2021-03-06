CREATE DATABASE [QuanLyCoffe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyCoffe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuanLyCoffe.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyCoffe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuanLyCoffe_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
USE [QuanLyCoffe]
GO
/****** Object:  StoredProcedure [dbo].[showBill]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP PROCEDURE [dbo].[showBill]
GO
ALTER TABLE [dbo].[bills] DROP CONSTRAINT [FK__bills__idDrinks__36B12243]
GO
/****** Object:  Table [dbo].[tableDrinks]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP TABLE [dbo].[tableDrinks]
GO
/****** Object:  Table [dbo].[Statistical]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP TABLE [dbo].[Statistical]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP TABLE [dbo].[Staff]
GO
/****** Object:  Table [dbo].[Drinks]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP TABLE [dbo].[Drinks]
GO
/****** Object:  Table [dbo].[bills]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP TABLE [dbo].[bills]
GO
/****** Object:  UserDefinedFunction [dbo].[TotalMoney]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP FUNCTION [dbo].[TotalMoney]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_loinhuan]    Script Date: 11/30/2020 1:14:06 AM ******/
DROP FUNCTION [dbo].[fn_loinhuan]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_loinhuan]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_loinhuan]  (@DateStart CHAR(20),@DateEnd CHAR(20))
	RETURNS INT
    BEGIN
	DECLARE @Total INT
	SET @Total=(SELECT SUM(st.Count*dr.Price) FROM dbo.Statistical AS st JOIN dbo.Drinks AS dr ON st.IdDrinks=dr.id
	JOIN dbo.tableDrinks AS tb ON tb.id = st.IdTables JOIN dbo.Staff AS s 
	ON s.ID = st.IdStaff WHERE st.Date>@DateStart AND st.Date<=@DateEnd)
	RETURN @Total 
	END
    
GO
/****** Object:  UserDefinedFunction [dbo].[TotalMoney]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TotalMoney](@Id INT)
RETURNS FLOAT
as
BEGIN
DECLARE @Result FLOAT
SET @Result =(SELECT SUM(Soluong*Price) FROM dbo.bills JOIN dbo.Drinks ON Drinks.id = bills.idDrinks  
WHERE @Id=idTable)
RETURN @Result 
END
GO
/****** Object:  Table [dbo].[bills]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bills](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Soluong] [int] NULL,
	[idTable] [int] NULL,
	[idDrinks] [int] NULL,
	[Ngayxuat] [datetime] NULL,
	[IDNV] [nchar](10) NOT NULL,
 CONSTRAINT [PK__bills__3213E83FF7C898FA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Drinks]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drinks](
	[id] [int] IDENTITY(0,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Staff]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Staff](
	[ID] [nchar](10) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Date] [date] NULL,
	[Salary] [int] NULL,
	[Sex] [bit] NULL,
	[Position] [nvarchar](10) NULL,
	[Pass] [char](10) NULL,
 CONSTRAINT [PK__Staff__3214EC2738F4B9CD] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Statistical]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statistical](
	[idBill] [int] NOT NULL,
	[Count] [nchar](10) NULL,
	[IdTables] [int] NULL,
	[IdDrinks] [int] NULL,
	[Date] [datetime] NULL,
	[IdStaff] [nchar](10) NULL,
 CONSTRAINT [PK_Statistical] PRIMARY KEY CLUSTERED 
(
	[idBill] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tableDrinks]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tableDrinks](
	[id] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[stas] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Drinks] ON 

INSERT [dbo].[Drinks] ([id], [Name], [Price]) VALUES (1, N'Cacao Nóng/Đá', 20000)
INSERT [dbo].[Drinks] ([id], [Name], [Price]) VALUES (3, N'Coffe Sữa', 22000)
INSERT [dbo].[Drinks] ([id], [Name], [Price]) VALUES (4, N'Nước Cam', 15000)
INSERT [dbo].[Drinks] ([id], [Name], [Price]) VALUES (5, N'Nước ép cà chua', 25000)
INSERT [dbo].[Drinks] ([id], [Name], [Price]) VALUES (6, N'Sinh tố bơ', 35000)
INSERT [dbo].[Drinks] ([id], [Name], [Price]) VALUES (1001, N'Coffe đá', 20000)
SET IDENTITY_INSERT [dbo].[Drinks] OFF
INSERT [dbo].[Staff] ([ID], [Name], [Date], [Salary], [Sex], [Position], [Pass]) VALUES (N'Admin     ', N'Management', CAST(N'1990-04-08' AS Date), NULL, 1, N'admin', N'admin     ')
INSERT [dbo].[Staff] ([ID], [Name], [Date], [Salary], [Sex], [Position], [Pass]) VALUES (N'NV01      ', N'Nguyễn Hoàng ', CAST(N'2020-11-22' AS Date), 1200000, NULL, N'Staff', N'Hoang     ')
INSERT [dbo].[Staff] ([ID], [Name], [Date], [Salary], [Sex], [Position], [Pass]) VALUES (N'NV02      ', N'Nguyễn Nhật Linh', CAST(N'2000-03-20' AS Date), 1500000, 1, N'Staff', N'Linh      ')
INSERT [dbo].[Staff] ([ID], [Name], [Date], [Salary], [Sex], [Position], [Pass]) VALUES (N'NV03      ', N'Tân Minh Lý', CAST(N'2000-02-20' AS Date), 2000000, 1, N'Staff', N'Ly        ')
INSERT [dbo].[Staff] ([ID], [Name], [Date], [Salary], [Sex], [Position], [Pass]) VALUES (N'NV04      ', N'Nguyễn Thị Thanh', CAST(N'2000-04-05' AS Date), 1200000, 0, N'Staff', N'Thanh     ')
INSERT [dbo].[Staff] ([ID], [Name], [Date], [Salary], [Sex], [Position], [Pass]) VALUES (N'NV05      ', N'Nguyễn Thị Thanh Thủy', CAST(N'2000-04-05' AS Date), 1200000, NULL, N'Staff', N'Thuy      ')
INSERT [dbo].[Statistical] ([idBill], [Count], [IdTables], [IdDrinks], [Date], [IdStaff]) VALUES (1, N'1         ', 2, 4, CAST(N'2020-11-28 18:27:46.510' AS DateTime), N'NV05      ')
INSERT [dbo].[Statistical] ([idBill], [Count], [IdTables], [IdDrinks], [Date], [IdStaff]) VALUES (2, N'1         ', 2, 1, CAST(N'2020-11-28 18:27:48.570' AS DateTime), N'NV05      ')
INSERT [dbo].[Statistical] ([idBill], [Count], [IdTables], [IdDrinks], [Date], [IdStaff]) VALUES (3, N'1         ', 2, 1001, CAST(N'2020-11-28 18:28:39.443' AS DateTime), N'NV05      ')
INSERT [dbo].[Statistical] ([idBill], [Count], [IdTables], [IdDrinks], [Date], [IdStaff]) VALUES (4, N'1         ', 3, 6, CAST(N'2020-11-28 18:29:15.093' AS DateTime), N'NV05      ')
INSERT [dbo].[Statistical] ([idBill], [Count], [IdTables], [IdDrinks], [Date], [IdStaff]) VALUES (5, N'1         ', 8, 5, CAST(N'2020-11-29 23:29:48.623' AS DateTime), N'NV01      ')
INSERT [dbo].[Statistical] ([idBill], [Count], [IdTables], [IdDrinks], [Date], [IdStaff]) VALUES (6, N'1         ', 8, 6, CAST(N'2020-11-29 23:29:51.220' AS DateTime), N'NV01      ')
INSERT [dbo].[Statistical] ([idBill], [Count], [IdTables], [IdDrinks], [Date], [IdStaff]) VALUES (7, N'1         ', 8, 3, CAST(N'2020-11-29 23:29:53.083' AS DateTime), N'NV01      ')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (0, N'Bàn 0', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (1, N'Bàn 1', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (2, N'Bàn 2', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (3, N'Bàn 3', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (4, N'Bàn 4', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (5, N'Bàn 5', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (6, N'Bàn 6', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (7, N'Bàn 7', N'0')
INSERT [dbo].[tableDrinks] ([id], [Name], [stas]) VALUES (8, N'Bàn 8', N'0')
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FK__bills__idDrinks__36B12243] FOREIGN KEY([idDrinks])
REFERENCES [dbo].[Drinks] ([id])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FK__bills__idDrinks__36B12243]
GO
/****** Object:  StoredProcedure [dbo].[showBill]    Script Date: 11/30/2020 1:14:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[showBill] @id int
AS
BEGIN
SELECT Name,Soluong,Price FROM dbo.bills JOIN dbo.Drinks ON Drinks.id = bills.idDrinks
WHERE @id=dbo.bills.id
END
GO

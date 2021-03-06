USE [master]
GO
/****** Object:  Database [RandomWikiNSContext-20160425212810]    Script Date: 2016-04-29 17:01:39 ******/
CREATE DATABASE [RandomWikiNSContext-20160425212810]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RandomWikiNSContext-20160425212810.mdf', FILENAME = N'c:\users\niklas\documents\visual studio 2015\Projects\RandomWikiNS\RandomWikiNS\App_Data\RandomWikiNSContext-20160425212810.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RandomWikiNSContext-20160425212810_log.ldf', FILENAME = N'c:\users\niklas\documents\visual studio 2015\Projects\RandomWikiNS\RandomWikiNS\App_Data\RandomWikiNSContext-20160425212810_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RandomWikiNSContext-20160425212810].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET ARITHABORT OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET  ENABLE_BROKER 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET  MULTI_USER 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET DELAYED_DURABILITY = DISABLED 
GO
USE [RandomWikiNSContext-20160425212810]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RatingValue] [smallint] NOT NULL,
 CONSTRAINT [PK_dbo.Ratings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WikiPages]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WikiPages](
	[PageId] [bigint] IDENTITY(1,1) NOT NULL,
	[Category_Id] [int] NULL,
	[Rating_Id] [int] NULL,
 CONSTRAINT [PK_dbo.WikiPages] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_Category_Id]    Script Date: 2016-04-29 17:01:39 ******/
CREATE NONCLUSTERED INDEX [IX_Category_Id] ON [dbo].[WikiPages]
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Rating_Id]    Script Date: 2016-04-29 17:01:39 ******/
CREATE NONCLUSTERED INDEX [IX_Rating_Id] ON [dbo].[WikiPages]
(
	[Rating_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WikiPages]  WITH CHECK ADD  CONSTRAINT [FK_dbo.WikiPages_dbo.Categories_Category_Id] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[WikiPages] CHECK CONSTRAINT [FK_dbo.WikiPages_dbo.Categories_Category_Id]
GO
ALTER TABLE [dbo].[WikiPages]  WITH CHECK ADD  CONSTRAINT [FK_dbo.WikiPages_dbo.Ratings_Rating_Id] FOREIGN KEY([Rating_Id])
REFERENCES [dbo].[Ratings] ([Id])
GO
ALTER TABLE [dbo].[WikiPages] CHECK CONSTRAINT [FK_dbo.WikiPages_dbo.Ratings_Rating_Id]
GO
/****** Object:  StoredProcedure [dbo].[ClearDatabase]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClearDatabase]

AS
BEGIN
	DELETE FROM WikiPages;
	DELETE FROM Categories;

END
GO
/****** Object:  StoredProcedure [dbo].[CreateCategory]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateCategory]
	(@name nvarchar(25))
AS

DECLARE @count int;
SELECT @count = 0;

SELECT @count = Count(*) from Categories where Categories.CategoryName = @name;

if (@count = 0)
BEGIN
	INSERT INTO Categories (CategoryName)
	VALUES (@name)
END
GO
/****** Object:  StoredProcedure [dbo].[CreateRatingOnWiki]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateRatingOnWiki]
	(@pageid bigint, @ratingid int)
AS

DECLARE @count int;
SELECT @count = 0;

SELECT @count = Count(*) from WikiPages where PageId = @pageid;

if (@count = 1)
BEGIN
	UPDATE WikiPages 
	SET Rating_Id = @ratingid
	WHERE PageId = @pageid;
END
GO
/****** Object:  StoredProcedure [dbo].[GetCategories]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCategories]

AS
BEGIN
	SELECT * FROM Categories;
END
GO
/****** Object:  StoredProcedure [dbo].[GetCategory]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCategory]
	( @catid int )
AS
BEGIN
	SELECT * FROM Categories WHERE Id = @catid;
END
GO
/****** Object:  StoredProcedure [dbo].[GetCategoryName]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCategoryName]
	(@id int )
AS
BEGIN
	SELECT CategoryName FROM Categories WHERE Categories.Id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[GetRating]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRating]
	(@ratid int )
AS
BEGIN
	SELECT * FROM Ratings WHERE Id = @ratid;
END
GO
/****** Object:  StoredProcedure [dbo].[GetRatings]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRatings]

AS
BEGIN
	SELECT * from Ratings
END
GO
/****** Object:  StoredProcedure [dbo].[GetWikiPage]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetWikiPage]
	(@pageid bigint )
AS
BEGIN
	SELECT * FROM WikiPages WHERE PageId = @pageid
END
GO
/****** Object:  StoredProcedure [dbo].[SaveWikiPage]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaveWikiPage]
	(@pageid bigint )
AS

DECLARE @count int;
SELECT  @count = 0;

SELECT @count = Count(*) from WikiPages where PageId = @pageid;

if(@count = 0)
BEGIN
	SET IDENTITY_INSERT WikiPages ON
	INSERT INTO WikiPages (PageId)
	VALUES (@pageid)
	SET IDENTITY_INSERT WikiPages OFF
END
GO
/****** Object:  StoredProcedure [dbo].[SetWikiCategory]    Script Date: 2016-04-29 17:01:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetWikiCategory]
	(@pageid bigint, @categoryid int)
AS

DECLARE @count int;
SELECT @count = 0;

SELECT @count = Count(*) from WikiPages where PageId = @pageid;

if (@count = 1)
BEGIN
	UPDATE WikiPages 
	SET Category_Id = @categoryid
	WHERE PageId = @pageid;
END
GO
USE [master]
GO
ALTER DATABASE [RandomWikiNSContext-20160425212810] SET  READ_WRITE 
GO

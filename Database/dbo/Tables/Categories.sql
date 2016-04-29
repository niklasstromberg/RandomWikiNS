CREATE TABLE [dbo].[Categories] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [CategoryName] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED ([Id] ASC)
);


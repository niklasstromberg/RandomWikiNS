CREATE TABLE [dbo].[WikiPages] (
    [PageId]      BIGINT IDENTITY (1, 1) NOT NULL,
    [Category_Id] INT    NULL,
    [Rating_Id]   INT    NULL,
    CONSTRAINT [PK_dbo.WikiPages] PRIMARY KEY CLUSTERED ([PageId] ASC),
    CONSTRAINT [FK_dbo.WikiPages_dbo.Categories_Category_Id] FOREIGN KEY ([Category_Id]) REFERENCES [dbo].[Categories] ([Id]),
    CONSTRAINT [FK_dbo.WikiPages_dbo.Ratings_Rating_Id] FOREIGN KEY ([Rating_Id]) REFERENCES [dbo].[Ratings] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Category_Id]
    ON [dbo].[WikiPages]([Category_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Rating_Id]
    ON [dbo].[WikiPages]([Rating_Id] ASC);


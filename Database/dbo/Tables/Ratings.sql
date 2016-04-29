CREATE TABLE [dbo].[Ratings] (
    [Id]          INT      IDENTITY (1, 1) NOT NULL,
    [RatingValue] SMALLINT NOT NULL,
    CONSTRAINT [PK_dbo.Ratings] PRIMARY KEY CLUSTERED ([Id] ASC)
);


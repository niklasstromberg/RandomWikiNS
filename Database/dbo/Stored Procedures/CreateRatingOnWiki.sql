CREATE PROCEDURE CreateRatingOnWiki
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
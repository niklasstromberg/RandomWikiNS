CREATE PROCEDURE SetWikiCategory
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
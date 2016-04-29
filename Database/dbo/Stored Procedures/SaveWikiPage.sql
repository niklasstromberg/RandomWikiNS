CREATE PROCEDURE SaveWikiPage
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
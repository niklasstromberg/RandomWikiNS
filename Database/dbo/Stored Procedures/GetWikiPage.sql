CREATE PROCEDURE GetWikiPage
	(@pageid bigint )
AS
BEGIN
	SELECT * FROM WikiPages WHERE PageId = @pageid
END
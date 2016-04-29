CREATE PROCEDURE GetCategory
	( @catid int )
AS
BEGIN
	SELECT * FROM Categories WHERE Id = @catid;
END
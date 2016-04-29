CREATE PROCEDURE GetCategoryName
	(@id int )
AS
BEGIN
	SELECT CategoryName FROM Categories WHERE Categories.Id = @id;
END
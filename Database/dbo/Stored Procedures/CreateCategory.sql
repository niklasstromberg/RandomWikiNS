CREATE PROCEDURE CreateCategory
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
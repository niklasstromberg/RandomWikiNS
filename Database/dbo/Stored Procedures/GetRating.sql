CREATE PROCEDURE GetRating
	(@ratid int )
AS
BEGIN
	SELECT * FROM Ratings WHERE Id = @ratid;
END
-- Q2: How many players named Jaun play for the league?

-- A2: Let's do a query to find all the Juan's...

SELECT 'How Many Juans' AS my_message,
	COUNT(*) AS juan_count
	FROM dbo.tblPlayerDim
	WHERE f_name = 'Juan';
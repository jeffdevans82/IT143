-- Q2: How many players named Jaun play for the league?

-- A2: Let's do a query to find all the Juan's...

SELECT v.my_message
	, v.juan_count
	into dbo.t_juan_count 
  FROM dbo.v_juan_count AS v;
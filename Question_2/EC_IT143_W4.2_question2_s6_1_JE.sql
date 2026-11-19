-- Q2: How many players named Jaun play for the league?

-- A2: Let's do a query to find all the Juan's...


-- 1) Reload data

TRUNCATE TABLE dbo.t_juan_count;

INSERT INTO dbo.t_juan_count	
	SELECT v.my_message
		, v.juan_count
	FROM dbo.v_juan_count AS v;


-- 2) Review results

SELECT t.*
	FROM dbo.t_juan_count AS t;

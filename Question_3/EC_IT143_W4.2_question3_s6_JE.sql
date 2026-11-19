-- Q3: How many purchases did Marge make?
-- A3: Let's make a query to find out...


-- 1) Reload data

TRUNCATE TABLE dbo.t_purchase_count;

INSERT INTO dbo.t_purchase_count	
	SELECT v.my_message
		, v.purchase_count
	FROM dbo.v_purchase_count AS v;


-- 2) Review results

SELECT t.*
	FROM dbo.t_purchase_count AS t;
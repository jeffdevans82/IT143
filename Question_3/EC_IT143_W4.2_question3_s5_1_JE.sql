-- Q3: How many purchases did Marge make?
-- A3: Let's make a query to find out...

SELECT v.my_message
	, v.purchase_count
	INTO dbo.t_purchase_count
 FROM dbo.v_purchase_count AS v;


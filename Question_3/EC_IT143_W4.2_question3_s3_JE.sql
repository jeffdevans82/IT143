-- Q3: How many purchases did Marge make?
-- A3: Let's make a query to find out...

SELECT 'How Many Purchases' AS my_message,
	COUNT(*) AS purchase_count
	FROM dbo.FBS_Viza_Costmo
	WHERE Member_Name = 'Marge Simpson'

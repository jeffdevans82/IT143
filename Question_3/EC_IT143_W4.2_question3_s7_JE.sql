CREATE PROCEDURE dbo.usp_purchase_count
AS


/*****************************************************************************************************************
NAME:    dbo.v_purchase_count
PURPOSE: Create the Purchase Count - Load View

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/16/2026   JEVANS      1. Built this script for EC IT143


RUNTIME: 
1s

NOTES: 
This script exists to help me execute step 7 of 8 in the Answer focused approach for T-SQL Data Manipulation
 
******************************************************************************************************************/

	BEGIN
		-- 1) Reload data

		TRUNCATE TABLE dbo.t_purchase_count;

		INSERT INTO dbo.t_purchase_count	
			SELECT v.my_message
			, v.purchase_count
			FROM dbo.v_purchase_count AS v;


		-- 2) Review results

		SELECT t.*
		FROM dbo.t_purchase_count AS t;

	END;
GO
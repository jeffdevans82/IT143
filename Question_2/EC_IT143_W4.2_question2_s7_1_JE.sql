CREATE PROCEDURE dbo.usp_juan_count
AS


/*****************************************************************************************************************
NAME:    dbo.v_juan_count
PURPOSE: Create the Juan Count - Load View

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/16/2026   JEVANS      1. Built this script for EC IT143


RUNTIME: 
1s

NOTES: 
This script exists to help me execute step 4 of 8 in the Answer focused approach for T-SQL Data Manipulation
 
******************************************************************************************************************/

	BEGIN

	-- 1) Reload Data

		TRUNCATE TABLE dbo.t_juan_count;

INSERT INTO dbo.t_juan_count	
	SELECT v.my_message
		, v.juan_count
	FROM dbo.v_juan_count AS v;


	-- 2) Review results

	SELECT t.*
	  FROM dbo.t_juan_count AS t;

	END;
GO

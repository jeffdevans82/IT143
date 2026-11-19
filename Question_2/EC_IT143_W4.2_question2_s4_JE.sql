DROP VIEW IF EXISTS dbo.v_juan_count;
GO

CREATE VIEW dbo.v_juan_count
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

SELECT 'How Many Juans' AS my_message,
	COUNT(*) AS juan_count
	FROM dbo.tblPlayerDim
	WHERE f_name = 'Juan';

DROP VIEW IF EXISTS dbo.v_purchase_count;
GO

CREATE VIEW dbo.v_purchase_count
AS

/*****************************************************************************************************************
NAME:    dbo.v_purchase_count
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

SELECT 'How Many Purchases' AS my_message,
	COUNT(*) AS purchase_count
	FROM dbo.FBS_Viza_Costmo
	WHERE Member_Name = 'Marge Simpson'
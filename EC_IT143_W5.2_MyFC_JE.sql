/***********************************************************************************
NAME: My Script EC_IT143_W5.2_MYFC_JE
PURPOSE: My script purpose...
MODIFICATION LOG:
Ver Date Author Description
----- ---------- -----------
-------------------------------------------------------------------------------
1.0 11/23/2026 JEVANS. Built this script for EC IT143 5.2
RUNTIME:
0m 1s
NOTES:
This is the group of queries from the MYFC database to answer 4 questions.
***********************************************************************************/

-- Q1: (Jeffrey Evans)Mrs. Kindle is looking to adjust player salaries for her team going into the next year. 
--     She would like a report of all players total salaries for the year of 2019. 
--	   The report should include each player name, not just their player ID.
-- A1: Here is how I answered this question.
SELECT GETDATE() AS my_date;

SELECT
    pd.pl_name AS PlayerName,
    SUM(pf.mtd_salary) AS TotalSalary
FROM dbo.tblPlayerFact AS pf
INNER JOIN dbo.tblPlayerDim AS pd
    ON pf.pl_id = pd.pl_id
WHERE pf.as_of_date >= '2019-01-01'
  AND pf.as_of_date < '2020-01-01'
GROUP BY
    pd.pl_id,
    pd.pl_name
ORDER BY
    pd.pl_name;


-- Q2: (Jeffrey Evans) Mr Garber is looking to update the roster of players as there have been many new players in the 2019 season. 
--     Please create a report with all players and their position names.
-- A2: Please see the answer below.

SELECT
    pl.pl_id AS PlayerID,
    pl.pl_name AS PlayerName,
    p.p_name AS PositionName
FROM dbo.tblPlayerDim AS pl
LEFT JOIN dbo.tblPositionDim AS p
    ON pl.p_id = p.p_id
ORDER BY
    pl.pl_name;


-- Q3: (Jeffrey Evans) David is looking to expand his roster with more defenders and midfielders to replace some that retired at the 
--     end of the previous season. Please create a list of all midfielders and defenders with their names, player numbers and salaries.
-- A3: Please see the answer below.

SELECT
    pl.pl_name AS PlayerName,
    pl.pl_num AS PlayerNumber,
    SUM(pf.mtd_salary) AS TotalSalary
FROM dbo.tblPlayerDim AS pl
INNER JOIN dbo.tblPositionDim AS pos
    ON pl.p_id = pos.p_id
INNER JOIN dbo.tblPlayerFact AS pf
    ON pl.pl_id = pf.pl_id
WHERE pos.p_name IN ('Defender', 'Midfielder')
  AND pf.as_of_date >= '2019-01-01'
  AND pf.as_of_date < '2020-01-01'
GROUP BY
    pl.pl_id,
    pl.pl_name,
    pl.pl_num,
    pos.p_name
ORDER BY
    pos.p_name,
    pl.pl_name;


-- Q4: (Jose Roberto Martinez Cabrera)Can you write a SQL query that joins tblPlayerDim with tblTeamDim and tblPositionDim to 
--    list all players along with their team code and position name?
-- A4: Please see the answer below.

SELECT
    pl.pl_id AS PlayerID,
    pl.pl_name AS PlayerName,
    pl.pl_num AS PlayerNumber,
    t.t_code AS TeamCode,
    p.p_name AS PositionName
FROM dbo.tblPlayerDim AS pl
INNER JOIN dbo.tblTeamDim AS t
    ON pl.t_id = t.t_id
INNER JOIN dbo.tblPositionDim AS p
    ON pl.p_id = p.p_id
ORDER BY
    t.t_code,
    pl.pl_name;
/***********************************************************************************

NAME: My Script EC_IT143_W5.2_Simpsons_JE
PURPOSE: My script purpose...
MODIFICATION LOG:
Ver Date Author Description
----- ---------- -----------
-------------------------------------------------------------------------------
1.0 11/23/2026 JEVANS. Built this script for EC IT143 5.2
RUNTIME:
0m 1s
NOTES:
This is the group of queries from the Simpsons database to answer 4 questions.
***********************************************************************************/

-- Q1: (Jeffrey Evans) Marge and Homer Simpson made a lot of purchases at the Quik-E-Mart.
--	   How many purchases did they make in the year 1989 and how much was the total of all of their purchases?
-- A1: Marge and Homer combined to make 29 purchases for a total of $889.59

SELECT GETDATE() AS my_date;

SELECT
    COUNT(*) AS TotalPurchases,
    SUM(Debit) AS TotalSpent
FROM FBS_Viza_Costmo
WHERE
    [Member_Name] IN ('Marge Simpson',  'Homer Simpson')
    AND Description LIKE 'KWIK-E-MART%'
    AND [Date] >= '1989-01-01'
    AND [Date] < '1990-01-01';

-- Q2: (Jeffrey Evans) Homer Simpson owes a bar tab at Moe's Tavern and cannot afford to pay off his tab. 
--     Moe hired a private investigator to check on Homer's finances and wants to check how many different businesses 
--     that Home has purchased using Planet Express Delivery from in the year 1991.
-- A2: Home purchased from 107 different businesses

SELECT
    COUNT(DISTINCT Description) AS DifferentBusinesses
FROM Planet_Express
WHERE
    [Card_Member] = 'HOMER SIMPSON'
    AND [Date] >= '1991-01-01'
    AND [Date] < '1992-01-01';

-- Q3: (Jeffrey Evans) Marge Simpson is reviewing her finances for the 1989 tax year. She would like a total amount of money she spent 
--     in person as well as using Planet Express Delivery for that year.
-- A3: Marge made the following purchases in the year 1989.
--     In-Person Purchases - $14,500.68
--     Planet Express Delivery - $17,738.72(rounded up)

SELECT
    'In-Person Purchases' AS SpendingMethod,
    SUM(Debit) + SUM(
        CASE
            WHEN Description <> 'PAYMENT'
            THEN COALESCE(Credit, 0)
            ELSE 0
        END
    ) AS TotalSpent
FROM FBS_Viza_Costmo
WHERE
    [Member_Name] = 'Marge Simpson'
    AND [Date] >= '1989-01-01'
    AND [Date] < '1990-01-01'

UNION ALL

SELECT
    'Planet Express Delivery' AS SpendingMethod,
    SUM(Amount) AS TotalSpent
FROM Planet_Express
WHERE
    [Card_Member] = 'MARGE SIMPSON'
    AND [Date] >= '1989-01-01'
    AND [Date] < '1990-01-01';


-- Q4: (Nnamdi Stanley Ijezie) What is the total transaction amount spent on the Planet Express card by employees with an 'Active' status? 
--     I need to see the Department name, Card_Member, and the sum of the Amount to analyze departmental spending habits.
-- A4: Simpsons Family - MARGE SIMPSON - 69589.06(rounded up)

SELECT
    F.Department,
    P.[Card_Member],
    SUM(P.Amount) AS TotalAmountSpent
FROM Planet_Express AS P
INNER JOIN Family_Data AS F
    ON UPPER(P.[Card_Member]) = UPPER(F.Name)
WHERE F.Status = 'Active'
GROUP BY
    F.Department,
    P.[Card_Member]
ORDER BY
    F.Department,
    P.[Card_Member];
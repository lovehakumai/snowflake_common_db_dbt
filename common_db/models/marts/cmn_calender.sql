WITH 
params AS (
    SELECT 
        '2015-01-01'::DATE AS stdd 
        , '2025-01-01'::DATE AS eddd 
)
, vacant_table AS (
    SELECT 
        DATEADD(
            'day'
            , ROW_NUMBER()OVER(ORDER BY NULL) - 1
            , (SELECT stdd FROM params) 
        ) AS calender_date
    FROM TABLE(GENERATOR (ROWCOUNT => 4000))
)
SELECT 
    YEAR(calender_date) AS cl_year
    , MONTH(calender_date) AS cl_month
    , DAY(calender_date) AS cl_day
    , calender_date AS cl_date 
FROM vacant_table
WHERE 
    calender_date <= (SELECT eddd FROM params)
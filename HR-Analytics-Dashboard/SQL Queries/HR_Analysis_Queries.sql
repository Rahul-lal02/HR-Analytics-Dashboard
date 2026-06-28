CREATE DATABASE HRAnalyticsDB;

USE HRAnalyticsDB;

SELECT * from  INFORMATION_SCHEMA.TABLES;

SELECT * from HR_ANALYTICS;

--Counting total employees--
SELECT count(*) as TOTAL_EMPLOYEES from dbo.HR_ANALYTICS;


--total attrition count
SELECT COUNT(*) AS attrition_count FROM dbo.HR_ANALYTICS WHERE Attrition = '1';

--to see what are the different values of attrition column in our dataset--
SELECT DISTINCT Attrition
FROM dbo.HR_ANALYTICS;


--attrition %
SELECT
    ROUND(
        (COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0)
        / COUNT(*), 2
    ) AS attrition_rate_percent
FROM dbo.HR_ANALYTICS;

--The company has an attrition rate of 16.12%.
--This means approximately 1 out of every 6 employees leaves the company.
--In many industries, an attrition rate above 15% is considered relatively high and may require management attention.


--Employee count as per department--
SELECT
    Department,
    COUNT(*) AS employee_count
FROM dbo.HR_ANALYTICS
GROUP BY Department
ORDER BY employee_count DESC;

--Research & Development (R&D) is the largest department, accounting for about 65% of the workforce.
--Human Resources has the smallest workforce.

--Attrition by Department--
SELECT
    Department,
    COUNT(*) AS attrition_count
FROM dbo.HR_ANALYTICS
WHERE Attrition = 1
GROUP BY Department
ORDER BY attrition_count DESC;

--R&D has the highest number of employees leaving.
--However, since R&D also has the largest workforce, we should calculate the Attrition Rate by Department to make a fair comparison.


--% of the same department
SELECT
    Department,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM dbo.HR_ANALYTICS
GROUP BY Department
ORDER BY attrition_rate_percent DESC;

--Key insights--
--Although R&D has the highest number of employees leaving (133), the Sales department has the highest attrition rate (20.63%).
--This indicates that employees in the Sales department are more likely to leave compared to other departments.
--Management should investigate potential causes in the Sales department such as:
--High work pressure
--Compensation issues
--Sales targets
--Work-life balance



--Attrition by Gender

SELECT
    Gender,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count
FROM dbo.HR_ANALYTICS
GROUP BY Gender
ORDER BY attrition_count DESC;

--

--Overtime vs Attrition
SELECT
    OverTime,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM dbo.HR_ANALYTICS
GROUP BY OverTime
ORDER BY attrition_rate_percent DESC;

--Employees working overtime have an attrition rate of 30.53%, which is nearly 3 times higher than employees who do not work overtime (10.44%).
--This is a major finding.

--Attrition by Job Role--
SELECT
    JobRole,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM dbo.HR_ANALYTICS
GROUP BY JobRole
ORDER BY attrition_rate_percent DESC;

--Sales Representatives exhibit the highest attrition rate (39.76%), indicating significant employee turnover within this role.
--Research Directors and Managers demonstrate the lowest attrition rates, suggesting better retention among senior leadership positions.
--This suggests that junior and customer-facing roles are more prone to attrition.

----Attrition by Marital Status--
SELECT
    MaritalStatus,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM dbo.HR_ANALYTICS
GROUP BY MaritalStatus
ORDER BY attrition_rate_percent DESC;
--Single employees are leaving at more than twice the rate of divorced employees.

--Average Monthly Income by Attrition--
SELECT
    Attrition,
    AVG(MonthlyIncome) AS avg_monthly_income
FROM dbo.HR_ANALYTICS
GROUP BY Attrition;
--Employees who left the company earned significantly lower salaries.


--Job Satisfaction vs Attrition--
SELECT
    JobSatisfaction,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count
FROM dbo.HR_ANALYTICS
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;




--Attrition Rate by Job Satisfaction
SELECT
    JobSatisfaction,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM dbo.HR_ANALYTICS
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;
--Employees with the lowest job satisfaction (Rating 1) have the highest attrition rate (22.84%).
--Employees with the highest job satisfaction (Rating 4) have the lowest attrition rate (11.33%).



--Attrition by Work-Life Balance
SELECT
    WorkLifeBalance,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count,
    COUNT(*) AS total_employees,
    ROU
    ND(
        COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM dbo.HR_ANALYTICS
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;
--Employees reporting the poorest work-life balance (Rating 1) exhibit an attrition rate of 31.25%.



--Attrition by Age Group
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END AS Age_Group,

    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS attrition_count,
    COUNT(*) AS total_employees,

    ROUND(
        COUNT(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent

FROM dbo.HR_ANALYTICS

GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END
ORDER BY attrition_rate_percent DESC;
--The youngest employees (18–25) experience the highest attrition rate (35.77%).


SELECT * FROM dbo.HR_ANALYTICS;

SELECT * FROM INFORMATION_SCHEMA.TABLES;


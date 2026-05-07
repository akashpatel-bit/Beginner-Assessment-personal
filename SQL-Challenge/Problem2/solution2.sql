-- TO generate  showing the breakdown of Basic, Allowances, Gross Salary, Deductions, and Net Pay for each employee.
SELECT 
    EMP_NAME AS EMPLOYEE,
    -- Income Columns
    (BASE_SALARY * 100 / 100) AS BASIC,
    (BASE_SALARY * 4 / 100) AS ALLOWANCE,
    (BASE_SALARY * 6 / 100) AS OTHERS,
    -- Gross Salary (Basic + Allowance + Others)
    ((BASE_SALARY * 100 / 100) + (BASE_SALARY * 4 / 100) + (BASE_SALARY * 6 / 100)) AS GROSS,
    -- Deduction Columns
    (BASE_SALARY * 5 / 100) AS INSURANCE,
    (BASE_SALARY * 6 / 100) AS HEALTH,
    (BASE_SALARY * 4 / 100) AS HOUSE,
    -- Total Deductions (Insurance + Health + House)
    ((BASE_SALARY * 5 / 100) + (BASE_SALARY * 6 / 100) + (BASE_SALARY * 4 / 100)) AS TOTAL_DEDUCTIONS,
    -- Net Pay (Gross - Total Deductions)
    (((BASE_SALARY * 100 / 100) + (BASE_SALARY * 4 / 100) + (BASE_SALARY * 6 / 100)) - 
     ((BASE_SALARY * 5 / 100) + (BASE_SALARY * 6 / 100) + (BASE_SALARY * 4 / 100))) AS NET_PAY
FROM salary
ORDER BY EMPLOYEE;

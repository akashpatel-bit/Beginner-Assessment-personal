-- to fill the misssing values
WITH GroupedRoles AS (
    SELECT 
        ROW_ID,
        JOB_ROLE,
        SKILLS,
        COUNT(JOB_ROLE) OVER (ORDER BY ROW_ID) AS RoleGroup
    FROM job_skills
)
SELECT 
    ROW_ID,
    FIRST_VALUE(JOB_ROLE) OVER (PARTITION BY RoleGroup ORDER BY ROW_ID) AS JOB_ROLE,
    SKILLS
FROM GroupedRoles
ORDER BY ROW_ID;

--including first test
SELECT TEST_ID, MARKS
FROM (
    SELECT 
        TEST_ID, 
        MARKS, 
        LAG(MARKS, 1, 0) OVER (ORDER BY TEST_ID) as prev_marks
    FROM student_marks
) as subquery
WHERE MARKS > prev_marks;

--excluding first test
SELECT TEST_ID, MARKS
FROM (
    SELECT 
        TEST_ID, 
        MARKS, 
        LAG(MARKS) OVER (ORDER BY TEST_ID) as prev_marks
    FROM student_marks
) as subquery
WHERE MARKS > prev_marks;

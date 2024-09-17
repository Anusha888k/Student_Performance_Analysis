USE student_analysis;

SHOW TABLES;

DESCRIBE students;

SELECT * FROM student_analysis.students;

-- Operations

-- 1.Filter by Gender

SELECT * FROM students
WHERE gender = 'female';


--   2.Aggregate Scores by Race/Ethnicity

SELECT `race/ethnicity`, 
       AVG(`math score`) AS avg_math_score,
       AVG(`reading score`) AS avg_reading_score,
       AVG(`writing score`) AS avg_writing_score
FROM students
GROUP BY `race/ethnicity`;


--   3.Count Students by Parental Level of Education

SELECT `parental level of education`, 
       COUNT(*) AS student_count
FROM `student_analysis`.`students`
GROUP BY `parental level of education`;


--   4.Compare Scores Between Students with Standard and Free/Reduced Lunch

SELECT lunch, 
       AVG(`math score`) AS avg_math_score,
       AVG(`reading score`) AS avg_reading_score,
       AVG(`writing score`) AS avg_writing_score
FROM students
GROUP BY lunch;


-- 5.Identify Top Performers (Top 10% by Average Score)

SET @limit_value = (SELECT FLOOR(0.1 * COUNT(*)) FROM students);

SET @query = CONCAT('
    SELECT * 
    FROM (
        SELECT *, 
               (`math score` + `reading score` + `writing score`) / 3 AS avg_score
        FROM students
        ORDER BY avg_score DESC
    ) AS RankedStudents
    LIMIT ', @limit_value);

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;





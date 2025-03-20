-- https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    st.student_id, st.student_name, su.subject_name, COUNT(e.subject_name) as attended_exams
FROM 
    Students st
    -- because we want a resulting chart with all the subjects for all the students, all possible combinations
    CROSS JOIN Subjects su
    -- needed because even if a student didn’t have an exam in a certain subject we want to make note of it
    LEFT JOIN Examinations e
    -- need to join on two fields because we want to count # exams per student per subject
        ON st.student_id = e.student_id 
        AND su.subject_name = e.subject_name
GROUP BY 
    st.student_id, su.subject_name
ORDER BY  
    st.student_id, su.subject_name;
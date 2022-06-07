
-- 1. Li?t k� danh s�ch sinh vi�n s?p x?p theo theo t�n:
select * from student ORDER BY id;
SELECT * FROM student ORDER BY gender;
SELECT * FROM student ORDER BY birthday;
SELECT * FROM student ORDER BY scholarship DESC;

-- 2. M�n h?c c� t�n b?t ??u b?ng ch? 'T'
SELECT * FROM subject WHERE name LIKE 'T%';

-- 3. Sinh vi�n c� ch? c�i cu?i c�ng trong t�n l� 'i'
SELECT * FROM student WHERE name LIKE '%i';

-- 4. Nh?ng khoa c� k� t? th? hai c?a t�n khoa c� ch?a ch? 'n'
SELECT * FROM faculty WHERE name LIKE '_n%';

-- 5. Sinh vi�n trong t�n c� t? 'Th?'
SELECT * FROM student WHERE name LIKE  '%Th?%';

-- 6. Sinh vi�n c� k� t? ??u ti�n c?a t�n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t�n sinh vi�n
SELECT * FROM student WHERE name BETWEEN 'A' AND 'M' ORDER BY name;

-- 7. Sinh vi�n c� h?c b?ng l?n h?n 100000, s?p x?p theo m� khoa gi?m d?n
SELECT * FROM student WHERE scholarship>100000 ORDER BY id DESC;

-- 8. Sinh vi�n c� h?c b?ng t? 150000 tr? l�n v� sinh ? H� N?i
SELECT * FROM student WHERE scholarship>=150000 AND hometown='H� N?i';

-- 9. Nh?ng sinh vi�n c� ng�y sinh t? ng�y 01/01/1991 ??n ng�y 05/06/1992
SELECT * FROM student WHERE birthday BETWEEN to_date('19910101', 'YYYYMMDD') AND to_date('19920605', 'YYYYMMDD');

-- 10. Nh?ng sinh vi�n c� h?c b?ng t? 80000 ??n 150000
SELECT * FROM student WHERE scholarship BETWEEN 80000 AND 150000;

-- 11. Nh?ng m�n h?c c� s? ti?t l?n h?n 30 v� nh? h?n 45
SELECT * FROM subject WHERE lesson_quantity BETWEEN 30 AND 45;


/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t th�ng tin v? m?c h?c b?ng c?a c�c sinh vi�n, g?m: M� sinh vi�n, Gi?i t�nh, M� 
		-- khoa, M?c h?c b?ng. Trong ?�, m?c h?c b?ng s? hi?n th? l� �H?c b?ng cao� n?u gi� tr? 
		-- c?a h?c b?ng l?n h?n 500,000 v� ng??c l?i hi?n th? l� �M?c trung b�nh�.
SELECT id,gender,faculty_id, CASE 
WHEN scholarship>500000 THEN 'H?c b?ng cao'
ELSE 'M?c trung b�nh'
END AS ScholarshipLevel
FROM student;

-- 2. T�nh t?ng s? sinh vi�n c?a to�n tr??ng
SELECT COUNT(id) AS NumStudent FROM student;

-- 3. T�nh t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n?.
SELECT gender,COUNT(id) FROM student GROUP BY gender;

-- 4. T�nh t?ng s? sinh vi�n t?ng khoa
SELECT faculty_id,COUNT(id) FROM student GROUP BY faculty_id;

-- 5. T�nh t?ng s? sinh vi�n c?a t?ng m�n h?c
SELECT subject_id,count(student_id) FROM exam_management GROUP BY subject_id;

-- 6. T�nh s? l??ng m�n h?c m� sinh vi�n ?� h?c
SELECT st.name,count(ex.subject_id) FROM student st,exam_management ex
WHERE st.id=ex.student_id GROUP BY st.name;

-- 7. T?ng s? h?c b?ng c?a m?i khoa
SELECT f.name ,count(s.scholarship) FROM student s,faculty f
WHERE f.id=s.faculty_id GROUP BY f.name;

-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
SELECT f.name ,MAX(s.scholarship) FROM student s,faculty f
WHERE f.id=s.faculty_id GROUP BY f.name;

-- 9. Cho bi?t t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n? c?a m?i khoa
SELECT f.name,s.gender,COUNT(s.id) FROM student s,faculty f
WHERE f.id=s.faculty_id GROUP BY f.name,s.gender;

-- 10. Cho bi?t s? l??ng sinh vi�n theo t?ng ?? tu?i
SELECT birthday,COUNT(id) FROM student GROUP BY birthday;

-- 11. Cho bi?t nh?ng n?i n�o c� �t nh?t 2 sinh vi�n ?ang theo h?c t?i tr??ng
SELECT hometown FROM student GROUP BY hometown HAVING COUNT(id)>=2; 

-- 12. Cho bi?t nh?ng sinh vi�n thi l?i �t nh?t 2 l?n
SELECT s.name FROM student s,exam_management ex
WHERE s.id=ex.student_id GROUP BY s.name HAVING COUNT(ex.number_of_exam_taking)>=2;

-- 13. Cho bi?t nh?ng sinh vi�n nam c� ?i?m trung b�nh l?n 1 tr�n 7.0
SELECT s.name FROM student s,exam_management ex
WHERE s.id=ex.student_id AND ex.number_of_exam_taking=1 GROUP BY s.name HAVING AVG(ex.mark)>=7;

-- 14. Cho bi?t danh s�ch c�c sinh vi�n r?t �t nh?t 2 m�n ? l?n thi 1 (r?t m�n l� ?i?m thi c?a m�n kh�ng qu� 4 ?i?m)
SELECT s.name FROM student s,exam_management ex
WHERE s.id=ex.student_id AND ex.number_of_exam_taking=1 
AND ex.mark<4 GROUP BY s.name HAVING COUNT(s.id)>=2;

-- 15. Cho bi?t danh s�ch nh?ng khoa c� nhi?u h?n 2 sinh vi�n nam
SELECT f.name FROM faculty f,student s
WHERE f.id=s.faculty_id AND s.gender='Nam' GROUP BY f.name HAVING COUNT(s.id)>2;

-- 16. Cho bi?t nh?ng khoa c� 2 sinh vi�n ??t h?c b?ng t? 200000 ??n 300000
SELECT f.name FROM faculty f,student s
WHERE f.id=s.faculty_id AND s.scholarship>=200000 AND s.scholarship<=300000
GROUP BY f.name HAVING COUNT(s.id)=2;

--17. Cho bi?t sinh vi�n n�o c� h?c b?ng cao nh?t
SELECT name,scholarship FROM student
WHERE scholarship=(SELECT MAX(scholarship) FROM student);

/********* C. DATE/TIME QUERY *********/
-- 1. Sinh vi�n c� n?i sinh ? H� N?i v� sinh v�o th�ng 02

SELECT name FROM student 
WHERE hometown='H� N?i' AND to_char(birthday,'MM')='02';

-- 2. Sinh vi�n c� tu?i l?n h?n 20
SELECT * FROM student
WHERE to_number(to_char(sysdate,'YYYY')) - to_number(to_char(birthday,'YYYY'))>20;

-- 3. Sinh vi�n sinh v�o m�a xu�n n?m 1990
SELECT * FROM student
WHERE to_char(birthday,'MM') in ('01','02','03') AND 
to_char(birthday,'YYYY')='1990';

/********* D. JOIN QUERY *********/

-- 1. Danh s�ch c�c sinh vi�n c?a khoa ANH V?N v� khoa V?T L�
select s.name, f.name
from student s join faculty f on s.faculty_id = f.id
where f.name = 'Anh - V?n' or f.name= 'V?t l�';



-- 2. Nh?ng sinh vi�n nam c?a khoa ANH V?N v� khoa TIN H?C
SELECT s.name,f.name FROM student s join faculty f
on s.faculty_id=f.id
WHERE (f.name = 'Anh - V?n' or  f.name = 'Tin h?c') AND
s.gender= 'Nam' ;

-- 3. Cho bi?t sinh vi�n n�o c� ?i?m thi l?n 1 m�n c? s? d? li?u cao nh?t
SELECT s.name,e.mark FROM student s
JOIN exam_management e ON e.student_id=s.id
WHERE e.subject_id=1 and e.number_of_exam_taking=1
AND e.mark=(SELECT MAX(e.mark) FROM exam_management e
join subject s on s.id =e.subject_id
where e.number_of_exam_taking = 1 and s.id=1);

-- 4. Cho bi?t sinh vi�n khoa anh v?n c� tu?i l?n nh?t.
SELECT s.name,f.name,s.birthday FROM student s
JOIN faculty f ON f.id=s.faculty_id
WHERE f.name='Anh - V?n' AND 
s.birthday=(SELECT MIN(s.birthday) FROM student s
JOIN faculty f ON f.id=s.faculty_id WHERE f.name='Anh - V?n' );





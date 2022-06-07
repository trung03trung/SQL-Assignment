
-- 1. Li?t kê danh sách sinh viên s?p x?p theo theo tên:
select * from student ORDER BY id;
SELECT * FROM student ORDER BY gender;
SELECT * FROM student ORDER BY birthday;
SELECT * FROM student ORDER BY scholarship DESC;

-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
SELECT * FROM subject WHERE name LIKE 'T%';

-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
SELECT * FROM student WHERE name LIKE '%i';

-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
SELECT * FROM faculty WHERE name LIKE '_n%';

-- 5. Sinh viên trong tên có t? 'Th?'
SELECT * FROM student WHERE name LIKE  '%Th?%';

-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên
SELECT * FROM student WHERE name BETWEEN 'A' AND 'M' ORDER BY name;

-- 7. Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n
SELECT * FROM student WHERE scholarship>100000 ORDER BY id DESC;

-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i
SELECT * FROM student WHERE scholarship>=150000 AND hometown='Hà N?i';

-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
SELECT * FROM student WHERE birthday BETWEEN to_date('19910101', 'YYYYMMDD') AND to_date('19920605', 'YYYYMMDD');

-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
SELECT * FROM student WHERE scholarship BETWEEN 80000 AND 150000;

-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
SELECT * FROM subject WHERE lesson_quantity BETWEEN 30 AND 45;


/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã 
		-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.
SELECT id,gender,faculty_id, CASE 
WHEN scholarship>500000 THEN 'H?c b?ng cao'
ELSE 'M?c trung bình'
END AS ScholarshipLevel
FROM student;

-- 2. Tính t?ng s? sinh viên c?a toàn tr??ng
SELECT COUNT(id) AS NumStudent FROM student;

-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
SELECT gender,COUNT(id) FROM student GROUP BY gender;

-- 4. Tính t?ng s? sinh viên t?ng khoa
SELECT faculty_id,COUNT(id) FROM student GROUP BY faculty_id;

-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
SELECT subject_id,count(student_id) FROM exam_management GROUP BY subject_id;

-- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
SELECT st.name,count(ex.subject_id) FROM student st,exam_management ex
WHERE st.id=ex.student_id GROUP BY st.name;

-- 7. T?ng s? h?c b?ng c?a m?i khoa
SELECT f.name ,count(s.scholarship) FROM student s,faculty f
WHERE f.id=s.faculty_id GROUP BY f.name;

-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
SELECT f.name ,MAX(s.scholarship) FROM student s,faculty f
WHERE f.id=s.faculty_id GROUP BY f.name;

-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
SELECT f.name,s.gender,COUNT(s.id) FROM student s,faculty f
WHERE f.id=s.faculty_id GROUP BY f.name,s.gender;

-- 10. Cho bi?t s? l??ng sinh viên theo t?ng ?? tu?i
SELECT birthday,COUNT(id) FROM student GROUP BY birthday;

-- 11. Cho bi?t nh?ng n?i nào có ít nh?t 2 sinh viên ?ang theo h?c t?i tr??ng
SELECT hometown FROM student GROUP BY hometown HAVING COUNT(id)>=2; 

-- 12. Cho bi?t nh?ng sinh viên thi l?i ít nh?t 2 l?n
SELECT s.name FROM student s,exam_management ex
WHERE s.id=ex.student_id GROUP BY s.name HAVING COUNT(ex.number_of_exam_taking)>=2;

-- 13. Cho bi?t nh?ng sinh viên nam có ?i?m trung bình l?n 1 trên 7.0
SELECT s.name FROM student s,exam_management ex
WHERE s.id=ex.student_id AND ex.number_of_exam_taking=1 GROUP BY s.name HAVING AVG(ex.mark)>=7;

-- 14. Cho bi?t danh sách các sinh viên r?t ít nh?t 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)
SELECT s.name FROM student s,exam_management ex
WHERE s.id=ex.student_id AND ex.number_of_exam_taking=1 
AND ex.mark<4 GROUP BY s.name HAVING COUNT(s.id)>=2;

-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam
SELECT f.name FROM faculty f,student s
WHERE f.id=s.faculty_id AND s.gender='Nam' GROUP BY f.name HAVING COUNT(s.id)>2;

-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
SELECT f.name FROM faculty f,student s
WHERE f.id=s.faculty_id AND s.scholarship>=200000 AND s.scholarship<=300000
GROUP BY f.name HAVING COUNT(s.id)=2;

--17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t
SELECT name,scholarship FROM student
WHERE scholarship=(SELECT MAX(scholarship) FROM student);

/********* C. DATE/TIME QUERY *********/
-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02

SELECT name FROM student 
WHERE hometown='Hà N?i' AND to_char(birthday,'MM')='02';

-- 2. Sinh viên có tu?i l?n h?n 20
SELECT * FROM student
WHERE to_number(to_char(sysdate,'YYYY')) - to_number(to_char(birthday,'YYYY'))>20;

-- 3. Sinh viên sinh vào mùa xuân n?m 1990
SELECT * FROM student
WHERE to_char(birthday,'MM') in ('01','02','03') AND 
to_char(birthday,'YYYY')='1990';

/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
select s.name, f.name
from student s join faculty f on s.faculty_id = f.id
where f.name = 'Anh - V?n' or f.name= 'V?t lý';



-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
SELECT s.name,f.name FROM student s join faculty f
on s.faculty_id=f.id
WHERE (f.name = 'Anh - V?n' or  f.name = 'Tin h?c') AND
s.gender= 'Nam' ;

-- 3. Cho bi?t sinh viên nào có ?i?m thi l?n 1 môn c? s? d? li?u cao nh?t
SELECT s.name,e.mark FROM student s
JOIN exam_management e ON e.student_id=s.id
WHERE e.subject_id=1 and e.number_of_exam_taking=1
AND e.mark=(SELECT MAX(e.mark) FROM exam_management e
join subject s on s.id =e.subject_id
where e.number_of_exam_taking = 1 and s.id=1);

-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.
SELECT s.name,f.name,s.birthday FROM student s
JOIN faculty f ON f.id=s.faculty_id
WHERE f.name='Anh - V?n' AND 
s.birthday=(SELECT MIN(s.birthday) FROM student s
JOIN faculty f ON f.id=s.faculty_id WHERE f.name='Anh - V?n' );





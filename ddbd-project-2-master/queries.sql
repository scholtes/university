-- Query 1
SELECT DISTINCT t.tnumber
FROM Teacher AS t, Question AS q
WHERE t.tnumber = q.tnumber
    AND q.type = "T/F";

-- Query 2
SELECT tnumber
FROM Teacher
WHERE tnumber NOT IN
    (SELECT t.tnumber
     FROM Teacher AS t, Question AS q
     WHERE t.tnumber = q.tnumber
        AND q.type = "T/F");

-- Query 3
SELECT DISTINCT t.tnumber
FROM Teacher AS t, Question AS q
WHERE t.tnumber = q.tnumber
    AND t.tnumber NOT IN
    (SELECT t.tnumber
     FROM Teacher AS t, Question AS q
     WHERE t.tnumber = q.tnumber
        AND q.type <> "T/F");

-- Query 4
SELECT e.cnumber, e.`sec-number`, e.eID
FROM Exam AS e, HasQuestion AS hq
WHERE e.eID = hq.eID
GROUP BY e.eID
HAVING min(hq.`point-value`) > 10;

-- Query 5
SELECT q.category, count(*)
FROM Question AS q, Teacher AS t
WHERE t.tnumber = q.tnumber
    AND t.tnumber = 11
GROUP BY q.category;
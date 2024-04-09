CREATE TABLE "Students" (
	"Student_ID"	INTEGER NOT NULL UNIQUE,
	"first_name"	TEXT NOT NULL,
	"last_name"	TEXT NOT NULL,
	"birthday"	NUMERIC NOT NULL,
	PRIMARY KEY("Student_ID","first_name","last_name")
);


CREATE TABLE "Sessions" (
	"Session_ID"	INTEGER NOT NULL,
	"title"	TEXT NOT NULL,
	"date"	NUMERIC NOT NULL,
	PRIMARY KEY("Session_ID")
);

CREATE TABLE "Participation" (
	"Student_ID"	INTEGER NOT NULL,
	"Session_ID"	INTEGER NOT NULL
);

INSERT INTO sessions (Session_ID, TITLE, DATE) VALUES(1, "Setup database", '2023-03-01');
INSERT INTO sessions (Session_ID, TITLE, DATE) VALUES(2, "SQL on database", '2023-03-25');
INSERT INTO sessions (Session_ID, TITLE, DATE) VALUES(3, "Connect R", '2023-03-29');
INSERT INTO students (Student_ID, first_name, last_name, birthday) VALUES(1010,"Smith","Tony", "01-02-2000");
INSERT INTO students (Student_ID, first_name, last_name, birthday) VALUES(2010,"Miller","Jennifer", "02-03-2001");
INSERT INTO students (Student_ID, first_name, last_name, birthday) VALUES(3010,"Adams","Lucy", "05-05-2001");
INSERT INTO Participation (Session_id, Student_id) VALUES(1, 1010);
INSERT INTO Participation (Session_id, Student_id) VALUES(1, 2010);
INSERT INTO Participation (Session_id, Student_id) VALUES(1, 3010);
INSERT INTO Participation (Session_id, Student_id) VALUES(2, 1010);
INSERT INTO Participation (Session_id, Student_id) VALUES(2, 2010);
INSERT INTO Participation (Session_id, Student_id) VALUES(3, 1010);

UPDATE Students
SET first_name = "Antonia"
WHERE Student_ID=1010;

SELECT * FROM sessions;
SELECT * FROM sessions WHERE date(Date) < date('2023-03-29');
SELECT title, Date FROM sessions WHERE date(Date) < date('2023-03-29');

SELECT * FROM sessions AS s
JOIN Participation AS p ON s.Session_ID = p.session_id;

SELECT * FROM Sessions AS s
JOIN Participation AS p ON s.Session_ID = p.session_id
JOIN Students AS st ON p.student_id=st.Student_ID;

SELECT first_name, last_name, COUNT(*) as sessions_taken
FROM
(SELECT st.first_name, st.last_name
FROM sessions AS s
JOIN Participation AS p ON s.Session_ID = p.session_id
JOIN Students AS st ON p.student_id=st.Student_ID)
GROUP BY first_name, last_name
ORDER BY sessions_taken DESC;

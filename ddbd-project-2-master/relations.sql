-- Implement relations
CREATE TABLE Course
    (`cnumber` int, 
     PRIMARY KEY(`cnumber`))
;

CREATE TABLE Teacher
  (`tnumber` int,  
   PRIMARY KEY(`tnumber`))
;
 
CREATE TABLE Student
  (`snumber` int, 
   `lname` varchar(55), 
   PRIMARY KEY(`snumber`))
;
   
CREATE TABLE Attempt
  (`timestamp` varchar(55),
   `attnumber` int,
   `snumber` int,
   PRIMARY KEY(`timestamp`),
   FOREIGN KEY(`snumber`) REFERENCES Student(`snumber`))
;

CREATE TABLE Section
  (`sec-number` int,
   `cnumber` int,
   `tnumber` int,
   PRIMARY KEY(`sec-number`,`cnumber`),
   FOREIGN KEY(`cnumber`) REFERENCES Course(`cnumber`),
   FOREIGN KEY(`tnumber`) REFERENCES Teacher(`tnumber`))
;

CREATE TABLE Enrolls
  (`sec-number` int,
   `cnumber` int,
   `snumber` int,
   PRIMARY KEY (`sec-number`,`cnumber`,`snumber`),
   FOREIGN KEY(`sec-number`,`cnumber`) REFERENCES Section(`sec-number`,`cnumber`),
   FOREIGN KEY(`snumber`) REFERENCES Student(`snumber`))
;

CREATE TABLE Exam
  (`eID` int,
   `tnumber` int,
   `sec-number` int,
   `cnumber` int,
   PRIMARY KEY(`eID`),
   FOREIGN KEY(`tnumber`) REFERENCES Teacher(`tnumber`),
   FOREIGN KEY(`cnumber`,`sec-number`) REFERENCES Section(`cnumber`,`sec-number`))
;

CREATE TABLE Question
  (`qID` int,
   `tnumber` int,
   `type` varchar(55),
   `qtext` varchar(140),
   `category` varchar(55),
   PRIMARY KEY(`qID`),
   FOREIGN KEY(`tnumber`) REFERENCES Teacher(`tnumber`))
;

CREATE TABLE HasQuestion 
  (`eID` int,
   `qID` int, 
   `point-value` int,
   PRIMARY KEY(`eID`,`qID`),
   FOREIGN KEY(`eID`) REFERENCES Exam(`eID`),
   FOREIGN KEY(`qID`) REFERENCES Question(`qID`))
;

CREATE TABLE Answer
  (`ans-number` int,
   `correct?` boolean,
   `qID` int,
   `ans-text` varchar(160),
   PRIMARY KEY(`ans-number`,`qID`),
   FOREIGN KEY(`qID`) REFERENCES Question(`qID`))
;

CREATE TABLE Answers
  (`eId` int, 
   `timestamp` varchar(55),
   `ans-number` int,
   `qID` int,
   PRIMARY KEY(`eID`,`timestamp`,`ans-number`,`qID`),
   FOREIGN KEY(`qID`,`ans-number`) REFERENCES Answer(`qID`,`ans-number`),
   FOREIGN KEY(`eID`) REFERENCES Exam(`eID`),
   FOREIGN KEY(`timestamp`) REFERENCES Attempt(`timestamp`))
;

-- Populate relations

INSERT INTO Course
    (`cnumber`)
VALUES
    (1001),(1002),(1003),(1004),(1005),(1006),(1007),(1008),(1009)
;

INSERT INTO Teacher
    (`tnumber`)
VALUES
    (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11)
;

INSERT INTO Section
    (`sec-number`,`cnumber`,`tnumber`)
Values
  (101,1001,1),
  (103,1001,2),
  (102,1001,6),
  (201,1002,3),
  (407,1004,9),
  (906,1009,11)
;


INSERT INTO Student
  (`snumber`,`lname`)
VALUES
  (999,"Meeks"),
  (998,"Scholtes"),
  (997,"Davis"),
  (996,"Ono"),
  (995,"Cooper"),
  (994,"Daniels"),
  (993,"Kirk"),
  (992,"Obama"),
  (991,"Codd")
;

INSERT INTO Exam
  (`eID`,`sec-number`, `cnumber`, `tnumber`)
VALUES
  (1234,101,1001,1),
  (1235,103,1001,2),
  (1236,102,1001,6),
  (1237,201,1002,3),
  (1238,407,1004,9),
  (1239,906,1009,11),
  (1233,407,1004,9)
;

INSERT INTO Question
  (`qID`,`tnumber`,`type`,`qtext`,`category`)
VALUES
  (1,11,"T/F","2+2=4","Math"),
  (2,11,"T/F","The sun is a star.","Astronomy"),
  (3,11,"T/F","Neo fiddled while Rome burned","History"),
  (4,11,"T/F","A group of Jellyfish is call a smack","Biology"),
  (5,11,"T/F","Purple is a Primary Color.","Art"),
  (6,11,"T/F","A Square has the largest area of any quadrilateral with the same perimeter.","Math"),
  (7,10,"T/F","Pi is exactly equal to 3.14","Math"),
  (8,10,"T/F",".9999 repeating is equal to 1","Math"),
  (9,10,"Single Answer","What planet do we live on?","Astronomy"),
  (10,9,"T/F","TARDIS stand for Time and reletive demension in space","Pop Culture"),
  (11,8,"T/F","Christmas is on Dec 20","Dates"),
  (12,7,"T/F","A spider is an insect","Biology"),
  (13,6,"T/F","UC is the #hottestcollegeinAmerica","General Knowledge")
 ;

INSERT INTO HasQuestion
  (`qID`,`eID`,`point-value`)
VALUES
  (1,1234,5),
  (2,1234,0),
  (3,1234,11),
  (4,1235,11),
  (5,1236,12),
  (9,1237,90),
  (11,1238,50),
  (7,1239,75)
;
DROP TABLE IF EXISTS class_lessons;
DROP TABLE IF EXISTS student_classes;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS lessons;

CREATE TABLE students (
  student_id VARCHAR(10) PRIMARY KEY NOT NULL,
  firstName VARCHAR(20) NOT NULL,
  lastName VARCHAR(20) NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastUpdate TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE classes (
  class_id VARCHAR(10) PRIMARY KEY NOT NULL,
  name VARCHAR(20) NOT NULL,
  period VARCHAR(20) NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastUpdate TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lessons (
  lesson_id VARCHAR(10) PRIMARY KEY NOT NULL,
  name VARCHAR(20) NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastUpdate TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE student_classes (
  student_id VARCHAR(10) NOT NULL,
  class_id VARCHAR(10) NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastUpdate TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (student_id, class_id),
  FOREIGN KEY (student_id) REFERENCES students (student_id),
  FOREIGN KEY (class_id) REFERENCES classes (class_id)
);

CREATE TABLE class_lessons (
  class_id VARCHAR(10) NOT NULL,
  lesson_id VARCHAR(10) NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastUpdate TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (class_id, lesson_id),
  FOREIGN KEY (class_id) REFERENCES classes (class_id),
  FOREIGN KEY (lesson_id) REFERENCES lessons (lesson_id)
);

INSERT INTO students (student_id, firstName, lastName) VALUES
  ('User 1', 'Kevin', 'Parker'),
  ('User 2', 'Steven', 'Tray'),
  ('User 3', 'Brittany', 'Chase'),
  ('User 4', 'Jessica', 'Smith');

INSERT INTO classes (class_id, name, period) VALUES
  ('Class 1', 'Math', 'Period 2'),
  ('Class 2', 'English', 'Period 4'),
  ('Class 3', 'Science', 'Period 5');

INSERT INTO lessons (lesson_id, name) VALUES
  ('Lesson 1', 'Intro'),
  ('Lesson 2', 'Geometry'),
  ('Lesson 3', 'Physics'),
  ('Lesson 4', 'British Literature'),
  ('Lesson 5', 'Algebra');

INSERT INTO student_classes (student_id, class_id) VALUES
  ('User 1', 'Class 2'),
  ('User 1', 'Class 3'),
  ('User 2', 'Class 1'),
  ('User 2', 'Class 3'),
  ('User 3', 'Class 1'),
  ('User 3', 'Class 2'),
  ('User 3', 'Class 3'),
  ('User 4', 'Class 1'),
  ('User 4', 'Class 2');

INSERT INTO class_lessons (class_id, lesson_id) VALUES
  ('Class 1', 'Lesson 1'),
  ('Class 1', 'Lesson 2'),
  ('Class 1', 'Lesson 5'),
  ('Class 2', 'Lesson 1'),
  ('Class 2', 'Lesson 4'),
  ('Class 3', 'Lesson 1'),
  ('Class 3', 'Lesson 5'),
  ('Class 3', 'Lesson 3');

SELECT name FROM lessons
  LEFT JOIN class_lessons ON lessons.lesson_id = class_lessons.lesson_id
  LEFT JOIN student_classes ON class_lessons.class_id = student_classes.class_id
  WHERE student_id='User 1';

SELECT student_id FROM student_classes 
  LEFT JOIN classes ON student_classes.class_id = classes.class_id
  WHERE period='Period 5';

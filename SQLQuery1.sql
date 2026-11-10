-- users, courses, lessons and enrollments tables
CREATE TABLE Users (
  UserId   INT IDENTITY PRIMARY KEY,
  FullName NVARCHAR(100) NOT NULL,
  Email    NVARCHAR(100) NOT NULL UNIQUE,
  Password NVARCHAR(200) NOT NULL,
  Role     NVARCHAR(10)  NOT NULL              -- 'Member' or 'Admin'
);

CREATE TABLE Courses (
  CourseId    INT IDENTITY PRIMARY KEY,
  Title       NVARCHAR(100) NOT NULL,
  Category    NVARCHAR(50)  NOT NULL,
  Description NVARCHAR(500),
  Image       NVARCHAR(100)
);

CREATE TABLE Lessons (
  LessonId INT IDENTITY PRIMARY KEY,
  CourseId INT NOT NULL REFERENCES Courses(CourseId),
  Title   NVARCHAR(100) NOT NULL,
  Content  NVARCHAR(MAX)
);

CREATE TABLE Enrollments (
  EnrollmentId INT IDENTITY PRIMARY KEY,
  UserId   INT NOT NULL REFERENCES Users(UserId),
  CourseId INT NOT NULL REFERENCES Courses(CourseId),
  Progress INT NOT NULL                                 -- 0 to 100
);
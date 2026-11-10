-- last lesson opened, for continue learning
ALTER TABLE Enrollments ADD LastLessonId INT NULL;
GO
ALTER TABLE Enrollments ADD LastVisited DATETIME NULL;
GO

SELECT EnrollmentId, UserId, CourseId, Progress, LastLessonId, LastVisited FROM Enrollments;

-- youtube video for lessons
ALTER TABLE Lessons ADD VideoUrl NVARCHAR(300) NULL;
GO

SELECT LessonId, Title, VideoUrl FROM Lessons;

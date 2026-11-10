-- PDF reading path for lessons
ALTER TABLE Lessons ADD ReadingFile NVARCHAR(200) NULL;
GO

SELECT LessonId, Title, ReadingFile FROM Lessons;

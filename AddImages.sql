-- image column for lessons
ALTER TABLE Lessons ADD Image NVARCHAR(100) NULL;
GO

-- course images
UPDATE Courses SET Image = N'images/business-model-canvas.webp' WHERE Title = N'Business Model Canvas & Value Proposition';
UPDATE Courses SET Image = N'images/startup-funding.png'        WHERE Title = N'Startup Funding & Pitching';
UPDATE Courses SET Image = N'images/customer-discovery.webp'    WHERE Title = N'Customer Discovery & Market Validation';

-- lesson images
UPDATE Lessons SET Image = N'images/funding-rounds.webp' WHERE Title = N'Venture capital and funding rounds';
UPDATE Lessons SET Image = N'images/pitch-deck.webp'     WHERE Title = N'Building a pitch deck';
UPDATE Lessons SET Image = N'images/market-sizing.png'   WHERE Title = N'Sizing your market: TAM, SAM and SOM';

SELECT CourseId, Title, Image FROM Courses WHERE CourseId > 5;
SELECT LessonId, Title, Image FROM Lessons WHERE Image IS NOT NULL;

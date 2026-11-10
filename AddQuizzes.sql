-- quiz tables

CREATE TABLE Questions (
  QuestionId    INT IDENTITY PRIMARY KEY,
  CourseId      INT NOT NULL REFERENCES Courses(CourseId),
  QuestionText  NVARCHAR(500) NOT NULL,
  OptionA       NVARCHAR(200) NOT NULL,
  OptionB       NVARCHAR(200) NOT NULL,
  OptionC       NVARCHAR(200) NOT NULL,
  OptionD       NVARCHAR(200) NOT NULL,
  CorrectAnswer CHAR(1) NOT NULL CHECK (CorrectAnswer IN ('A', 'B', 'C', 'D'))
);
GO

CREATE TABLE QuizAttempts (
  AttemptId INT IDENTITY PRIMARY KEY,
  UserId    INT NOT NULL REFERENCES Users(UserId),
  CourseId  INT NOT NULL REFERENCES Courses(CourseId),
  Score     INT NOT NULL,                        -- correct answers
  Total     INT NOT NULL,
  TakenOn   DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- quiz questions, 5 per course
DECLARE @c INT;

SELECT @c = CourseId FROM Courses WHERE Title = N'Introduction to Venture Building';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'Which type of business is built on an innovation and aims for fast growth in global markets?',
 N'A small and medium enterprise (SME)', N'An innovation-driven enterprise (IDE)', N'A sole proprietorship serving one town', N'A franchise of an existing brand', 'B'),
(@c, N'Which statement best describes a typical SME?',
 N'It serves local markets with a traditional business idea and grows steadily', N'It always needs venture capital before it can start', N'It must own at least one patent', N'It aims to sell to customers all over the world from day one', 'A'),
(@c, N'What is the feedback loop at the heart of the Lean Startup method?',
 N'Plan, do, check, act', N'Design, test, launch', N'Build, measure, learn', N'Research, develop, sell', 'C'),
(@c, N'How many steps does MIT''s Disciplined Entrepreneurship framework contain?',
 N'9', N'12', N'50', N'24', 'D'),
(@c, N'What is a minimum viable product (MVP)?',
 N'The simplest version of a product that lets you start learning from real customers', N'The cheapest product on the market', N'A finished product with every planned feature', N'A product that only investors can use', 'A');

SELECT @c = CourseId FROM Courses WHERE Title = N'Managing IP & Commercialisation';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'How long does patent protection usually last?',
 N'5 years', N'10 years', N'20 years', N'For as long as the inventor is alive', 'C'),
(@c, N'Which type of IP protects a brand name or logo?',
 N'Trademark', N'Patent', N'Copyright', N'Registered design', 'A'),
(@c, N'Which three conditions must an invention meet to be patentable?',
 N'It must be cheap, popular and useful', N'Novelty, inventive step and industrial application', N'It must be registered, advertised and sold', N'It must be written, signed and published', 'B'),
(@c, N'A company keeps its recipe confidential and never registers it. Which type of IP protects it?',
 N'Copyright', N'Patent', N'Trademark', N'Trade secret', 'D'),
(@c, N'What does copyright protect?',
 N'Ideas and inventions', N'Original creative works such as books, music and software code', N'Company names and logos', N'The shape of a product', 'B');

SELECT @c = CourseId FROM Courses WHERE Title = N'Technology Transfer in Innovation';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'What does technology transfer mean?',
 N'Moving computers from one office to another', N'Selling second-hand equipment', N'Moving knowledge and inventions from research organisations to industry and the market', N'Copying another company''s product', 'C'),
(@c, N'In a licensing deal, the owner of the IP...',
 N'Lets another company use the IP in exchange for fees or royalties', N'Gives the IP away for free', N'Sells the whole university to the company', N'Loses the right to ever use the IP again', 'A'),
(@c, N'What is a university spin-out?',
 N'A student club for entrepreneurs', N'A new company created to commercialise research from the university', N'A department that closes down', N'A type of research grant', 'B'),
(@c, N'What does TTO stand for?',
 N'Total Technology Output', N'Trade and Tax Office', N'Technical Training Organisation', N'Technology Transfer Office', 'D'),
(@c, N'What is the "Not Invented Here" (NIH) syndrome?',
 N'Reluctance to use ideas or technology that come from outside the organisation', N'A rule that bans imported products', N'A disease found in laboratories', N'A patent that has expired', 'A');

SELECT @c = CourseId FROM Courses WHERE Title = N'Business Model Canvas & Value Proposition';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'How many building blocks does the Business Model Canvas have?',
 N'5', N'7', N'9', N'12', 'C'),
(@c, N'Which building block describes how the business earns money from each customer segment?',
 N'Key Activities', N'Revenue Streams', N'Channels', N'Key Partnerships', 'B'),
(@c, N'What is a value proposition?',
 N'The bundle of products and services that creates value for a customer segment', N'The price of the company''s shares', N'The list of the company''s suppliers', N'The total cost of running the business', 'A'),
(@c, N'Who created the Business Model Canvas?',
 N'Eric Ries and Steve Blank', N'Bill Aulet and Fiona Murray', N'Michael Porter', N'Alexander Osterwalder and Yves Pigneur', 'D'),
(@c, N'Which building block describes how a company reaches and delivers value to its customers?',
 N'Channels', N'Cost Structure', N'Key Resources', N'Customer Segments', 'A');

SELECT @c = CourseId FROM Courses WHERE Title = N'Startup Funding & Pitching';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'What is bootstrapping?',
 N'Borrowing money from a bank', N'Funding the startup from the founders'' own savings and early revenue', N'Selling the company to a competitor', N'Getting a government grant', 'B'),
(@c, N'What happens to a founder''s ownership when new shares are issued to investors?',
 N'It goes up', N'It stays exactly the same', N'Their percentage goes down (dilution)', N'It is converted into a loan', 'C'),
(@c, N'Venture capital firms usually...',
 N'Invest in high-growth startups in exchange for equity', N'Give loans that must be repaid each month', N'Only fund small local shops', N'Donate money without expecting anything back', 'A'),
(@c, N'Who are angel investors?',
 N'Government officers who approve grants', N'Banks that lend to large companies', N'Customers who pre-order a product', N'Wealthy individuals who invest their own money in early-stage startups', 'D'),
(@c, N'What is the main purpose of a pitch deck?',
 N'To list every expense of the company', N'A short presentation that explains the business to investors', N'A legal contract between founders', N'A marketing flyer for customers', 'B');

SELECT @c = CourseId FROM Courses WHERE Title = N'Customer Discovery & Market Validation';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'What is the first step of Steve Blank''s customer development process?',
 N'Company building', N'Customer creation', N'Customer validation', N'Customer discovery', 'D'),
(@c, N'What makes a good startup hypothesis?',
 N'It is specific and can be tested with real customers', N'It is a long description of the product', N'It can never be proven wrong', N'It is agreed by all the founders', 'A'),
(@c, N'During a customer interview, you should mainly...',
 N'Pitch your product as much as possible', N'Ask customers to invest in your startup', N'Ask about their past behaviour and the problems they face', N'Only ask yes-or-no questions', 'C'),
(@c, N'In market sizing, what does TAM stand for?',
 N'Total Addressable Market', N'Target Advertising Method', N'Total Annual Margin', N'Tested Audience Model', 'A'),
(@c, N'Product-market fit means...',
 N'The product has the lowest price in the market', N'The product satisfies a strong market demand and customers keep coming back', N'The product fits on a single page', N'The company has hired a marketing team', 'B');

-- questions from the old lesson quizzes
SELECT @c = CourseId FROM Courses WHERE Title = N'Introduction to Venture Building';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'According to Sarasvathy, when the future is uncertain, entrepreneurs usually...',
 N'Wait until they have a perfect plan', N'Act, take small steps and learn from them', N'Avoid all risk', N'Copy what large companies do', 'B');

SELECT @c = CourseId FROM Courses WHERE Title = N'Managing IP & Commercialisation';
INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(@c, N'Penicillin itself was not patentable because it was...',
 N'Too expensive to produce', N'A discovery, not an invention', N'Already trademarked', N'Only sold in hospitals', 'B');

-- update patents lesson text
UPDATE Lessons
SET Content = REPLACE(Content,
    N'When you are ready, answer the questions below and click "Check answers" to see your score. If you get one wrong, look back at lessons 3 to 5 of this course.',
    N'When you finish the course, test yourself with the course quiz (the button after the last lesson, or on My Learning). If you get a patent question wrong, look back at lessons 3 to 5 of this course.')
WHERE Title = N'Patents self-assessment';

UPDATE Lessons
SET Content = REPLACE(Content,
    N'This lesson checks what you have learned about patents so far. Read the quick recap, then try the quiz below.',
    N'This lesson checks what you have learned about patents so far. Read the quick recap and make sure you can explain each point.')
WHERE Title = N'Patents self-assessment';

SELECT Courses.Title, COUNT(Questions.QuestionId) AS Questions
FROM Courses LEFT JOIN Questions ON Questions.CourseId = Courses.CourseId
GROUP BY Courses.Title;

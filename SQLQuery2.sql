-- first 3 courses
INSERT INTO Courses (Title, Category, Description, Image) VALUES
(N'Introduction to Venture Building', N'Venture',
 N'Startups vs. SMEs, innovation-driven enterprises, the entrepreneur mindset, and the Lean Startup vs. MIT Disciplined Entrepreneurship approaches.',
 N'images/venture.jpg'),
(N'Managing IP & Commercialisation', N'Intellectual Property',
 N'Patents, copyright, registered designs, trademarks and trade secrets — and the routes to commercialise your innovation.',
 N'images/ip.jpg'),
(N'Technology Transfer in Innovation', N'Technology',
 N'How knowledge flows from labs to market: licensing, science parks, KTPs and TTOs.',
 N'images/tech-transfer.jpg');

-- Course 1: Venture Building (9 lessons)
INSERT INTO Lessons (CourseId, Title) VALUES
(1, N'What is a startup? What is an SME?'),
(1, N'Startups vs. SMEs compared'),
(1, N'IDEs and why they matter for growth'),
(1, N'Case study: lab idea to scale-up'),
(1, N'How entrepreneurs think'),
(1, N'Mindset self-assessment'),
(1, N'Lean Startup: build, measure, learn'),
(1, N'MIT’s 24 steps'),
(1, N'Which approach fits your venture?');

-- Course 2: IP (11 lessons)
INSERT INTO Lessons (CourseId, Title) VALUES
(2, N'What is IP? Types of protection'),
(2, N'Overview of the main types of IP'),
(2, N'Patents: the 20-year monopoly'),
(2, N'Novelty, inventive step & industrial application'),
(2, N'Why firms patent / patents deter innovation'),
(2, N'Patents self-assessment'),
(2, N'Trademarks Act & brand names'),
(2, N'Copyright categories & remedies'),
(2, N'Protecting trade secrets'),
(2, N'Routes to commercialisation'),
(2, N'Licensing case study');

-- Course 3: Technology Transfer (10 lessons)
INSERT INTO Lessons (CourseId, Title) VALUES
(3, N'From lab to market'),
(3, N'Key terms in technology transfer'),
(3, N'Licensing vs. spin-outs'),
(3, N'Science parks and incubators'),
(3, N'Routes to market self-assessment'),
(3, N'Knowledge Transfer Partnerships'),
(3, N'Inside a TTO'),
(3, N'Open innovation explained'),
(3, N'The NIH syndrome'),
(3, N'Case study: a licensing deal');

# Capital Craft

A learning website about building and launching ventures. Members can sign up, enrol in courses, read the lessons and take a quiz for each course. Admins can manage courses, lessons, quiz questions and users.

Made for the **CT050-3-2-WAPP Web Applications** group assignment.

## Built With

- ASP.NET Web Forms (C#, .NET Framework 4.8)
- SQL Server LocalDB
- HTML, CSS and JavaScript
- Visual Studio 2022

## Features

- **Visitors:** browse courses, register and log in
- **Members:** enrol in courses, read lessons, take quizzes, track progress in My Learning, edit profile
- **Admins:** dashboard, plus add, edit and delete courses, lessons, quiz questions and users

## How to Run

1. Open `CapitalCraft.sln` in Visual Studio 2022.
2. The database file is not included in this repo. Create an empty LocalDB database named `CapitalCraft.mdf` in `CapitalCraft/App_Data/`, then run the scripts in this order:
   1. `SQLQuery1.sql` (creates the tables)
   2. `SQLQuery2.sql` and `AddMoreCourses.sql` (courses and lessons)
   3. `AddQuizzes.sql`
   4. `AddImages.sql`, `AddReadings.sql`, `AddVideos.sql`, `AddContinueLearning.sql`
3. Press **F5** to run the site.
4. Register an account. To make it an admin, run:
   `UPDATE Users SET Role = 'Admin' WHERE Email = 'your@email.com';`

## Team

- Roshni K. Shah
- Saanvi Shrestha
- Sadiksha Timsina
- Shirsha Bhandari

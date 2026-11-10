using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace CapitalCraft.member
{
    public partial class Dashboard : System.Web.UI.Page
    {
        const int PassMark = 60;

        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this);

            lblName.Text = Session["Name"].ToString();

            using (SqlConnection con = Db.Open())
            {
                // get enrolled courses with progress
                SqlCommand getCourses = new SqlCommand(
                    "SELECT Courses.CourseId, Courses.Title, Enrollments.Progress, Enrollments.LastLessonId " +
                    "FROM Enrollments JOIN Courses ON Courses.CourseId = Enrollments.CourseId " +
                    "WHERE Enrollments.UserId = @user " +
                    "ORDER BY Enrollments.LastVisited DESC, Courses.Title", con);
                getCourses.Parameters.AddWithValue("@user", Session["UserId"]);

                DataTable courses = new DataTable();
                new SqlDataAdapter(getCourses).Fill(courses);

                // lessons, questions and best quiz score for each course
                courses.Columns.Add("LessonCount", typeof(int));
                courses.Columns.Add("QuestionCount", typeof(int));
                courses.Columns.Add("BestQuiz", typeof(int));

                foreach (DataRow row in courses.Rows)
                {
                    SqlCommand lessons = new SqlCommand("SELECT COUNT(*) FROM Lessons WHERE CourseId = @course", con);
                    lessons.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["LessonCount"] = lessons.ExecuteScalar();

                    SqlCommand questions = new SqlCommand("SELECT COUNT(*) FROM Questions WHERE CourseId = @course", con);
                    questions.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["QuestionCount"] = questions.ExecuteScalar();

                    SqlCommand best = new SqlCommand(
                        "SELECT MAX(Score * 100 / Total) FROM QuizAttempts WHERE UserId = @user AND CourseId = @course", con);
                    best.Parameters.AddWithValue("@user", Session["UserId"]);
                    best.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["BestQuiz"] = best.ExecuteScalar();
                }

                rptProgress.DataSource = courses;
                rptProgress.DataBind();

                // stats at the top
                int lessonsDone = 0, finished = 0, passed = 0;
                foreach (DataRow row in courses.Rows)
                {
                    lessonsDone += LessonsDone(row["Progress"], row["LessonCount"]);
                    if ((int)row["Progress"] >= 100) finished++;
                    if (row["BestQuiz"] != DBNull.Value && (int)row["BestQuiz"] >= PassMark) passed++;
                }
                lblCourses.Text = courses.Rows.Count.ToString();
                lblLessonsDone.Text = lessonsDone.ToString();
                lblFinished.Text = finished.ToString();
                lblQuizzesPassed.Text = passed.ToString();

                if (courses.Rows.Count == 0)
                {
                    pnlContinue.Visible = false;
                    pnlNoCourses.Visible = true;
                    phProgress.Visible = false;
                }
                else
                {
                    ShowContinue(con);
                }

                // last 5 quiz attempts
                SqlCommand getQuizzes = new SqlCommand(
                    "SELECT TOP 5 Courses.Title, QuizAttempts.Score, QuizAttempts.Total, " +
                    "  QuizAttempts.Score * 100 / QuizAttempts.Total AS [Percent], QuizAttempts.TakenOn " +
                    "FROM QuizAttempts JOIN Courses ON Courses.CourseId = QuizAttempts.CourseId " +
                    "WHERE QuizAttempts.UserId = @user ORDER BY QuizAttempts.TakenOn DESC, QuizAttempts.AttemptId DESC", con);
                getQuizzes.Parameters.AddWithValue("@user", Session["UserId"]);

                DataTable quizzes = new DataTable();
                new SqlDataAdapter(getQuizzes).Fill(quizzes);
                rptQuizzes.DataSource = quizzes;
                rptQuizzes.DataBind();
                rptQuizzes.Visible = quizzes.Rows.Count > 0;
                lblNoQuizzes.Visible = quizzes.Rows.Count == 0;
            }
        }

        // continue where you left off
        private void ShowContinue(SqlConnection con)
        {
            SqlCommand last = new SqlCommand(
                "SELECT TOP 1 Lessons.LessonId, Lessons.Title AS LessonTitle, Courses.Title AS CourseTitle, Enrollments.Progress " +
                "FROM Enrollments " +
                "JOIN Lessons ON Lessons.LessonId = Enrollments.LastLessonId " +
                "JOIN Courses ON Courses.CourseId = Enrollments.CourseId " +
                "WHERE Enrollments.UserId = @user AND Enrollments.LastVisited IS NOT NULL " +
                "ORDER BY Enrollments.LastVisited DESC", con);
            last.Parameters.AddWithValue("@user", Session["UserId"]);

            using (SqlDataReader reader = last.ExecuteReader())
            {
                if (reader.Read())
                {
                    lblContinueHint.Text = "Continue where you left off";
                    lblContinueLesson.Text = Server.HtmlEncode(reader["LessonTitle"].ToString());
                    lblContinueCourse.Text = Server.HtmlEncode(reader["CourseTitle"].ToString()) + " · " + reader["Progress"] + "% complete";
                    lnkContinue.NavigateUrl = "/pages/Lesson.aspx?id=" + reader["LessonId"];
                    return;
                }
            }

            // no lesson opened yet so use first lesson
            SqlCommand newest = new SqlCommand(
                "SELECT TOP 1 Courses.CourseId, Courses.Title FROM Enrollments " +
                "JOIN Courses ON Courses.CourseId = Enrollments.CourseId " +
                "WHERE Enrollments.UserId = @user ORDER BY Enrollments.EnrollmentId DESC", con);
            newest.Parameters.AddWithValue("@user", Session["UserId"]);

            int courseId;
            using (SqlDataReader reader = newest.ExecuteReader())
            {
                reader.Read();
                courseId = (int)reader["CourseId"];
                lblContinueHint.Text = "Ready to start";
                lblContinueLesson.Text = Server.HtmlEncode(reader["Title"].ToString());
                lblContinueCourse.Text = "You haven't opened a lesson yet. Start with lesson 1.";
            }

            SqlCommand first = new SqlCommand("SELECT MIN(LessonId) FROM Lessons WHERE CourseId = @course", con);
            first.Parameters.AddWithValue("@course", courseId);
            object firstLesson = first.ExecuteScalar();

            if (firstLesson == DBNull.Value)
            {
                lnkContinue.Visible = false;
            }
            else
            {
                lnkContinue.Text = "Start course →";
                lnkContinue.NavigateUrl = "/pages/Lesson.aspx?id=" + firstLesson;
            }
        }

        protected int LessonsDone(object progress, object lessonCount)
        {
            return (int)Math.Round((int)progress * (int)lessonCount / 100.0);
        }

        protected string QuizStatus(object bestQuiz, object questionCount)
        {
            if ((int)questionCount == 0)
            {
                return "No quiz yet";
            }
            if (bestQuiz == DBNull.Value)
            {
                return "Not taken";
            }
            int best = (int)bestQuiz;
            return best >= PassMark
                ? "<span class='tag tag-green'>✓ Passed · " + best + "%</span>"
                : "<span class='tag tag-yellow'>Best " + best + "%</span>";
        }

        protected string ContinueUrl(object courseId, object lastLessonId)
        {
            return lastLessonId == DBNull.Value
                ? "/pages/CourseDetail.aspx?id=" + courseId
                : "/pages/Lesson.aspx?id=" + lastLessonId;
        }
    }
}

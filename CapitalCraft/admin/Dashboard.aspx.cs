using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace CapitalCraft.admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        const int PassMark = 60;
        int mostEnrolled = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            using (SqlConnection con = Db.Open())
            {
                // totals
                lblUsers.Text = new SqlCommand("SELECT COUNT(*) FROM Users", con).ExecuteScalar().ToString();
                lblCourses.Text = new SqlCommand("SELECT COUNT(*) FROM Courses", con).ExecuteScalar().ToString();
                lblLessons.Text = new SqlCommand("SELECT COUNT(*) FROM Lessons", con).ExecuteScalar().ToString();
                lblEnrolments.Text = new SqlCommand("SELECT COUNT(*) FROM Enrollments", con).ExecuteScalar().ToString();

                // enrolments per course
                SqlCommand getEnrolments = new SqlCommand(
                    "SELECT Courses.Title, COUNT(Enrollments.EnrollmentId) AS Enrolled " +
                    "FROM Courses LEFT JOIN Enrollments ON Enrollments.CourseId = Courses.CourseId " +
                    "GROUP BY Courses.CourseId, Courses.Title " +
                    "ORDER BY Enrolled DESC, Courses.Title", con);

                DataTable enrolments = new DataTable();
                new SqlDataAdapter(getEnrolments).Fill(enrolments);
                foreach (DataRow row in enrolments.Rows)
                {
                    mostEnrolled = Math.Max(mostEnrolled, (int)row["Enrolled"]);
                }
                rptEnrolments.DataSource = enrolments;
                rptEnrolments.DataBind();

                // quiz stats per course
                SqlCommand getCourses = new SqlCommand("SELECT CourseId, Title FROM Courses ORDER BY CourseId", con);
                DataTable quizzes = new DataTable();
                new SqlDataAdapter(getCourses).Fill(quizzes);

                quizzes.Columns.Add("QuestionCount", typeof(int));
                quizzes.Columns.Add("Attempts", typeof(int));
                quizzes.Columns.Add("AvgScore", typeof(double));
                quizzes.Columns.Add("Tried", typeof(int));
                quizzes.Columns.Add("Passed", typeof(int));

                foreach (DataRow row in quizzes.Rows)
                {
                    SqlCommand questions = new SqlCommand("SELECT COUNT(*) FROM Questions WHERE CourseId = @course", con);
                    questions.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["QuestionCount"] = questions.ExecuteScalar();

                    SqlCommand getAttempts = new SqlCommand("SELECT UserId, Score, Total FROM QuizAttempts WHERE CourseId = @course", con);
                    getAttempts.Parameters.AddWithValue("@course", row["CourseId"]);
                    DataTable attempts = new DataTable();
                    new SqlDataAdapter(getAttempts).Fill(attempts);

                    // best score of each member who took this quiz
                    Dictionary<int, int> best = new Dictionary<int, int>();
                    double totalPercent = 0;

                    foreach (DataRow attempt in attempts.Rows)
                    {
                        int userId = (int)attempt["UserId"];
                        int score = (int)attempt["Score"];
                        int total = (int)attempt["Total"];
                        totalPercent += score * 100.0 / total;

                        if (!best.ContainsKey(userId) || score * 100 / total > best[userId])
                        {
                            best[userId] = score * 100 / total;
                        }
                    }

                    int passed = 0;
                    foreach (int percent in best.Values)
                    {
                        if (percent >= PassMark)
                        {
                            passed++;
                        }
                    }

                    row["Attempts"] = attempts.Rows.Count;
                    row["Tried"] = best.Count;
                    row["Passed"] = passed;
                    if (attempts.Rows.Count > 0)
                    {
                        row["AvgScore"] = totalPercent / attempts.Rows.Count;
                    }
                }

                rptQuizzes.DataSource = quizzes;
                rptQuizzes.DataBind();
            }
        }

        // bar width for the chart
        protected int BarWidth(object enrolled)
        {
            if (mostEnrolled == 0)
            {
                return 0;
            }
            return (int)Math.Round((int)enrolled * 100.0 / mostEnrolled);
        }

        protected string PassRate(object passed, object tried)
        {
            if ((int)tried == 0)
            {
                return "<span class='grey-text small-text'>No attempts yet</span>";
            }
            int rate = (int)Math.Round((int)passed * 100.0 / (int)tried);
            return "<span class='bar-track small'><span class='bar-fill' style='width: " + rate + "%;'></span></span> " + rate + "%";
        }
    }
}

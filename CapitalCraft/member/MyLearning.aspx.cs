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
    public partial class MyLearning : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this);

            if (!IsPostBack)
            {
                ShowMyCourses();
            }
        }

        private void ShowMyCourses()
        {
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT Courses.CourseId, Courses.Title, Courses.Image, Enrollments.Progress " +
                    "FROM Enrollments JOIN Courses ON Courses.CourseId = Enrollments.CourseId " +
                    "WHERE Enrollments.UserId = @user ORDER BY Enrollments.EnrollmentId", con);
                cmd.Parameters.AddWithValue("@user", Session["UserId"]);

                DataTable myCourses = new DataTable();
                new SqlDataAdapter(cmd).Fill(myCourses);

                // best quiz score for each course
                myCourses.Columns.Add("BestQuiz", typeof(int));
                foreach (DataRow row in myCourses.Rows)
                {
                    SqlCommand best = new SqlCommand(
                        "SELECT MAX(Score * 100 / Total) FROM QuizAttempts WHERE UserId = @user AND CourseId = @course", con);
                    best.Parameters.AddWithValue("@user", Session["UserId"]);
                    best.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["BestQuiz"] = best.ExecuteScalar();
                }

                rptMyCourses.DataSource = myCourses;
                rptMyCourses.DataBind();

                if (myCourses.Rows.Count == 0)
                {
                    lblMessage.Text = "You haven't enrolled in any courses yet. <a href='/pages/Courses.aspx'>Browse courses</a>";
                }
            }
        }

        protected void rptMyCourses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Unenrol")
            {
                int courseId = int.Parse(e.CommandArgument.ToString());

                using (SqlConnection con = Db.Open())
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Enrollments WHERE UserId = @user AND CourseId = @course", con);
                    cmd.Parameters.AddWithValue("@user", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@course", courseId);
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "You have been unenrolled.";
                ShowMyCourses();
            }
        }
    }
}
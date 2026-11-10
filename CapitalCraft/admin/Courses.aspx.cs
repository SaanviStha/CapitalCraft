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
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            if (!IsPostBack)
            {
                ShowCourses();
            }
        }

        private void ShowCourses()
        {
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand("SELECT CourseId, Title, Category FROM Courses ORDER BY CourseId", con);

                DataTable courses = new DataTable();
                new SqlDataAdapter(cmd).Fill(courses);

                // lessons and enrolled members for each course
                courses.Columns.Add("LessonCount", typeof(int));
                courses.Columns.Add("EnrolledCount", typeof(int));
                foreach (DataRow row in courses.Rows)
                {
                    SqlCommand lessons = new SqlCommand("SELECT COUNT(*) FROM Lessons WHERE CourseId = @course", con);
                    lessons.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["LessonCount"] = lessons.ExecuteScalar();

                    SqlCommand enrolled = new SqlCommand("SELECT COUNT(*) FROM Enrollments WHERE CourseId = @course", con);
                    enrolled.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["EnrolledCount"] = enrolled.ExecuteScalar();
                }

                rptCourses.DataSource = courses;
                rptCourses.DataBind();
            }
        }

        protected void rptCourses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCourse")
            {
                int courseId = int.Parse(e.CommandArgument.ToString());

                //delete course and everything linked to it
                string[] steps = {
                    "DELETE FROM QuizAttempts WHERE CourseId = @id",
                    "DELETE FROM Questions WHERE CourseId = @id",
                    "DELETE FROM Enrollments WHERE CourseId = @id",
                    "DELETE FROM Lessons WHERE CourseId = @id",
                    "DELETE FROM Courses WHERE CourseId = @id"
                };

                using (SqlConnection con = Db.Open())
                {
                    foreach (string sql in steps)
                    {
                        SqlCommand cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@id", courseId);
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Course deleted.";
                ShowCourses();
            }
        }
    }
}
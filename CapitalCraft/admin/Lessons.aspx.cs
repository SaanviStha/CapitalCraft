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
    public partial class Lessons : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            if (!IsPostBack)
            {
                ShowLessons();
            }
        }

        private void ShowLessons()
        {
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT Lessons.LessonId, Lessons.Title, Lessons.ReadingFile, Courses.Title AS CourseTitle " +
                    "FROM Lessons JOIN Courses ON Courses.CourseId = Lessons.CourseId " +
                    "ORDER BY Courses.CourseId, Lessons.LessonId", con);

                DataTable lessons = new DataTable();
                new SqlDataAdapter(cmd).Fill(lessons);
                rptLessons.DataSource = lessons;
                rptLessons.DataBind();
            }
        }

        protected void rptLessons_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteLesson")
            {
                using (SqlConnection con = Db.Open())
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Lessons WHERE LessonId = @id", con);
                    cmd.Parameters.AddWithValue("@id", int.Parse(e.CommandArgument.ToString()));
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "Lesson deleted.";
                ShowLessons();
            }
        }
    }
}
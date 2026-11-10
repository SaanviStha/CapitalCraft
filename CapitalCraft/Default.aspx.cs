using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace CapitalCraft
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowCourses();
            }
        }

        // load courses for the deck
        private void ShowCourses()
        {
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT CourseId, Title, Category, Description, Image FROM Courses ORDER BY CourseId", con);

                DataTable courses = new DataTable();
                new SqlDataAdapter(cmd).Fill(courses);

                // number of lessons in each course
                courses.Columns.Add("LessonCount", typeof(int));
                foreach (DataRow row in courses.Rows)
                {
                    SqlCommand count = new SqlCommand("SELECT COUNT(*) FROM Lessons WHERE CourseId = @course", con);
                    count.Parameters.AddWithValue("@course", row["CourseId"]);
                    row["LessonCount"] = count.ExecuteScalar();
                }

                rptDeck.DataSource = courses;
                rptDeck.DataBind();
            }
        }
    }
}

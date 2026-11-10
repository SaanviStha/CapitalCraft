using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace CapitalCraft.pages
{
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowCourses("");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //search courses
            ShowCourses(txtSearch.Text);
        }

        private void ShowCourses(string searchText)
        {
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM Courses WHERE Title LIKE @search OR Description LIKE @search OR Category LIKE @search", con);
                cmd.Parameters.AddWithValue("@search", "%" + searchText + "%");

                DataTable courses = new DataTable();
                new SqlDataAdapter(cmd).Fill(courses);

                rptCourses.DataSource = courses;
                rptCourses.DataBind();

                if (courses.Rows.Count == 0)
                {
                    lblMessage.Text = "No courses match your search.";
                }
                else
                {
                    lblMessage.Text = "";
                }
            }
        }
    }
}
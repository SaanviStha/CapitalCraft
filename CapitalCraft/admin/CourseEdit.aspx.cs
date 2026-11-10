using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;

namespace CapitalCraft.admin
{
    public partial class CourseEdit : System.Web.UI.Page
    {
        int courseId = 0;   // 0 = new course

        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            int.TryParse(Request.QueryString["id"], out courseId);

            // load course details when editing
            if (!IsPostBack && courseId > 0)
            {
                lblHeading.Text = "Edit course";

                using (SqlConnection con = Db.Open())
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Courses WHERE CourseId = @id", con);
                    cmd.Parameters.AddWithValue("@id", courseId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            Response.Redirect("/admin/Courses.aspx");
                        }
                        txtTitle.Text = reader["Title"].ToString();
                        ddlCategory.SelectedValue = reader["Category"].ToString();
                        txtDescription.Text = reader["Description"].ToString();
                        hfImage.Value = reader["Image"].ToString();
                    }
                }

                imgCurrent.ImageUrl = Pictures.Course(hfImage.Value);
                imgCurrent.Visible = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }
            txtTitle.Text = txtTitle.Text.Trim();

            // keep old picture unless a new one is uploaded
            string imagePath = hfImage.Value;

            if (fuImage.HasFile)
            {
                string problem = Pictures.Check(fuImage);
                if (problem != "")
                {
                    lblMessage.Text = problem;
                    return;
                }

                imagePath = Pictures.Save(fuImage, Server);
            }

            if (imagePath == "")
            {
                lblMessage.Text = "Please choose a course picture.";
                return;
            }

            // add or update the course
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd;

                if (courseId == 0)
                {
                    cmd = new SqlCommand(
                        "INSERT INTO Courses (Title, Category, Description, Image) " +
                        "VALUES (@title, @category, @description, @image)", con);
                }
                else
                {
                    cmd = new SqlCommand(
                        "UPDATE Courses SET Title = @title, Category = @category, " +
                        "Description = @description, Image = @image WHERE CourseId = @id", con);
                    cmd.Parameters.AddWithValue("@id", courseId);
                }

                cmd.Parameters.AddWithValue("@title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@category", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@image", imagePath);
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("/admin/Courses.aspx");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace CapitalCraft.admin
{
    public partial class LessonEdit : System.Web.UI.Page
    {
        int lessonId = 0;   // 0 = new lesson

        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            int.TryParse(Request.QueryString["id"], out lessonId);

            if (!IsPostBack)
            {
                using (SqlConnection con = Db.Open())
                {
                    // fill course dropdown
                    SqlCommand getCourses = new SqlCommand("SELECT CourseId, Title FROM Courses", con);
                    DataTable courses = new DataTable();
                    new SqlDataAdapter(getCourses).Fill(courses);

                    ddlCourse.DataSource = courses;
                    ddlCourse.DataTextField = "Title";
                    ddlCourse.DataValueField = "CourseId";
                    ddlCourse.DataBind();

                    // load lesson when editing
                    if (lessonId > 0)
                    {
                        lblHeading.Text = "Edit lesson";

                        SqlCommand getLesson = new SqlCommand("SELECT * FROM Lessons WHERE LessonId = @id", con);
                        getLesson.Parameters.AddWithValue("@id", lessonId);

                        using (SqlDataReader reader = getLesson.ExecuteReader())
                        {
                            if (!reader.Read())
                            {
                                Response.Redirect("/admin/Lessons.aspx");
                            }
                            ddlCourse.SelectedValue = reader["CourseId"].ToString();
                            txtTitle.Text = reader["Title"].ToString();
                            txtContent.Text = reader["Content"].ToString();
                            hfImage.Value = reader["Image"].ToString();
                            txtVideo.Text = reader["VideoUrl"].ToString();
                            hfReading.Value = reader["ReadingFile"].ToString();
                        }

                        // show current pdf and picture
                        if (hfReading.Value != "")
                        {
                            lnkCurrentReading.Text = System.IO.Path.GetFileName(hfReading.Value);
                            lnkCurrentReading.NavigateUrl = "/" + hfReading.Value;
                            phCurrentReading.Visible = true;
                        }

                        if (hfImage.Value != "")
                        {
                            imgCurrent.ImageUrl = "/" + hfImage.Value;
                            imgCurrent.Visible = true;
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }
            txtTitle.Text = txtTitle.Text.Trim();

            // check youtube link
            string videoUrl = txtVideo.Text.Trim();
            if (videoUrl != "" && Videos.YouTubeId(videoUrl) == "")
            {
                lblMessage.Text = "Video link must be a YouTube video link, e.g. https://www.youtube.com/watch?v=...";
                return;
            }

            // check uploaded files
            if (fuImage.HasFile)
            {
                string problem = Pictures.Check(fuImage);
                if (problem != "")
                {
                    lblMessage.Text = problem;
                    return;
                }
            }

            if (fuReading.HasFile)
            {
                string problem = Readings.Check(fuReading);
                if (problem != "")
                {
                    lblMessage.Text = problem;
                    return;
                }
            }

            // save reading pdf
            string readingPath = hfReading.Value;
            if (chkRemoveReading.Checked)
            {
                readingPath = "";
            }
            if (fuReading.HasFile)
            {
                readingPath = Readings.Save(fuReading, Server);
            }

            string imagePath = hfImage.Value;

            if (fuImage.HasFile)
            {
                imagePath = Pictures.Save(fuImage, Server);
            }

            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd;

                if (lessonId == 0)
                {
                    cmd = new SqlCommand(
                        "INSERT INTO Lessons (CourseId, Title, Content, Image, VideoUrl, ReadingFile) VALUES (@course, @title, @content, @image, @video, @reading)", con);
                }
                else
                {
                    cmd = new SqlCommand(
                        "UPDATE Lessons SET CourseId = @course, Title = @title, Content = @content, Image = @image, VideoUrl = @video, ReadingFile = @reading WHERE LessonId = @id", con);
                    cmd.Parameters.AddWithValue("@id", lessonId);
                }

                cmd.Parameters.AddWithValue("@course", ddlCourse.SelectedValue);
                cmd.Parameters.AddWithValue("@title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@content", txtContent.Text);
                cmd.Parameters.AddWithValue("@image", imagePath);
                cmd.Parameters.AddWithValue("@video", videoUrl);
                cmd.Parameters.AddWithValue("@reading", readingPath);
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("/admin/Lessons.aspx");
        }
    }
}
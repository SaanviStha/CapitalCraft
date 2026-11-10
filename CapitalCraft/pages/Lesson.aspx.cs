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
    public partial class Lesson : System.Web.UI.Page
    {
        protected int lessonId;
        protected int courseId;
        protected string videoEmbed = "";
        protected string readingFile = "";
        protected string readingName = "";
        protected string readingSize = "";
        DataTable lessons = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this);

            if (!int.TryParse(Request.QueryString["id"], out lessonId))
            {
                Response.Redirect("/pages/Courses.aspx");
            }

            using (SqlConnection con = Db.Open())
            {
                // get lesson and course name
                SqlCommand getLesson = new SqlCommand(
                    "SELECT Lessons.Title, Lessons.Content, Lessons.Image, Lessons.VideoUrl, Lessons.ReadingFile, Lessons.CourseId, Courses.Title AS CourseTitle " +
                    "FROM Lessons JOIN Courses ON Courses.CourseId = Lessons.CourseId " +
                    "WHERE Lessons.LessonId = @id", con);
                getLesson.Parameters.AddWithValue("@id", lessonId);

                using (SqlDataReader reader = getLesson.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        Response.Redirect("/pages/Courses.aspx");
                    }
                    courseId = (int)reader["CourseId"];
                    lblTitle.Text = reader["Title"].ToString();
                    Page.Title = lblTitle.Text + " | Capital Craft";
                    lblCourse.Text = reader["CourseTitle"].ToString();
                    lblContent.Text = Server.HtmlEncode(reader["Content"].ToString()).Replace("\n", "<br>");

                    string image = reader["Image"].ToString();
                    if (image != "")
                    {
                        imgLesson.ImageUrl = "/" + image;
                        imgLesson.AlternateText = lblTitle.Text;
                        imgLesson.Visible = true;
                    }

                    videoEmbed = Videos.EmbedUrl(reader["VideoUrl"].ToString());
                    phVideo.Visible = (videoEmbed != "");

                    // pdf reading
                    readingFile = reader["ReadingFile"].ToString();
                    if (readingFile != "")
                    {
                        System.IO.FileInfo pdf = new System.IO.FileInfo(Server.MapPath("~/" + readingFile));
                        if (pdf.Exists)
                        {
                            readingName = pdf.Name;
                            readingSize = pdf.Length < 1024 * 1024
                                ? Math.Max(1, pdf.Length / 1024) + " KB"
                                : (pdf.Length / (1024.0 * 1024.0)).ToString("0.0") + " MB";
                            phReading.Visible = true;
                        }
                    }
                }

                if (lblContent.Text == "")
                {
                    lblContent.Text = "Lesson notes coming soon.";
                }

                // lessons for the side list
                SqlCommand getList = new SqlCommand(
                    "SELECT LessonId, Title FROM Lessons WHERE CourseId = @course ORDER BY LessonId", con);
                getList.Parameters.AddWithValue("@course", courseId);

                new SqlDataAdapter(getList).Fill(lessons);

                // save last lesson visited
                SqlCommand remember = new SqlCommand(
                    "UPDATE Enrollments SET LastLessonId = @lesson, LastVisited = GETDATE() " +
                    "WHERE UserId = @user AND CourseId = @course", con);
                remember.Parameters.AddWithValue("@lesson", lessonId);
                remember.Parameters.AddWithValue("@user", Session["UserId"]);
                remember.Parameters.AddWithValue("@course", courseId);
                remember.ExecuteNonQuery();
            }

            ShowProgress();
        }

        // show progress and ticks
        private void ShowProgress()
        {
            int progress = -1;

            using (SqlConnection con = Db.Open())
            {
                SqlCommand getProgress = new SqlCommand(
                    "SELECT Progress FROM Enrollments WHERE UserId = @user AND CourseId = @course", con);
                getProgress.Parameters.AddWithValue("@user", Session["UserId"]);
                getProgress.Parameters.AddWithValue("@course", courseId);

                object result = getProgress.ExecuteScalar();
                if (result != null)
                {
                    progress = (int)result;
                }
            }

            if (progress >= 0)
            {
                prgCourse.Attributes["value"] = progress.ToString();
                prgCourse.Visible = true;
            }

            // tick the completed lessons
            int total = lessons.Rows.Count;
            if (!lessons.Columns.Contains("Tick"))
            {
                lessons.Columns.Add("Tick");
            }

            for (int i = 0; i < total; i++)
            {
                int lessonNumber = i + 1;
                bool done = progress >= 0 && lessonNumber * 100 / total <= progress;
                lessons.Rows[i]["Tick"] = done ? "✓" : "";

                if ((int)lessons.Rows[i]["LessonId"] == lessonId && done)
                {
                    btnComplete.Text = "✓ Completed";
                    btnComplete.Enabled = false;
                    if (lblMessage.Text == "")
                    {
                        lblMessage.Text = "Course progress: " + progress + "%";
                    }

                    if (i + 1 < total)
                    {
                        lnkNext.NavigateUrl = "/pages/Lesson.aspx?id=" + lessons.Rows[i + 1]["LessonId"];
                        lnkNext.Text = "Next lesson →";
                    }
                    else
                    {
                        // last lesson goes to quiz
                        lnkNext.NavigateUrl = "/pages/Quiz.aspx?course=" + courseId;
                        lnkNext.Text = "Take the course quiz →";
                    }
                    lnkNext.Visible = true;
                }
            }

            rptLessons.DataSource = lessons;
            rptLessons.DataBind();
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = Db.Open())
            {
                // check user is enrolled
                SqlCommand check = new SqlCommand(
                    "SELECT COUNT(*) FROM Enrollments WHERE UserId = @user AND CourseId = @course", con);
                check.Parameters.AddWithValue("@user", Session["UserId"]);
                check.Parameters.AddWithValue("@course", courseId);
                if ((int)check.ExecuteScalar() == 0)
                {
                    lblMessage.Text = "Please enrol in this course first.";
                    return;
                }

                SqlCommand total = new SqlCommand("SELECT COUNT(*) FROM Lessons WHERE CourseId = @course", con);
                total.Parameters.AddWithValue("@course", courseId);
                int totalLessons = (int)total.ExecuteScalar();

                SqlCommand position = new SqlCommand(
                    "SELECT COUNT(*) FROM Lessons WHERE CourseId = @course AND LessonId <= @lesson", con);
                position.Parameters.AddWithValue("@course", courseId);
                position.Parameters.AddWithValue("@lesson", lessonId);
                int lessonNumber = (int)position.ExecuteScalar();

                int progress = lessonNumber * 100 / totalLessons;

                // only update if progress is higher
                SqlCommand update = new SqlCommand(
                    "UPDATE Enrollments SET Progress = @progress " +
                    "WHERE UserId = @user AND CourseId = @course AND Progress < @progress", con);
                update.Parameters.AddWithValue("@progress", progress);
                update.Parameters.AddWithValue("@user", Session["UserId"]);
                update.Parameters.AddWithValue("@course", courseId);
                update.ExecuteNonQuery();

                lblMessage.Text = "Lesson complete! Course progress: " + progress + "%";
            }

            ShowProgress();
        }
    }
}
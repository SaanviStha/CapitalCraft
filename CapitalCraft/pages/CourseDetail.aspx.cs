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
    public partial class CoursesDetails : System.Web.UI.Page
    {
        int courseId;
        int firstLessonId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // get course id from url
            if (!int.TryParse(Request.QueryString["id"], out courseId))
            {
                Response.Redirect("/pages/Courses.aspx");
            }

            using (SqlConnection con = Db.Open())
            {
                // get course details
                SqlCommand getCourse = new SqlCommand("SELECT * FROM Courses WHERE CourseId = @id", con);
                getCourse.Parameters.AddWithValue("@id", courseId);

                using (SqlDataReader reader = getCourse.ExecuteReader())
                {
                    if (!reader.Read())
                    {
                        Response.Redirect("/pages/Courses.aspx");
                    }
                    lblTitle.Text = reader["Title"].ToString();
                    Page.Title = lblTitle.Text + " | Capital Craft";
                    lblCategory.Text = reader["Category"].ToString();
                    lblDescription.Text = Server.HtmlEncode(reader["Description"].ToString());
                    imgCourse.ImageUrl = Pictures.Course(reader["Image"]);
                    imgCourse.AlternateText = lblTitle.Text;
                }

                // get lessons for this course
                SqlCommand getLessons = new SqlCommand(
                    "SELECT LessonId, Title FROM Lessons WHERE CourseId = @id ORDER BY LessonId", con);
                getLessons.Parameters.AddWithValue("@id", courseId);

                DataTable lessons = new DataTable();
                new SqlDataAdapter(getLessons).Fill(lessons);
                rptLessons.DataSource = lessons;
                rptLessons.DataBind();
                lblLessonCount.Text = lessons.Rows.Count.ToString();

                if (lessons.Rows.Count > 0)
                {
                    firstLessonId = (int)lessons.Rows[0]["LessonId"];
                }
            }

            // enrol after coming back from login
            if (!IsPostBack && Session["UserId"] != null && Request.QueryString["enrol"] == "1")
            {
                EnrolUser();
            }

            ShowEnrolStatus();
        }

        protected void btnEnrol_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                string backHere = "/pages/CourseDetail.aspx?id=" + courseId + "&enrol=1";
                Response.Redirect("/pages/Login.aspx?returnUrl=" + Server.UrlEncode(backHere));
            }

            EnrolUser();
            ShowEnrolStatus();
        }

        // add enrolment if not enrolled yet
        private void EnrolUser()
        {
            using (SqlConnection con = Db.Open())
            {
                SqlCommand check = new SqlCommand(
                    "SELECT COUNT(*) FROM Enrollments WHERE UserId = @user AND CourseId = @course", con);
                check.Parameters.AddWithValue("@user", Session["UserId"]);
                check.Parameters.AddWithValue("@course", courseId);

                if ((int)check.ExecuteScalar() == 0)
                {
                    SqlCommand enrol = new SqlCommand(
                        "INSERT INTO Enrollments (UserId, CourseId, Progress) VALUES (@user, @course, 0)", con);
                    enrol.Parameters.AddWithValue("@user", Session["UserId"]);
                    enrol.Parameters.AddWithValue("@course", courseId);
                    enrol.ExecuteNonQuery();

                    lblMessage.Text = "You're enrolled! Start with the first lesson, or find this course on your dashboard.";
                }
            }
        }

        private void ShowEnrolStatus()
        {
            if (Session["UserId"] == null)
            {
                return;
            }

            using (SqlConnection con = Db.Open())
            {
                SqlCommand check = new SqlCommand(
                    "SELECT COUNT(*) FROM Enrollments WHERE UserId = @user AND CourseId = @course", con);
                check.Parameters.AddWithValue("@user", Session["UserId"]);
                check.Parameters.AddWithValue("@course", courseId);

                if ((int)check.ExecuteScalar() > 0)
                {
                    btnEnrol.Visible = false;
                    lnkContinue.Visible = true;
                    lnkContinue.NavigateUrl = "/pages/Lesson.aspx?id=" + firstLessonId;

                    // show quiz button if course has questions
                    SqlCommand quiz = new SqlCommand("SELECT COUNT(*) FROM Questions WHERE CourseId = @course", con);
                    quiz.Parameters.AddWithValue("@course", courseId);
                    if ((int)quiz.ExecuteScalar() > 0)
                    {
                        lnkQuiz.NavigateUrl = "/pages/Quiz.aspx?course=" + courseId;
                        lnkQuiz.Visible = true;
                    }

                    if (lblMessage.Text == "")
                    {
                        lblMessage.Text = "✓ You are enrolled in this course.";
                    }
                }
            }
        }
    }
}
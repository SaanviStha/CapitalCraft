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
    public partial class Questions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            if (!IsPostBack)
            {
                // fill course filter
                using (SqlConnection con = Db.Open())
                {
                    SqlCommand getCourses = new SqlCommand("SELECT CourseId, Title FROM Courses ORDER BY CourseId", con);
                    DataTable courses = new DataTable();
                    new SqlDataAdapter(getCourses).Fill(courses);

                    ddlCourse.DataSource = courses;
                    ddlCourse.DataTextField = "Title";
                    ddlCourse.DataValueField = "CourseId";
                    ddlCourse.DataBind();
                    ddlCourse.Items.Insert(0, new ListItem("All courses", "0"));
                }

                if (ddlCourse.Items.FindByValue(Request.QueryString["course"] ?? "") != null)
                {
                    ddlCourse.SelectedValue = Request.QueryString["course"];
                }

                ShowQuestions();
            }
        }

        private void ShowQuestions()
        {
            int courseId = int.Parse(ddlCourse.SelectedValue);   // 0 = all courses

            using (SqlConnection con = Db.Open())
            {
                // get questions with the correct answer text
                SqlCommand cmd = new SqlCommand(
                    "SELECT Questions.QuestionId, Questions.QuestionText, Questions.CorrectAnswer, " +
                    "  CASE Questions.CorrectAnswer WHEN 'A' THEN OptionA WHEN 'B' THEN OptionB " +
                    "    WHEN 'C' THEN OptionC ELSE OptionD END AS CorrectText, " +
                    "  Courses.Title AS CourseTitle " +
                    "FROM Questions JOIN Courses ON Courses.CourseId = Questions.CourseId " +
                    "WHERE @course = 0 OR Questions.CourseId = @course " +
                    "ORDER BY Courses.CourseId, Questions.QuestionId", con);
                cmd.Parameters.AddWithValue("@course", courseId);

                DataTable questions = new DataTable();
                new SqlDataAdapter(cmd).Fill(questions);
                rptQuestions.DataSource = questions;
                rptQuestions.DataBind();

                if (questions.Rows.Count == 0)
                {
                    lblMessage.Text = "No questions yet. Use \"+ Add new question\" to create this course's quiz.";
                }
            }

            lnkAdd.NavigateUrl = "/admin/QuestionEdit.aspx" + (courseId > 0 ? "?course=" + courseId : "");
        }

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            ShowQuestions();
        }

        protected void rptQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQuestion")
            {
                using (SqlConnection con = Db.Open())
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Questions WHERE QuestionId = @id", con);
                    cmd.Parameters.AddWithValue("@id", int.Parse(e.CommandArgument.ToString()));
                    cmd.ExecuteNonQuery();
                }

                ShowQuestions();
                lblMessage.Text = "Question deleted.";
            }
        }
    }
}

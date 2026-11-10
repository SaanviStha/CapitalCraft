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
    public partial class QuestionEdit : System.Web.UI.Page
    {
        int questionId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            int.TryParse(Request.QueryString["id"], out questionId);

            if (!IsPostBack)
            {
                using (SqlConnection con = Db.Open())
                {
                    // load courses into dropdown
                    SqlCommand getCourses = new SqlCommand("SELECT CourseId, Title FROM Courses ORDER BY CourseId", con);
                    DataTable courses = new DataTable();
                    new SqlDataAdapter(getCourses).Fill(courses);

                    ddlCourse.DataSource = courses;
                    ddlCourse.DataTextField = "Title";
                    ddlCourse.DataValueField = "CourseId";
                    ddlCourse.DataBind();

                    if (ddlCourse.Items.FindByValue(Request.QueryString["course"] ?? "") != null)
                    {
                        ddlCourse.SelectedValue = Request.QueryString["course"];
                    }

                    // editing an existing question
                    if (questionId > 0)
                    {
                        lblHeading.Text = "Edit question";

                        SqlCommand getQuestion = new SqlCommand("SELECT * FROM Questions WHERE QuestionId = @id", con);
                        getQuestion.Parameters.AddWithValue("@id", questionId);

                        using (SqlDataReader reader = getQuestion.ExecuteReader())
                        {
                            if (!reader.Read())
                            {
                                Response.Redirect("/admin/Questions.aspx");
                            }
                            ddlCourse.SelectedValue = reader["CourseId"].ToString();
                            txtQuestion.Text = reader["QuestionText"].ToString();
                            txtOptionA.Text = reader["OptionA"].ToString();
                            txtOptionB.Text = reader["OptionB"].ToString();
                            txtOptionC.Text = reader["OptionC"].ToString();
                            txtOptionD.Text = reader["OptionD"].ToString();
                            rblCorrect.SelectedValue = reader["CorrectAnswer"].ToString();
                        }
                    }
                }

                lnkBack.NavigateUrl = "/admin/Questions.aspx?course=" + ddlCourse.SelectedValue;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string question = txtQuestion.Text.Trim();
            string[] options = Options();

            // max 200 chars per option
            foreach (string option in options)
            {
                if (option.Length > 200)
                {
                    lblMessage.Text = "Each option can be up to 200 characters.";
                    return;
                }
            }

            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd;

                if (questionId == 0)
                {
                    cmd = new SqlCommand(
                        "INSERT INTO Questions (CourseId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) " +
                        "VALUES (@course, @question, @a, @b, @c, @d, @correct)", con);
                }
                else
                {
                    cmd = new SqlCommand(
                        "UPDATE Questions SET CourseId = @course, QuestionText = @question, OptionA = @a, OptionB = @b, " +
                        "OptionC = @c, OptionD = @d, CorrectAnswer = @correct WHERE QuestionId = @id", con);
                    cmd.Parameters.AddWithValue("@id", questionId);
                }

                cmd.Parameters.AddWithValue("@course", ddlCourse.SelectedValue);
                cmd.Parameters.AddWithValue("@question", question);
                cmd.Parameters.AddWithValue("@a", options[0]);
                cmd.Parameters.AddWithValue("@b", options[1]);
                cmd.Parameters.AddWithValue("@c", options[2]);
                cmd.Parameters.AddWithValue("@d", options[3]);
                cmd.Parameters.AddWithValue("@correct", rblCorrect.SelectedValue);
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("/admin/Questions.aspx?course=" + ddlCourse.SelectedValue);
        }

        private string[] Options()
        {
            return new[] { txtOptionA.Text.Trim(), txtOptionB.Text.Trim(), txtOptionC.Text.Trim(), txtOptionD.Text.Trim() };
        }

        // options must all be different
        protected void cvDifferent_ServerValidate(object source, ServerValidateEventArgs args)
        {
            List<string> seen = new List<string>();
            args.IsValid = true;

            foreach (string option in Options())
            {
                if (option == "")
                {
                    continue;
                }
                if (seen.Contains(option.ToLower()))
                {
                    args.IsValid = false;
                }
                seen.Add(option.ToLower());
            }
        }
    }
}

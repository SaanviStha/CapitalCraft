using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace CapitalCraft.pages
{
    public partial class Quiz : System.Web.UI.Page
    {
        const int PassMark = 60;

        protected int courseId;
        bool isAdmin;

        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this);

            // get course id from url
            if (!int.TryParse(Request.QueryString["course"], out courseId))
            {
                Response.Redirect("/pages/Courses.aspx");
            }

            isAdmin = Session["Role"].ToString() == "Admin";

            using (SqlConnection con = Db.Open())
            {
                SqlCommand getCourse = new SqlCommand("SELECT Title FROM Courses WHERE CourseId = @id", con);
                getCourse.Parameters.AddWithValue("@id", courseId);
                object title = getCourse.ExecuteScalar();
                if (title == null)
                {
                    Response.Redirect("/pages/Courses.aspx");
                }
                lblCourse.Text = title.ToString();
                Page.Title = "Quiz: " + lblCourse.Text + " | Capital Craft";

                // members must be enrolled
                if (!isAdmin)
                {
                    SqlCommand check = new SqlCommand(
                        "SELECT COUNT(*) FROM Enrollments WHERE UserId = @user AND CourseId = @course", con);
                    check.Parameters.AddWithValue("@user", Session["UserId"]);
                    check.Parameters.AddWithValue("@course", courseId);

                    if ((int)check.ExecuteScalar() == 0)
                    {
                        ShowNotice("Please enrol in this course before taking its quiz. " +
                            "<a href='/pages/CourseDetail.aspx?id=" + courseId + "'>Go to the course page</a>");
                        return;
                    }
                }

                // load questions
                SqlCommand getQuestions = new SqlCommand(
                    "SELECT QuestionId, QuestionText, OptionA, OptionB, OptionC, OptionD " +
                    "FROM Questions WHERE CourseId = @course ORDER BY QuestionId", con);
                getQuestions.Parameters.AddWithValue("@course", courseId);

                DataTable questions = new DataTable();
                new SqlDataAdapter(getQuestions).Fill(questions);

                if (questions.Rows.Count == 0)
                {
                    ShowNotice("This course doesn't have a quiz yet. Please check back later.");
                    return;
                }

                lblIntro.Text = questions.Rows.Count + " questions · You need " + PassMark + "% to pass. " +
                                "Your answers are marked when you submit them, and you can try as many times as you like.";
                if (isAdmin)
                {
                    lblIntro.Text += " (Admin preview: your score will not be saved.)";
                }

                if (!IsPostBack)
                {
                    rptQuestions.DataSource = questions;
                    rptQuestions.DataBind();
                }
            }

            ShowBestScore();
        }

        protected void rptQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
            {
                return;
            }

            DataRowView question = (DataRowView)e.Item.DataItem;
            RadioButtonList answers = (RadioButtonList)e.Item.FindControl("rblAnswer");

            foreach (string letter in new[] { "A", "B", "C", "D" })
            {
                string text = Server.HtmlEncode(question["Option" + letter].ToString());
                answers.Items.Add(new ListItem(text, letter));
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // check all questions are answered
            int unanswered = 0;
            foreach (RepeaterItem item in rptQuestions.Items)
            {
                RadioButtonList answers = (RadioButtonList)item.FindControl("rblAnswer");
                HtmlGenericControl box = (HtmlGenericControl)item.FindControl("fsQuestion");

                if (answers.SelectedValue == "")
                {
                    unanswered++;
                    box.Attributes["class"] = "box quiz-question unanswered";
                }
                else
                {
                    box.Attributes["class"] = "box quiz-question";
                }
            }

            if (unanswered > 0)
            {
                lblMessage.Text = "Please answer every question. " + unanswered + " question(s) still need an answer.";
                return;
            }

            // get correct answers
            DataTable correct = new DataTable();
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT QuestionId, CorrectAnswer, OptionA, OptionB, OptionC, OptionD " +
                    "FROM Questions WHERE CourseId = @course", con);
                cmd.Parameters.AddWithValue("@course", courseId);
                new SqlDataAdapter(cmd).Fill(correct);
            }

            // mark each answer
            int score = 0;
            int total = rptQuestions.Items.Count;

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                string questionId = ((HiddenField)item.FindControl("hfQuestionId")).Value;
                RadioButtonList answers = (RadioButtonList)item.FindControl("rblAnswer");
                Label feedback = (Label)item.FindControl("lblFeedback");
                HtmlGenericControl box = (HtmlGenericControl)item.FindControl("fsQuestion");

                foreach (DataRow row in correct.Rows)
                {
                    if (row["QuestionId"].ToString() == questionId)
                    {
                        string rightLetter = row["CorrectAnswer"].ToString();

                        if (answers.SelectedValue == rightLetter)
                        {
                            score++;
                            box.Attributes["class"] = "box quiz-question correct";
                            feedback.Text = "✓ Correct";
                        }
                        else
                        {
                            box.Attributes["class"] = "box quiz-question wrong";
                            feedback.Text = "✗ Not quite. The correct answer is: " +
                                            Server.HtmlEncode(row["Option" + rightLetter].ToString());
                        }
                    }
                }

                feedback.Visible = true;
                answers.Enabled = false;
            }

            int percent = score * 100 / total;

            // save attempt (not for admins)
            if (!isAdmin)
            {
                using (SqlConnection con = Db.Open())
                {
                    SqlCommand save = new SqlCommand(
                        "INSERT INTO QuizAttempts (UserId, CourseId, Score, Total) VALUES (@user, @course, @score, @total)", con);
                    save.Parameters.AddWithValue("@user", Session["UserId"]);
                    save.Parameters.AddWithValue("@course", courseId);
                    save.Parameters.AddWithValue("@score", score);
                    save.Parameters.AddWithValue("@total", total);
                    save.ExecuteNonQuery();
                }
            }

            // show result
            lblScore.Text = "You scored " + score + " / " + total + " (" + percent + "%)";
            if (percent >= PassMark)
            {
                lblVerdict.Text = "✓ Passed. Well done, you have a good understanding of this course.";
                pnlResult.CssClass = "box quiz-result passed";
            }
            else
            {
                lblVerdict.Text = "Not passed yet. You need at least " + PassMark + "%. " +
                                  "Look at the feedback below, review the lessons and try again.";
                pnlResult.CssClass = "box quiz-result failed";
            }
            pnlResult.Visible = true;
            btnSubmit.Visible = false;
            lblMessage.Text = "";

            ShowBestScore();
        }

        // best score and number of attempts
        private void ShowBestScore()
        {
            if (isAdmin)
            {
                return;
            }

            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT MAX(Score * 100 / Total) AS Best, COUNT(*) AS Attempts " +
                    "FROM QuizAttempts WHERE UserId = @user AND CourseId = @course", con);
                cmd.Parameters.AddWithValue("@user", Session["UserId"]);
                cmd.Parameters.AddWithValue("@course", courseId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    reader.Read();
                    int attempts = (int)reader["Attempts"];
                    if (attempts > 0)
                    {
                        lblBest.Text = "Your best score: " + reader["Best"] + "% · " + attempts +
                                       (attempts == 1 ? " attempt" : " attempts");
                        lblBest.Visible = true;
                    }
                }
            }
        }

        private void ShowNotice(string message)
        {
            phQuiz.Visible = false;
            lblNotice.Text = message;
            pnlNotice.Visible = true;
        }
    }
}

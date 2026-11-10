using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CapitalCraft
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string returnUrl = Request.QueryString["returnUrl"];
            if (returnUrl != null && returnUrl.StartsWith("/pages/CourseDetail.aspx"))
            {
                lnkLogin.HRef = "Login.aspx?returnUrl=" + Server.UrlEncode(returnUrl);
            }
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            using (SqlConnection con = Db.Open())
            {
                // check if email is already used
                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @email", con);
                check.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                int count = (int)check.ExecuteScalar();

                if (count > 0)
                {
                    lblMessage.Text = "This email is already registered.";
                    return;
                }

                // save the new user
                SqlCommand save = new SqlCommand(
                    "INSERT INTO Users (FullName, Email, Password, Role) VALUES (@name, @email, @password, 'Member')", con);
                save.Parameters.AddWithValue("@name", txtFirst.Text + " " + txtLast.Text);
                save.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                save.Parameters.AddWithValue("@password", txtPw.Text);
                save.ExecuteNonQuery();

                // get the new user's id
                SqlCommand getId = new SqlCommand("SELECT UserId FROM Users WHERE Email = @email", con);
                getId.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                int newUserId = (int)getId.ExecuteScalar();

                Session["UserId"] = newUserId;
                Session["Name"]   = txtFirst.Text + " " + txtLast.Text;
                Session["Role"]   = "Member";
            }

            string returnUrl = Request.QueryString["returnUrl"];
            if (returnUrl != null && returnUrl.StartsWith("/pages/CourseDetail.aspx"))
            {
                Response.Redirect(returnUrl);
            }

            Response.Redirect("/Default.aspx");
        }
    }
}
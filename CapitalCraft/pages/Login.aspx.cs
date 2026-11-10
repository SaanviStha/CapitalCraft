using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CapitalCraft.pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string returnUrl = Request.QueryString["returnUrl"];
            if (returnUrl != null && returnUrl.StartsWith("/pages/CourseDetail.aspx"))
            {
                lnkRegister.HRef = "Register.aspx?returnUrl=" + Server.UrlEncode(returnUrl);
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            using (SqlConnection con = Db.Open())
            {
                // find user by email
                SqlCommand find = new SqlCommand(
                    "SELECT UserId, FullName, Role, Password FROM Users WHERE Email = @email", con);
                find.Parameters.AddWithValue("@email", txtEmail.Text.Trim());

                using (SqlDataReader reader = find.ExecuteReader())
                {
                    if (!reader.Read() || reader["Password"].ToString() != txtPw.Text)
                    {
                        lblMessage.Text = "Incorrect email or password.";
                        return;
                    }

                    Session["UserId"] = reader["UserId"];
                    Session["Name"] = reader["FullName"];
                    Session["Role"] = reader["Role"];
                }
            }

            string returnUrl = Request.QueryString["returnUrl"];
            if (returnUrl != null && returnUrl.StartsWith("/pages/CourseDetail.aspx"))
            {
                Response.Redirect(returnUrl);
            }

            // go to the right dashboard
            if (Session["Role"].ToString() == "Admin")
            {
                Response.Redirect("/admin/Dashboard.aspx");
            }
            else
            {
                Response.Redirect("/member/Dashboard.aspx");
            }
        }
    }
}
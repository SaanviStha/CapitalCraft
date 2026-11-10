using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CapitalCraft.member
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this);

            if (!IsPostBack)
            {
                using (SqlConnection con = Db.Open())
                {
                    SqlCommand cmd = new SqlCommand("SELECT FullName, Email FROM Users WHERE UserId = @id", con);
                    cmd.Parameters.AddWithValue("@id", Session["UserId"]);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        reader.Read();
                        txtName.Text = reader["FullName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                    }
                }
            }
        }

        // update name and email
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }
            txtName.Text = txtName.Text.Trim();
            txtEmail.Text = txtEmail.Text.Trim();

            using (SqlConnection con = Db.Open())
            {
                // check if email is already used
                SqlCommand check = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Email = @email AND UserId <> @id", con);
                check.Parameters.AddWithValue("@email", txtEmail.Text);
                check.Parameters.AddWithValue("@id", Session["UserId"]);
                if ((int)check.ExecuteScalar() > 0)
                {
                    lblDetailsMsg.Text = "That email is already used by another account.";
                    return;
                }

                SqlCommand update = new SqlCommand(
                    "UPDATE Users SET FullName = @name, Email = @email WHERE UserId = @id", con);
                update.Parameters.AddWithValue("@name", txtName.Text);
                update.Parameters.AddWithValue("@email", txtEmail.Text);
                update.Parameters.AddWithValue("@id", Session["UserId"]);
                update.ExecuteNonQuery();
            }

            Session["Name"] = txtName.Text;
            lblDetailsMsg.Text = "Profile saved.";
        }

        // change password
        protected void btnPassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            using (SqlConnection con = Db.Open())
            {
                // check current password
                SqlCommand getSaved = new SqlCommand("SELECT Password FROM Users WHERE UserId = @id", con);
                getSaved.Parameters.AddWithValue("@id", Session["UserId"]);
                object saved = getSaved.ExecuteScalar();

                if (saved == null || saved.ToString() != txtOldPw.Text)
                {
                    lblPwMsg.Text = "Current password is incorrect.";
                    return;
                }

                SqlCommand update = new SqlCommand("UPDATE Users SET Password = @new WHERE UserId = @id", con);
                update.Parameters.AddWithValue("@new", txtNewPw.Text);
                update.Parameters.AddWithValue("@id", Session["UserId"]);
                update.ExecuteNonQuery();
            }

            lblPwMsg.Text = "Password updated.";
        }

        //delete account
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Db.DeleteUser((int)Session["UserId"]);
            Session.Abandon();
            Response.Redirect("/Default.aspx");
        }
    }
}
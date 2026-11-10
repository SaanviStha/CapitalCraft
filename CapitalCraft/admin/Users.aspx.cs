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
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Auth.Require(this, "Admin");

            if (!IsPostBack)
            {
                ShowUsers();
            }
        }

        private void ShowUsers()
        {
            using (SqlConnection con = Db.Open())
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT UserId, FullName, Email, Role FROM Users ORDER BY Role, FullName", con);

                DataTable users = new DataTable();
                new SqlDataAdapter(cmd).Fill(users);

                // how many courses each user is enrolled in
                users.Columns.Add("CourseCount", typeof(int));
                foreach (DataRow row in users.Rows)
                {
                    SqlCommand count = new SqlCommand("SELECT COUNT(*) FROM Enrollments WHERE UserId = @user", con);
                    count.Parameters.AddWithValue("@user", row["UserId"]);
                    row["CourseCount"] = count.ExecuteScalar();
                }

                rptUsers.DataSource = users;
                rptUsers.DataBind();
            }
        }

        protected void rptUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId = int.Parse(e.CommandArgument.ToString());

            // admin can't change their own account
            if (userId == (int)Session["UserId"])
            {
                lblMessage.Text = "You can't change or delete your own account here.";
                return;
            }

            using (SqlConnection con = Db.Open())
            {
                if (e.CommandName == "ChangeRole")
                {
                    SqlCommand cmd = new SqlCommand(
                        "UPDATE Users SET Role = CASE WHEN Role = 'Admin' THEN 'Member' ELSE 'Admin' END " +
                        "WHERE UserId = @id", con);
                    cmd.Parameters.AddWithValue("@id", userId);
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Role changed.";
                }
            }

            if (e.CommandName == "DeleteUser")
            {
                Db.DeleteUser(userId);
                lblMessage.Text = "User deleted.";
            }

            ShowUsers();
        }
    }
}
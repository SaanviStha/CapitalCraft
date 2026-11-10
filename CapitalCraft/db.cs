using System.Configuration;
using System.Data.SqlClient;

public static class Db
{
    public static SqlConnection Open()
    {
        string address = ConfigurationManager.ConnectionStrings["CapitalCraftDB"].ConnectionString;
        SqlConnection con = new SqlConnection(address);
        con.Open();
        return con;
    }

    //delete user with their attempts and enrollments
    public static void DeleteUser(int userId)
    {
        string[] steps = {
            "DELETE FROM QuizAttempts WHERE UserId = @id",
            "DELETE FROM Enrollments WHERE UserId = @id",
            "DELETE FROM Users WHERE UserId = @id"
        };

        using (SqlConnection con = Open())
        {
            foreach (string sql in steps)
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", userId);
                cmd.ExecuteNonQuery();
            }
        }
    }
}

using System;
using System.Web.UI;

public static class Auth
{
    // send to login if not allowed on this page
    public static void Require(Page page, string role = null)
    {
        if (page.Session["UserId"] == null)
        {
            page.Response.Redirect("~/pages/Login.aspx");
        }
        else if (role != null && page.Session["Role"].ToString() != role)
        {
            page.Response.Redirect("~/member/Dashboard.aspx");
        }
    }
}
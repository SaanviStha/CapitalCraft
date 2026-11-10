<%@ Page Title="Manage users | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="CapitalCraft.admin.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div id="side-layout">
  <aside id="sidebar">
    <a href="/admin/Dashboard.aspx">Dashboard</a>
    <a href="/admin/Courses.aspx">Manage Courses</a>
    <a href="/admin/Lessons.aspx">Manage Lessons</a>
    <a href="/admin/Questions.aspx">Manage Questions</a>
    <a href="/admin/Users.aspx" class="active">Manage Users</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content">
    <h1>Manage Users</h1>
    <p><asp:Label ID="lblMessage" runat="server" /></p>

    <asp:Repeater ID="rptUsers" runat="server" OnItemCommand="rptUsers_ItemCommand">
      <HeaderTemplate>
        <table>
          <tr><th>Name</th><th>Email</th><th>Role</th><th>Courses</th><th>Actions</th></tr>
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
            <td><b><%# Eval("FullName") %></b></td>
            <td><%# Eval("Email") %></td>
            <td><span class="tag"><%# Eval("Role") %></span></td>
            <td><%# Eval("CourseCount") %></td>
            <td class="actions">
              <asp:Button runat="server" CssClass="btn btn-outline btn-small"
                  Text='<%# Eval("Role").ToString() == "Admin" ? "Make member" : "Make admin" %>'
                  CommandName="ChangeRole" CommandArgument='<%# Eval("UserId") %>' />
              <asp:Button runat="server" Text="Delete" CssClass="btn btn-red btn-small"
                  CommandName="DeleteUser" CommandArgument='<%# Eval("UserId") %>'
                  OnClientClick="return confirm('Delete this user and their enrolments?');" />
            </td>
          </tr>
      </ItemTemplate>
      <FooterTemplate>
        </table>
      </FooterTemplate>
    </asp:Repeater>
  </div>
</div>
</asp:Content>
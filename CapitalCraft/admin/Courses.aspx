<%@ Page Title="Manage courses | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="CapitalCraft.admin.Courses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div id="side-layout">
  <aside id="sidebar">
    <a href="/admin/Dashboard.aspx">Dashboard</a>
    <a href="/admin/Courses.aspx" class="active">Manage Courses</a>
    <a href="/admin/Lessons.aspx">Manage Lessons</a>
    <a href="/admin/Questions.aspx">Manage Questions</a>
    <a href="/admin/Users.aspx">Manage Users</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content">
    <div style="float: right;"><a href="/admin/CourseEdit.aspx" class="btn">+ Add new course</a></div>
    <h1>Manage Courses</h1>
    <p><asp:Label ID="lblMessage" runat="server" /></p>

    <asp:Repeater ID="rptCourses" runat="server" OnItemCommand="rptCourses_ItemCommand">
      <HeaderTemplate>
        <table>
          <tr><th>Course title</th><th>Category</th><th>Lessons</th><th>Enrolled</th><th>Actions</th></tr>
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
            <td><b><%# Eval("Title") %></b></td>
            <td><%# Eval("Category") %></td>
            <td><%# Eval("LessonCount") %></td>
            <td><%# Eval("EnrolledCount") %></td>
            <td class="actions">
              <a href="/admin/CourseEdit.aspx?id=<%# Eval("CourseId") %>" class="btn btn-outline btn-small">Edit</a>
              <asp:Button runat="server" Text="Delete" CssClass="btn btn-red btn-small"
                  CommandName="DeleteCourse" CommandArgument='<%# Eval("CourseId") %>'
                  OnClientClick="return confirm('Delete this course and all its lessons? This cannot be undone.');" />
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
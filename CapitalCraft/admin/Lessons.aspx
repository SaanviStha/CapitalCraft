<%@ Page Title="Manage lessons | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="CapitalCraft.admin.Lessons" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div id="side-layout">
  <aside id="sidebar">
    <a href="/admin/Dashboard.aspx">Dashboard</a>
    <a href="/admin/Courses.aspx">Manage Courses</a>
    <a href="/admin/Lessons.aspx" class="active">Manage Lessons</a>
    <a href="/admin/Questions.aspx">Manage Questions</a>
    <a href="/admin/Users.aspx">Manage Users</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content">
    <div style="float: right;"><a href="/admin/LessonEdit.aspx" class="btn">+ Add new lesson</a></div>
    <h1>Manage Lessons</h1>
    <p><asp:Label ID="lblMessage" runat="server" /></p>

    <asp:Repeater ID="rptLessons" runat="server" OnItemCommand="rptLessons_ItemCommand">
      <HeaderTemplate>
        <table>
          <tr><th>Lesson</th><th>Course</th><th>Actions</th></tr>
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
            <td><b><%# Eval("Title") %></b>
              <%# Eval("ReadingFile").ToString() != "" ? "<span class='tag' title='Has a PDF reading'>PDF</span>" : "" %></td>
            <td><%# Eval("CourseTitle") %></td>
            <td class="actions">
              <a href="/admin/LessonEdit.aspx?id=<%# Eval("LessonId") %>" class="btn btn-outline btn-small">Edit</a>
              <asp:Button runat="server" Text="Delete" CssClass="btn btn-red btn-small"
                  CommandName="DeleteLesson" CommandArgument='<%# Eval("LessonId") %>'
                  OnClientClick="return confirm('Delete this lesson?');" />
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
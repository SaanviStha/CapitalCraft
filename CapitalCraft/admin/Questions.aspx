<%@ Page Title="Manage questions | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Questions.aspx.cs" Inherits="CapitalCraft.admin.Questions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div id="side-layout">
  <aside id="sidebar">
    <a href="/admin/Dashboard.aspx">Dashboard</a>
    <a href="/admin/Courses.aspx">Manage Courses</a>
    <a href="/admin/Lessons.aspx">Manage Lessons</a>
    <a href="/admin/Questions.aspx" class="active">Manage Questions</a>
    <a href="/admin/Users.aspx">Manage Users</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content">
    <div style="float: right;"><asp:HyperLink ID="lnkAdd" runat="server" CssClass="btn" NavigateUrl="/admin/QuestionEdit.aspx">+ Add new question</asp:HyperLink></div>
    <h1>Manage Questions</h1>
    <p class="grey-text">Each course has one quiz, made of the questions below. Members need 60% to pass.</p>

    <label>Show questions for</label>
    <asp:DropDownList ID="ddlCourse" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged" />

    <p><asp:Label ID="lblMessage" runat="server" /></p>

    <asp:Repeater ID="rptQuestions" runat="server" OnItemCommand="rptQuestions_ItemCommand">
      <HeaderTemplate>
        <table>
          <tr><th>Question</th><th>Course</th><th>Correct answer</th><th>Actions</th></tr>
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
            <td><b><%# Server.HtmlEncode(Eval("QuestionText").ToString()) %></b></td>
            <td><%# Eval("CourseTitle") %></td>
            <td><%# Eval("CorrectAnswer") %>. <%# Server.HtmlEncode(Eval("CorrectText").ToString()) %></td>
            <td class="actions">
              <a href="/admin/QuestionEdit.aspx?id=<%# Eval("QuestionId") %>" class="btn btn-outline btn-small">Edit</a>
              <asp:Button runat="server" Text="Delete" CssClass="btn btn-red btn-small"
                  CommandName="DeleteQuestion" CommandArgument='<%# Eval("QuestionId") %>'
                  OnClientClick="return confirm('Delete this question?');" />
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

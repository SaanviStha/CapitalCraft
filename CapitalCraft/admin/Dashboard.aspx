<%@ Page Title="Admin dashboard | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CapitalCraft.admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div id="side-layout">
  <aside id="sidebar">
    <a href="/admin/Dashboard.aspx" class="active">Dashboard</a>
    <a href="/admin/Courses.aspx">Manage Courses</a>
    <a href="/admin/Lessons.aspx">Manage Lessons</a>
    <a href="/admin/Questions.aspx">Manage Questions</a>
    <a href="/admin/Users.aspx">Manage Users</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content" class="dashboard">
    <h1>Admin Dashboard</h1>

    <div class="row-4 stats">
      <div class="box"><p class="grey-text">Users</p>         <p class="stat-number"><asp:Label ID="lblUsers" runat="server" /></p></div>
      <div class="box"><p class="grey-text">Courses</p>       <p class="stat-number"><asp:Label ID="lblCourses" runat="server" /></p></div>
      <div class="box"><p class="grey-text">Lessons</p>       <p class="stat-number"><asp:Label ID="lblLessons" runat="server" /></p></div>
      <div class="box"><p class="grey-text">Enrolments</p>    <p class="stat-number"><asp:Label ID="lblEnrolments" runat="server" /></p></div>
    </div>

    <h2 class="dash-heading">Enrolments per course</h2>
    <div class="box">
      <asp:Repeater ID="rptEnrolments" runat="server">
        <ItemTemplate>
          <div class="bar-row">
            <span class="bar-label"><%# Eval("Title") %></span>
            <span class="bar-track"><span class="bar-fill" style="width: <%# BarWidth(Eval("Enrolled")) %>%;"></span></span>
            <span class="bar-value"><%# Eval("Enrolled") %></span>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>

    <h2 class="dash-heading">Quiz pass rates</h2>
    <p class="grey-text small-text">Pass rate = members whose best score is at least 60%, out of the members who took the quiz.</p>
    <asp:Repeater ID="rptQuizzes" runat="server">
      <HeaderTemplate>
        <table class="quiz-stats">
          <tr><th>Course</th><th>Questions</th><th>Members tried</th><th>Passed</th><th>Pass rate</th><th>Attempts</th><th>Average score</th></tr>
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
            <td><b><%# Eval("Title") %></b></td>
            <td><%# Eval("QuestionCount") %></td>
            <td><%# Eval("Tried") %></td>
            <td><%# Eval("Passed") %></td>
            <td class="rate-cell"><%# PassRate(Eval("Passed"), Eval("Tried")) %></td>
            <td><%# Eval("Attempts") %></td>
            <td><%# Eval("AvgScore") == DBNull.Value ? "–" : Convert.ToDouble(Eval("AvgScore")).ToString("0") + "%" %></td>
          </tr>
      </ItemTemplate>
      <FooterTemplate>
        </table>
      </FooterTemplate>
    </asp:Repeater>
  </div>
</div>
</asp:Content>

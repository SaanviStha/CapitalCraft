<%@ Page Title="My dashboard | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CapitalCraft.member.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div id="side-layout">
  <aside id="sidebar">
    <a href="/member/Dashboard.aspx" class="active">Dashboard</a>
    <a href="/member/MyLearning.aspx">My Learning</a>
    <a href="/member/Profile.aspx">Profile</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content" class="dashboard">
    <h1>Welcome back, <asp:Label ID="lblName" runat="server" /></h1>

    <!-- stats -->
    <div class="row-4 stats">
      <div class="box"><p class="grey-text">Courses enrolled</p>  <p class="stat-number"><asp:Label ID="lblCourses" runat="server" /></p></div>
      <div class="box"><p class="grey-text">Lessons completed</p> <p class="stat-number"><asp:Label ID="lblLessonsDone" runat="server" /></p></div>
      <div class="box"><p class="grey-text">Courses finished</p>  <p class="stat-number"><asp:Label ID="lblFinished" runat="server" /></p></div>
      <div class="box"><p class="grey-text">Quizzes passed</p>    <p class="stat-number"><asp:Label ID="lblQuizzesPassed" runat="server" /></p></div>
    </div>

    <asp:Panel ID="pnlContinue" runat="server" CssClass="box continue-box">
      <div>
        <p class="small-text grey-text"><asp:Label ID="lblContinueHint" runat="server" /></p>
        <h2><asp:Label ID="lblContinueLesson" runat="server" /></h2>
        <p class="small-text grey-text"><asp:Label ID="lblContinueCourse" runat="server" /></p>
      </div>
      <asp:HyperLink ID="lnkContinue" runat="server" CssClass="btn">Continue lesson →</asp:HyperLink>
    </asp:Panel>

    <asp:Panel ID="pnlNoCourses" runat="server" CssClass="box continue-box" Visible="false">
      <div>
        <h2>Start your first course</h2>
        <p class="grey-text small-text">You haven't enrolled in any courses yet. Pick one to begin learning.</p>
      </div>
      <a href="/pages/Courses.aspx" class="btn">Browse courses</a>
    </asp:Panel>

    <asp:PlaceHolder ID="phProgress" runat="server">
    <h2 class="dash-heading">Your progress</h2>
    <asp:Repeater ID="rptProgress" runat="server">
      <HeaderTemplate>
        <table class="progress-table">
          <tr><th>Course</th><th>Progress</th><th>Lessons</th><th>Course quiz</th><th></th></tr>
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
            <td><b><%# Eval("Title") %></b></td>
            <td class="progress-cell">
              <progress value="<%# Eval("Progress") %>" max="100"></progress>
              <span class="small-text"><%# Eval("Progress") %>%</span>
            </td>
            <td class="small-text"><%# LessonsDone(Eval("Progress"), Eval("LessonCount")) %> of <%# Eval("LessonCount") %></td>
            <td class="small-text"><%# QuizStatus(Eval("BestQuiz"), Eval("QuestionCount")) %></td>
            <td class="actions"><a href="<%# ContinueUrl(Eval("CourseId"), Eval("LastLessonId")) %>" class="btn btn-outline btn-small">Open</a></td>
          </tr>
      </ItemTemplate>
      <FooterTemplate>
        </table>
      </FooterTemplate>
    </asp:Repeater>
    </asp:PlaceHolder>

    <h2 class="dash-heading">Recent quiz results</h2>
    <asp:Repeater ID="rptQuizzes" runat="server">
      <HeaderTemplate>
        <table>
          <tr><th>Course</th><th>Score</th><th>Result</th><th>Date</th></tr>
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
            <td><%# Eval("Title") %></td>
            <td><%# Eval("Score") %> / <%# Eval("Total") %> (<%# Eval("Percent") %>%)</td>
            <td><%# (int)Eval("Percent") >= 60 ? "<span class='tag tag-green'>✓ Passed</span>" : "<span class='tag tag-yellow'>Not passed</span>" %></td>
            <td class="small-text"><%# ((DateTime)Eval("TakenOn")).ToString("d MMM yyyy, h:mm tt") %></td>
          </tr>
      </ItemTemplate>
      <FooterTemplate>
        </table>
      </FooterTemplate>
    </asp:Repeater>
    <p class="grey-text small-text"><asp:Label ID="lblNoQuizzes" runat="server" Visible="false"
        Text="You haven't taken a quiz yet. Each course has a quiz after its last lesson." /></p>
  </div>
</div>
</asp:Content>

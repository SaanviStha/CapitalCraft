<%@ Page Title="My learning | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyLearning.aspx.cs" Inherits="CapitalCraft.member.MyLearning" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div id="side-layout">
  <aside id="sidebar">
    <a href="/member/Dashboard.aspx">Dashboard</a>
    <a href="/member/MyLearning.aspx" class="active">My Learning</a>
    <a href="/member/Profile.aspx">Profile</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content">
    <h1>My Learning</h1>

    <asp:Repeater ID="rptMyCourses" runat="server" OnItemCommand="rptMyCourses_ItemCommand">
      <ItemTemplate>
        <div class="box enrolled">
          <img src="<%# Pictures.Course(Eval("Image")) %>" alt="<%# Eval("Title") %>">
          <div>
            <h3><%# Eval("Title") %></h3>
            <progress value="<%# Eval("Progress") %>" max="100"></progress>
            <span class="small-text"><%# Eval("Progress") %>%</span>
            <p class="small-text grey-text quiz-best">
              <%# Eval("BestQuiz") == DBNull.Value ? "Quiz not taken yet"
                    : "Best quiz score: " + Eval("BestQuiz") + "%" + ((int)Eval("BestQuiz") >= 60 ? " ✓ Passed" : "") %>
            </p>
          </div>
          <div>
            <a href="/pages/CourseDetail.aspx?id=<%# Eval("CourseId") %>" class="btn">Continue</a>
            <a href="/pages/Quiz.aspx?course=<%# Eval("CourseId") %>" class="btn btn-outline">Quiz</a>
            <asp:Button runat="server" Text="Unenrol" CssClass="btn btn-outline"
                CommandName="Unenrol" CommandArgument='<%# Eval("CourseId") %>'
                OnClientClick="return confirm('Unenrol from this course?');" />
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>

    <p><asp:Label ID="lblMessage" runat="server" /></p>
  </div>
</div>
</asp:Content>
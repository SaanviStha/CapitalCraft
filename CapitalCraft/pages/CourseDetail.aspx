<%@ Page Title="Course | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="CapitalCraft.pages.CoursesDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

  <section id="hero">
    <div>
      <p class="grey-text small-text"><a href="/Default.aspx">Home</a> / <a href="/pages/Courses.aspx">Courses</a></p>
      <span class="tag"><asp:Label ID="lblCategory" runat="server" /></span>
      <h1><asp:Label ID="lblTitle" runat="server" /></h1>
      <p class="grey-text"><asp:Label ID="lblDescription" runat="server" /></p>

      <asp:Button ID="btnEnrol" runat="server" Text="Enrol & start learning" CssClass="btn btn-gold" OnClick="btnEnrol_Click" />
      <asp:HyperLink ID="lnkContinue" runat="server" CssClass="btn" Visible="false">Continue learning →</asp:HyperLink>
      <asp:HyperLink ID="lnkQuiz" runat="server" CssClass="btn btn-outline" Visible="false">Take the course quiz</asp:HyperLink>
      <p><asp:Label ID="lblMessage" runat="server" /></p>
    </div>
    <asp:Image ID="imgCourse" runat="server" />
  </section>

  <section class="section">
    <h2>Course curriculum</h2>
    <p class="grey-text small-text"><asp:Label ID="lblLessonCount" runat="server" /> lessons</p>

    <ol>
      <asp:Repeater ID="rptLessons" runat="server">
        <ItemTemplate>
          <li><a href="/pages/Lesson.aspx?id=<%# Eval("LessonId") %>"><%# Eval("Title") %></a></li>
        </ItemTemplate>
      </asp:Repeater>
    </ol>
  </section>

</asp:Content>
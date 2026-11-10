<%@ Page Title="Course catalogue | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="CapitalCraft.pages.Courses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

  <section class="section cream">
    <div class="page-width">
      <h1>Course Catalogue</h1>
      <p class="grey-text">Browse all Venture Building courses.</p>

      <div class="search-bar">
        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search courses, e.g. patent, lean startup…" />
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
      </div>
    </div>
  </section>

  <section class="section">
    <div class="row-3 page-width">

      <asp:Repeater ID="rptCourses" runat="server">
        <ItemTemplate>
          <article class="course">
            <a href="/pages/CourseDetail.aspx?id=<%# Eval("CourseId") %>">
              <img src="<%# Pictures.Course(Eval("Image")) %>" alt="<%# Eval("Title") %>">
            </a>
            <span class="tag"><%# Eval("Category") %></span>
            <h3><a href="/pages/CourseDetail.aspx?id=<%# Eval("CourseId") %>"><%# Eval("Title") %></a></h3>
            <p class="grey-text small-text"><%# Server.HtmlEncode(Eval("Description").ToString()) %></p>
          </article>
        </ItemTemplate>
      </asp:Repeater>

    </div>
    <p class="page-width"><asp:Label ID="lblMessage" runat="server" /></p>
  </section>

</asp:Content>
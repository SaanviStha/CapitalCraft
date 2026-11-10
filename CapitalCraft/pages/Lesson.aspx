<%@ Page Title="Lesson | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lesson.aspx.cs" Inherits="CapitalCraft.pages.Lesson" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div class="two-col section">

  <article>
    <p class="grey-text small-text">
      <a href="/pages/CourseDetail.aspx?id=<%= courseId %>"><asp:Label ID="lblCourse" runat="server" /></a>
    </p>
    <h1><asp:Label ID="lblTitle" runat="server" /></h1>

    <asp:Image ID="imgLesson" runat="server" CssClass="lesson-image" Visible="false" />

    <asp:PlaceHolder ID="phVideo" runat="server" Visible="false">
    <figure class="lesson-video">
      <div class="video-frame">
        <iframe src="<%= videoEmbed %>" title="Lesson video: <%= Server.HtmlEncode(lblTitle.Text) %>"
                allow="accelerometer; encrypted-media; gyroscope; picture-in-picture; fullscreen"
                referrerpolicy="strict-origin-when-cross-origin" allowfullscreen loading="lazy"></iframe>
      </div>
      <figcaption class="grey-text small-text">▶ Watch the lesson video, then read the notes below.</figcaption>
    </figure>
    </asp:PlaceHolder>

    <div class="box">
      <asp:Label ID="lblContent" runat="server" />
    </div>

    <asp:PlaceHolder ID="phReading" runat="server" Visible="false">
    <div class="box lesson-reading">
      <span class="reading-icon">PDF</span>
      <div>
        <h3>Lesson reading</h3>
        <p class="grey-text small-text"><%= Server.HtmlEncode(readingName) %> · <%= readingSize %></p>
      </div>
      <a href="/<%= readingFile %>" class="btn btn-outline btn-small" target="_blank" rel="noopener">Open</a>
      <a href="/<%= readingFile %>" class="btn btn-small" download>Download</a>
    </div>
    </asp:PlaceHolder>

    <p style="margin-top: 20px;">
      <asp:Button ID="btnComplete" runat="server" Text="Mark complete" CssClass="btn" OnClick="btnComplete_Click" />
      <asp:HyperLink ID="lnkNext" runat="server" CssClass="btn btn-outline" Visible="false">Next lesson →</asp:HyperLink>
    </p>

    <div class="lesson-status">
      <asp:Label ID="lblMessage" runat="server" />
      <progress id="prgCourse" runat="server" max="100" visible="false"></progress>
    </div>

  </article>

  <aside id="lesson-list" class="box">
    <h3>Course content</h3>
    <ul class="lesson-steps">
      <asp:Repeater ID="rptLessons" runat="server">
        <ItemTemplate>
          <li>
            <span class="tick"><%# Eval("Tick") %></span>
            <span class="num"><%# Container.ItemIndex + 1 %>.</span>
            <a href="/pages/Lesson.aspx?id=<%# Eval("LessonId") %>"><%# Eval("Title") %></a>
          </li>
        </ItemTemplate>
      </asp:Repeater>
    </ul>
  </aside>

</div>
</asp:Content>

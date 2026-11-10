<%@ Page Title="Course quiz | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="CapitalCraft.pages.Quiz" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div class="section quiz-page">
  <p class="grey-text small-text">
    <a href="/pages/CourseDetail.aspx?id=<%= courseId %>"><asp:Label ID="lblCourse" runat="server" /></a> / Course quiz
  </p>
  <h1>Course quiz</h1>
  <p class="grey-text">
    <asp:Label ID="lblIntro" runat="server" />
  </p>

  <p><asp:Label ID="lblBest" runat="server" CssClass="tag tag-yellow" Visible="false" /></p>

  <asp:Panel ID="pnlResult" runat="server" CssClass="box quiz-result" Visible="false">
    <h2><asp:Label ID="lblScore" runat="server" /></h2>
    <p><asp:Label ID="lblVerdict" runat="server" /></p>
    <p>
      <a href="/pages/Quiz.aspx?course=<%= courseId %>" class="btn">Try again</a>
      <a href="/member/MyLearning.aspx" class="btn btn-outline">Back to My Learning</a>
    </p>
  </asp:Panel>

  <!-- questions -->
  <asp:PlaceHolder ID="phQuiz" runat="server">
    <asp:Repeater ID="rptQuestions" runat="server" OnItemDataBound="rptQuestions_ItemDataBound">
      <ItemTemplate>
        <fieldset id="fsQuestion" runat="server" class="box quiz-question">
          <legend><%# Container.ItemIndex + 1 %>. <%# Server.HtmlEncode(Eval("QuestionText").ToString()) %></legend>
          <asp:HiddenField ID="hfQuestionId" runat="server" Value='<%# Eval("QuestionId") %>' />
          <asp:RadioButtonList ID="rblAnswer" runat="server" RepeatLayout="UnorderedList" CssClass="quiz-options" />
          <asp:Label ID="lblFeedback" runat="server" CssClass="quiz-feedback" Visible="false" />
        </fieldset>
      </ItemTemplate>
    </asp:Repeater>

    <p><asp:Label ID="lblMessage" runat="server" ForeColor="#a4553f" /></p>
    <asp:Button ID="btnSubmit" runat="server" Text="Submit answers" CssClass="btn"
        OnClick="btnSubmit_Click" OnClientClick="return checkAllAnswered();" />
  </asp:PlaceHolder>

  <asp:Panel ID="pnlNotice" runat="server" CssClass="box" Visible="false">
    <p><asp:Label ID="lblNotice" runat="server" /></p>
  </asp:Panel>
</div>
</asp:Content>

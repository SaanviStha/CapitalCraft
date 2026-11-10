<%@ Page Title="Add / edit question | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionEdit.aspx.cs" Inherits="CapitalCraft.admin.QuestionEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div class="section">
  <p><asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="/admin/Questions.aspx">← Back to Manage Questions</asp:HyperLink></p>
  <h1><asp:Label ID="lblHeading" runat="server" Text="Add new question" /></h1>

  <div class="box">
    <label>Course *</label>
    <asp:DropDownList ID="ddlCourse" runat="server" />

    <label>Question *</label>
    <asp:TextBox ID="txtQuestion" runat="server" TextMode="MultiLine" Rows="3" MaxLength="500" ValidateRequestMode="Disabled" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtQuestion"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please enter the question." />
    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtQuestion"
        ValidationExpression="^[\s\S]{0,500}$"
        Display="Dynamic" CssClass="validator" ErrorMessage="The question can be up to 500 characters." />

    <label>Option A *</label>
    <asp:TextBox ID="txtOptionA" runat="server" MaxLength="200" CssClass="option-box" ValidateRequestMode="Disabled" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOptionA"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please enter option A." />
    <label>Option B *</label>
    <asp:TextBox ID="txtOptionB" runat="server" MaxLength="200" CssClass="option-box" ValidateRequestMode="Disabled" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOptionB"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please enter option B." />
    <label>Option C *</label>
    <asp:TextBox ID="txtOptionC" runat="server" MaxLength="200" CssClass="option-box" ValidateRequestMode="Disabled" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOptionC"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please enter option C." />
    <label>Option D *</label>
    <asp:TextBox ID="txtOptionD" runat="server" MaxLength="200" CssClass="option-box" ValidateRequestMode="Disabled" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOptionD"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please enter option D." />
    <asp:CustomValidator ID="cvDifferent" runat="server" ClientValidationFunction="checkOptionsDifferent"
        OnServerValidate="cvDifferent_ServerValidate"
        Display="Dynamic" CssClass="validator" ErrorMessage="The four options must all be different." />

    <label>Correct answer *</label>
    <asp:RadioButtonList ID="rblCorrect" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="inline-options">
      <asp:ListItem Value="A">A</asp:ListItem>
      <asp:ListItem Value="B">B</asp:ListItem>
      <asp:ListItem Value="C">C</asp:ListItem>
      <asp:ListItem Value="D">D</asp:ListItem>
    </asp:RadioButtonList>
    <asp:RequiredFieldValidator runat="server" ControlToValidate="rblCorrect"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please choose which option is the correct answer." />

    <p><asp:Label ID="lblMessage" runat="server" ForeColor="#a4553f" /></p>
    <asp:Button ID="btnSave" runat="server" Text="Save question" CssClass="btn" OnClick="btnSave_Click" />
  </div>
</div>
</asp:Content>

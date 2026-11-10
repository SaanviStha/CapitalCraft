<%@ Page Title="Add / edit course | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseEdit.aspx.cs" Inherits="CapitalCraft.admin.CourseEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div class="section">
  <p><a href="/admin/Courses.aspx">← Back to Manage Courses</a></p>
  <h1><asp:Label ID="lblHeading" runat="server" Text="Add new course" /></h1>

  <div class="box">
    <label>Course title *</label>
    <asp:TextBox ID="txtTitle" runat="server" MaxLength="100" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please enter a course title." />

    <label>Category *</label>
    <asp:DropDownList ID="ddlCategory" runat="server">
      <asp:ListItem>Venture</asp:ListItem>
      <asp:ListItem>Intellectual Property</asp:ListItem>
      <asp:ListItem>Technology</asp:ListItem>
      <asp:ListItem>Strategy</asp:ListItem>
      <asp:ListItem>Finance</asp:ListItem>
      <asp:ListItem>Marketing</asp:ListItem>
    </asp:DropDownList>

    <label>Description (up to 500 characters)</label>
    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" ValidateRequestMode="Disabled" />
    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDescription"
        ValidationExpression="^[\s\S]{0,500}$"
        Display="Dynamic" CssClass="validator" ErrorMessage="The description can be up to 500 characters." />

    <label>Course picture * (.jpg, .png or .webp, up to 5 MB)</label>
    <asp:Image ID="imgCurrent" runat="server" Width="200" Visible="false" />
    <asp:FileUpload ID="fuImage" runat="server" accept=".jpg,.jpeg,.png,.webp" />
    <asp:RegularExpressionValidator runat="server" ControlToValidate="fuImage"
        ValidationExpression="^.+\.([jJ][pP][eE]?[gG]|[pP][nN][gG]|[wW][eE][bB][pP])$"
        Display="Dynamic" CssClass="validator" ErrorMessage="Picture must be a .jpg, .png or .webp file." />
    <asp:HiddenField ID="hfImage" runat="server" />

    <p><asp:Label ID="lblMessage" runat="server" ForeColor="#a4553f" /></p>
    <asp:Button ID="btnSave" runat="server" Text="Save course" CssClass="btn" OnClick="btnSave_Click" />
  </div>
</div>
</asp:Content>
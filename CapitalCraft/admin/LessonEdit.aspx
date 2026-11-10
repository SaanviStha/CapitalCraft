<%@ Page Title="Add / edit lesson | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LessonEdit.aspx.cs" Inherits="CapitalCraft.admin.LessonEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div class="section">
  <p><a href="/admin/Lessons.aspx">← Back to Manage Lessons</a></p>
  <h1><asp:Label ID="lblHeading" runat="server" Text="Add new lesson" /></h1>

  <div class="box">
    <label>Course *</label>
    <asp:DropDownList ID="ddlCourse" runat="server" />

    <label>Lesson title *</label>
    <asp:TextBox ID="txtTitle" runat="server" MaxLength="100" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTitle"
        Display="Dynamic" CssClass="validator" ErrorMessage="Please enter a lesson title." />

    <label>Lesson notes</label>
    <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="10" ValidateRequestMode="Disabled" />

    <label>Lesson picture (optional: .jpg, .png or .webp, up to 5 MB)</label>
    <asp:Image ID="imgCurrent" runat="server" Width="200" Visible="false" />
    <asp:FileUpload ID="fuImage" runat="server" accept=".jpg,.jpeg,.png,.webp" />
    <asp:RegularExpressionValidator runat="server" ControlToValidate="fuImage"
        ValidationExpression="^.+\.([jJ][pP][eE]?[gG]|[pP][nN][gG]|[wW][eE][bB][pP])$"
        Display="Dynamic" CssClass="validator" ErrorMessage="Picture must be a .jpg, .png or .webp file." />
    <asp:HiddenField ID="hfImage" runat="server" />

    <label>YouTube video link (optional)</label>
    <asp:TextBox ID="txtVideo" runat="server" TextMode="Url" MaxLength="300" placeholder="https://www.youtube.com/watch?v=..." />
    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtVideo"
        ValidationExpression="^\s*(https?://)?(www\.|m\.)?(youtube\.com|youtu\.be)/\S+\s*$"
        Display="Dynamic" CssClass="validator" ErrorMessage="Video link must be a YouTube link, e.g. https://www.youtube.com/watch?v=..." />
    <p class="grey-text small-text">Paste the link from the browser's address bar or YouTube's Share button. Leave empty for no video.</p>

    <label>Reading (optional: PDF only, up to 10 MB)</label>
    <asp:PlaceHolder ID="phCurrentReading" runat="server" Visible="false">
      <p class="small-text">
        Current PDF: <asp:HyperLink ID="lnkCurrentReading" runat="server" Target="_blank" />
        <asp:CheckBox ID="chkRemoveReading" runat="server" Text="Remove this PDF" CssClass="check-option" />
      </p>
    </asp:PlaceHolder>
    <asp:FileUpload ID="fuReading" runat="server" accept=".pdf,application/pdf" onchange="checkPdf(this, 10)" />
    <asp:RegularExpressionValidator runat="server" ControlToValidate="fuReading"
        ValidationExpression="^.+\.[pP][dD][fF]$"
        Display="Dynamic" CssClass="validator" ErrorMessage="Reading must be a PDF file (.pdf)." />
    <asp:HiddenField ID="hfReading" runat="server" />
    <p class="grey-text small-text">Choosing a new PDF replaces the current one.</p>

    <p><asp:Label ID="lblMessage" runat="server" ForeColor="#a4553f" /></p>
    <asp:Button ID="btnSave" runat="server" Text="Save lesson" CssClass="btn" OnClick="btnSave_Click" />
  </div>
</div>
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CapitalCraft.pages.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Log in | Capital Craft</title>
  <link rel="stylesheet" href="/css/style.css?v=37">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap">
</head>
<body>
  <form runat="server">
    <div id="login-page">

      <div id="login-left">
        <a href="/Default.aspx" id="logo"><span class="logo-mark">CC</span>Capital Craft</a>
        <h1>Build. Protect. Transfer. Launch.</h1>
        <img src="/images/mindset.jpg" alt="Mindset is everything: a pawn casting a king's shadow">
      </div>

      <div id="login-right">
        <div id="login-form">
          <p class="back-link"><a href="/Default.aspx">← Back to home</a></p>
          <h2>Welcome back</h2>

          <label for="txtEmail">Email</label>
          <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" required="required" data-required="Please enter your email." />
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" EnableClientScript="false"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter your email." />
          <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" EnableClientScript="false"
              ValidationExpression="^\s*[^\s@]+@[^\s@]+\.[^\s@]+\s*$"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter a valid email address, e.g. name@example.com." />

          <label for="txtPw">Password</label>
          <asp:TextBox ID="txtPw" runat="server" TextMode="Password" required="required" data-required="Please enter your password." />
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPw" EnableClientScript="false"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter your password." />

          <p class="form-message"><asp:Label ID="lblMessage" runat="server" ForeColor="#a4553f" /></p>

          <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="btn" OnClick="btnLogin_Click" />

          <p>New here? <a id="lnkRegister" runat="server" href="Register.aspx">Create an account</a></p>
        </div>
      </div>

    </div>
  </form>
  <script src="/js/script.js?v=25"></script>
</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CapitalCraft.Register" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Create your account | Capital Craft</title>
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
          <h2>Create your free account</h2>

          <div class="name-row">
            <div>
              <label for="txtFirst">First name</label>
              <asp:TextBox ID="txtFirst" runat="server" MaxLength="50" required="required" data-required="Please enter your first name." />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirst" EnableClientScript="false"
                  Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter your first name." />
            </div>
            <div>
              <label for="txtLast">Last name</label>
              <asp:TextBox ID="txtLast" runat="server" MaxLength="49" required="required" data-required="Please enter your last name." />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLast" EnableClientScript="false"
                  Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter your last name." />
            </div>
          </div>

          <label for="txtEmail">Email</label>
          <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" MaxLength="100" required="required" data-required="Please enter your email." />
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" EnableClientScript="false"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter your email." />
          <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" EnableClientScript="false"
              ValidationExpression="^\s*[^\s@]+@[^\s@]+\.[^\s@]+\s*$"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter a valid email address, e.g. name@example.com." />

          <label for="txtPw">Password</label>
          <asp:TextBox ID="txtPw" runat="server" TextMode="Password" required="required" minlength="8"
              data-required="Please enter a password." data-minlength="8" />
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPw" EnableClientScript="false"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Please enter a password." />
          <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPw" EnableClientScript="false"
              ValidationExpression="^[\s\S]{8,}$"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Password must be at least 8 characters." />
          <p id="pw-hint" class="pw-hint" hidden>Minimum 8 characters</p>

          <label for="txtPw2">Confirm password</label>
          <asp:TextBox ID="txtPw2" runat="server" TextMode="Password" required="required"
              data-required="Please type your password again." data-match="txtPw" />
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPw2" EnableClientScript="false"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Please type your password again." />
          <asp:CompareValidator runat="server" ControlToValidate="txtPw2" ControlToCompare="txtPw" EnableClientScript="false"
              Display="Dynamic" CssClass="field-error" ErrorMessage="Passwords do not match." />

          <p class="form-message"><asp:Label ID="lblMessage" runat="server" ForeColor="#a4553f" /></p>

          <asp:Button ID="btnRegister" runat="server" Text="Create account" CssClass="btn" OnClick="btnRegister_Click" />

          <p>Already have an account? <a id="lnkLogin" runat="server" href="Login.aspx">Log in</a></p>
        </div>
      </div>

    </div>
  </form>
  <script src="/js/script.js?v=25"></script>
</body>
</html>
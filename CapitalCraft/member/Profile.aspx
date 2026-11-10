<%@ Page Title="Profile &amp; settings | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="CapitalCraft.member.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<div id="side-layout">
  <aside id="sidebar">
    <a href="/member/Dashboard.aspx">Dashboard</a>
    <a href="/member/MyLearning.aspx">My Learning</a>
    <a href="/member/Profile.aspx" class="active">Profile</a>
    <a href="/pages/Logout.aspx">Log out</a>
  </aside>

  <div id="content">
    <h1>Profile &amp; settings</h1>

    <div class="box">
      <h3>Personal details</h3>
      <label>Full name</label>
      <asp:TextBox ID="txtName" runat="server" MaxLength="100" />
      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ValidationGroup="details"
          Display="Dynamic" CssClass="validator" ErrorMessage="Please enter your name." />

      <label>Email</label>
      <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" MaxLength="100" />
      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ValidationGroup="details"
          Display="Dynamic" CssClass="validator" ErrorMessage="Please enter your email." />
      <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationGroup="details"
          ValidationExpression="^\s*[^\s@]+@[^\s@]+\.[^\s@]+\s*$"
          Display="Dynamic" CssClass="validator" ErrorMessage="Please enter a valid email address, e.g. name@example.com." />

      <asp:Button ID="btnSave" runat="server" Text="Save changes" CssClass="btn" ValidationGroup="details" OnClick="btnSave_Click" />
      <p><asp:Label ID="lblDetailsMsg" runat="server" /></p>
    </div>

    <div class="box" style="margin-top: 20px;">
      <h3>Change password</h3>
      <label>Current password</label>
      <asp:TextBox ID="txtOldPw" runat="server" TextMode="Password" />
      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOldPw" ValidationGroup="password"
          Display="Dynamic" CssClass="validator" ErrorMessage="Please enter your current password." />

      <label>New password (min. 8 characters)</label>
      <asp:TextBox ID="txtNewPw" runat="server" TextMode="Password" />
      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPw" ValidationGroup="password"
          Display="Dynamic" CssClass="validator" ErrorMessage="Please enter a new password." />
      <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNewPw" ValidationGroup="password"
          ValidationExpression="^[\s\S]{8,}$"
          Display="Dynamic" CssClass="validator" ErrorMessage="New password must be at least 8 characters." />

      <label>Confirm new password</label>
      <asp:TextBox ID="txtNewPw2" runat="server" TextMode="Password" />
      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPw2" ValidationGroup="password"
          Display="Dynamic" CssClass="validator" ErrorMessage="Please type the new password again." />
      <asp:CompareValidator runat="server" ControlToValidate="txtNewPw2" ControlToCompare="txtNewPw" ValidationGroup="password"
          Display="Dynamic" CssClass="validator" ErrorMessage="The new passwords do not match." />

      <asp:Button ID="btnPassword" runat="server" Text="Update password" CssClass="btn" ValidationGroup="password" OnClick="btnPassword_Click" />
      <p><asp:Label ID="lblPwMsg" runat="server" /></p>
    </div>

    <div class="box" style="margin-top: 20px;">
      <h3>Delete account</h3>
      <asp:Button ID="btnDelete" runat="server" Text="Delete my account" CssClass="btn btn-outline"
          CausesValidation="false" OnClick="btnDelete_Click"
          OnClientClick="return confirm('Delete your account? This cannot be undone.');" />
    </div>
  </div>
</div>
</asp:Content>

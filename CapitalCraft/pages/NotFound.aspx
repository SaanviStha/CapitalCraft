<%@ Page Title="Page not found | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NotFound.aspx.cs" Inherits="CapitalCraft.pages.NotFound" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<section class="section error-page">
  <p class="error-code">404</p>
  <h1>Page not found</h1>
  <p class="grey-text">
    Sorry, we couldn't find the page you were looking for. It may have been moved or deleted,
    or the address may have a typing mistake.
  </p>
  <p class="error-actions">
    <a href="/Default.aspx" class="btn">Go to the home page</a>
    <a href="/pages/Courses.aspx" class="btn btn-outline">Browse courses</a>
  </p>
</section>
</asp:Content>

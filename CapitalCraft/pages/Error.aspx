<%@ Page Title="Something went wrong | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="CapitalCraft.pages.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
<section class="section error-page">
  <p class="error-code">Oops</p>
  <h1>Something went wrong</h1>
  <p class="grey-text">
    Sorry, something went wrong on our side while loading this page.
    Please go back and try again in a moment.
  </p>
  <p class="error-actions">
    <a href="/Default.aspx" class="btn">Go to the home page</a>
    <a href="/pages/Courses.aspx" class="btn btn-outline">Browse courses</a>
  </p>
</section>
</asp:Content>

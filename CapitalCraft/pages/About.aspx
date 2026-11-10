<%@ Page Title="About us | Capital Craft" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="CapitalCraft.pages.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <style>
    .persona {
      display: grid;
      grid-template-columns: 48px 1fr;
      gap: 12px;
      align-items: center;
    }

    /* team cards */
    .team-card {
      margin: 0;
      text-align: center;
    }
    .team-card .team-photo {
      display: block;
      width: 100%;
      max-width: 160px;
      aspect-ratio: 1 / 1;
      margin: 0 auto;
      border-radius: 10px;
      object-fit: cover;
      object-position: center 22%;
    }
    .team-card figcaption {
      font-weight: 600;
      font-size: 14px;
      margin-top: 12px;
    }
  </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">

  <section class="section cream">
    <div class="page-width">
    <span class="tag">About us</span>
    <h1 style="max-width: 720px; margin: 12px 0;">We turn curious learners into confident venture builders.</h1>
    <p class="grey-text" style="max-width: 640px;">Capital Craft is a web-based learning system that makes venture building accessible to university students and early-stage founders through interactive, multimedia-rich learning.</p>
    </div>
  </section>

  <section class="section" style="padding: 40px 5%;">
    <div class="row-2 page-width">
      <article class="box">
        <h3>Our mission</h3>
        <p class="grey-text">To equip the next generation of entrepreneurs with the knowledge to build innovation-driven enterprises, protect their intellectual property and bring research from the lab to the marketplace.</p>
      </article>
      <article class="box">
        <h3>Objectives</h3>
        <ul style="list-style: none; padding: 0;">
          <li>✓ Deliver structured modules on venture building, IP and technology transfer.</li>
          <li>✓ Offer video lessons, readings and self-assessment quizzes.</li>
          <li>✓ Let members track progress across every course.</li>
        </ul>
      </article>
    </div>
  </section>

  <section class="section cream">
    <div class="page-width">
    <h2>Who Capital Craft is for</h2>
    <div class="row-3" style="margin-top: 24px;">
      <article class="box">
        <div class="persona">
          <span class="avatar">A</span>
          <div>
            <h4 style="margin: 0;"> Alok, 20</h4>
            <p class="grey-text small-text" style="margin: 0;">Aspiring founder (undergraduate)</p>
          </div>
        </div>
        <p class="small-text" style="margin-top: 12px;">Goal: Wants to validate a startup idea and understand SME vs IDE growth paths.</p>
      </article>
      <article class="box">
        <div class="persona">
          <span class="avatar">S</span>
          <div>
            <h4 style="margin: 0;"> Saleena, 30</h4>
            <p class="grey-text small-text" style="margin: 0;">University researcher / inventor</p>
          </div>
        </div>
        <p class="small-text" style="margin-top: 12px;">Goal: Needs to know how to patent, license and transfer lab technology.</p>
      </article>
      <article class="box">
        <div class="persona">
          <span class="avatar">S</span>
          <div>
            <h4 style="margin: 0;"> Sugan, 35</h4>
            <p class="grey-text small-text" style="margin: 0;">Intrapreneur at a corporate</p>
          </div>
        </div>
        <p class="small-text" style="margin-top: 12px;">Goal: Wants to drive innovation inside an established organisation.</p>
      </article>
    </div>
    </div>
  </section>

  <section class="section">
    <div class="page-width">
    <h2>Meet the team</h2>
    <div class="row-4" style="margin-top: 24px;">
      <figure class="box team-card">
        <img src="/images/team-roshni.jpg" alt="Roshni Kumari Shah" class="team-photo">
        <figcaption>Roshni K. Shah</figcaption>
      </figure>
      <figure class="box team-card">
        <img src="/images/team-saanvi.jpg" alt="Saanvi Shrestha" class="team-photo">
        <figcaption>Saanvi Shrestha</figcaption>
      </figure>
      <figure class="box team-card">
        <img src="/images/team-sadiksha.jpg" alt="Sadiksha Timsina" class="team-photo">
        <figcaption>Sadiksha Timsina</figcaption>
      </figure>
      <figure class="box team-card">
        <img src="/images/team-shirsha.jpg" alt="Shirsha Bhandari" class="team-photo">
        <figcaption>Shirsha Bhandari</figcaption>
      </figure>
    </div>
    </div>
  </section>

  <section class="section cream">
    <div class="page-width">
    <h2>Have questions about our courses?</h2>
    <a href="/pages/Courses.aspx" class="btn btn-outline" style="margin-top: 10px;">Browse courses</a>
    </div>
  </section>

</asp:Content>


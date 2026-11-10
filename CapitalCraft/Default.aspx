<%@ Page Title="Capital Craft | Learn to build ventures" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CapitalCraft.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <style>
    /* learning path */
    .learning-path li { padding-top: 14px; border-top: 2px solid #e7ddce; }
    .learning-path h3 { margin: 4px 0 6px; font-size: 18px; }
    .learning-path p { margin: 0; }
    .step-number {
      font-size: 26px;
      font-weight: bold;
      color: #8f6b4c;
      margin: 0;
    }

    .hero-title { font-size: 46px; line-height: 1.1; margin: 16px 0 20px; }

    /* quote */
    .quote-section {
      display: grid;
      grid-template-columns: 180px 1fr;
      gap: 40px;
      align-items: center;
      padding: 50px 5%;
    }
    .quote-section img { aspect-ratio: 4 / 5; object-fit: cover; }

    #deck-hero,
    .quote-section { padding-left: max(5%, calc((100% - 1200px) / 2)); padding-right: max(5%, calc((100% - 1200px) / 2)); }

    /* mobile */
    @media (max-width: 700px) {
      .hero-title { font-size: 32px; }
      #deck-hero { padding-left: 16px; padding-right: 16px; }
      .quote-section { grid-template-columns: 1fr; gap: 20px; padding: 40px 16px; }
      .quote-section img { max-width: 160px; }
      .quote-section blockquote { font-size: 18px !important; }
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

  <section id="deck-hero">
    <div class="deck-hero-text">
      <span class="tag">Venture Building · E-learning Platform</span>
      <h1 class="hero-title">Craft ideas into ventures that scale.</h1>
      <p class="grey-text">Capital Craft is an interactive learning platform for aspiring founders, engineers and intrapreneurs.</p>
      <a href="/pages/Courses.aspx" class="btn">Browse all courses</a>
    </div>

    <div class="deck-area">
      <div id="deck" class="deck" tabindex="0">
        <asp:Repeater ID="rptDeck" runat="server">
          <ItemTemplate>
            <a class="deck-card" href="/pages/CourseDetail.aspx?id=<%# Eval("CourseId") %>">
              <img src="<%# Pictures.Course(Eval("Image")) %>" alt="">
              <div class="deck-card-body">
                <span class="tag"><%# Eval("Category") %></span>
                <h3><%# Eval("Title") %></h3>
                <p class="grey-text small-text"><%# Eval("LessonCount") %> lessons · Self-paced</p>
              </div>
            </a>
          </ItemTemplate>
        </asp:Repeater>
      </div>

      <div class="deck-controls">
        <button type="button" id="deck-prev" class="deck-arrow">←</button>
        <span id="deck-count"></span>
        <button type="button" id="deck-next" class="deck-arrow">→</button>
      </div>
    </div>
  </section>

  <section class="section">
    <div class="page-width">
    <h2>Your venture-building learning path</h2>
    <ol class="row-4 learning-path" style="list-style: none; padding: 0; margin-top: 24px; gap: 28px;">
      <li><p class="step-number">01</p><h3>Discover</h3><p class="grey-text small-text">Entrepreneurship, SME vs IDE, and searching for a business model.</p></li>
      <li><p class="step-number">02</p><h3>Protect</h3><p class="grey-text small-text">Patents, trademarks, copyright and trade secrets for your venture.</p></li>
      <li><p class="step-number">03</p><h3>Transfer</h3><p class="grey-text small-text">Models of technology transfer and open innovation.</p></li>
      <li><p class="step-number">04</p><h3>Launch</h3><p class="grey-text small-text">Apply it all to your own venture idea.</p></li>
    </ol>
    </div>
  </section>

  <section class="cream quote-section">
    <img src="/images/success-cycle.jpg" alt="Doodle of the cycle think, idea, try, do again, success" style="width: 100%; border-radius: 10px;">
    <div>
      <blockquote style="margin: 0; font-size: 22px; font-weight: 600;">
        “In the face of the unknown future, entrepreneurs ACT. They take small smart steps, learn from these steps, build that learning into what they do next — and act again.”
      </blockquote>
      <p class="grey-text" style="margin-top: 18px;">— Saras Sarasvathy</p>
    </div>
  </section>

</asp:Content>

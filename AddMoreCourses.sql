-- 3 more courses, 8 lessons each

DECLARE @c INT;

-- Course 4: Business Model Canvas
INSERT INTO Courses (Title, Category, Description, Image) VALUES
(N'Business Model Canvas & Value Proposition', N'Strategy',
 N'Map how a venture creates, delivers and captures value using the nine blocks of the Business Model Canvas, and design offers customers actually want with the Value Proposition Canvas.',
 N'images/business-model-canvas.webp');
SELECT @c = CourseId FROM Courses WHERE Title = N'Business Model Canvas & Value Proposition';

INSERT INTO Lessons (CourseId, Title, Content) VALUES
(@c, N'What is a business model?',
N'A business model describes how an organisation creates, delivers and captures value. In simple words: who your customers are, what you offer them, and how you make money while doing it.

Two ventures can sell almost the same product with very different business models. For example, one music company sells albums, while another earns from monthly subscriptions.

Why it matters:
- A good product with a weak business model can still fail.
- Startups are still searching for a model that works, so they need a quick way to describe and test it.

In this course you will use the Business Model Canvas, created by Alexander Osterwalder and Yves Pigneur, to describe a business model on a single page.'),

(@c, N'The nine building blocks of the canvas',
N'The Business Model Canvas splits a business model into nine building blocks:

1. Customer Segments: the groups of people or organisations you serve.
2. Value Propositions: the problems you solve and the benefits you give.
3. Channels: how you reach and deliver to customers.
4. Customer Relationships: how you win, keep and grow customers.
5. Revenue Streams: how each segment pays you.
6. Key Resources: the most important assets you need.
7. Key Activities: the most important things you must do.
8. Key Partnerships: suppliers and partners who help you.
9. Cost Structure: the main costs of running the model.

The right side of the canvas (blocks 1 to 5) is about value and customers. The left side (blocks 6 to 9) is about efficiency and costs.'),

(@c, N'Customer segments and value propositions',
N'Every canvas starts with two questions: who are we creating value for, and what value are we offering them?

Customer segments can be:
- Mass market: one large group with similar needs.
- Niche market: a small, specialised group.
- Multi-sided: two or more groups that need each other, such as drivers and riders on a ride-hailing app.

A value proposition is the reason a customer chooses you over someone else. It can come from newness, better performance, customisation, design, a lower price, convenience or reduced risk.

Tip: write one value proposition for each segment. If two segments need very different things, they probably need different value propositions.'),

(@c, N'Channels and customer relationships',
N'Channels are the touch points between you and your customers. A channel helps customers find out about you, evaluate your offer, buy it, receive it and get support afterwards.

Channels can be direct (your own website, app or sales team) or indirect (retailers, distributors and partner platforms). Direct channels give more control and margin; indirect channels give more reach.

Customer relationships describe the kind of contact each segment expects:
- Personal assistance, such as a support team.
- Self-service and automated services.
- Communities, where users help each other.
- Co-creation, where customers help build the product, such as user reviews.

Choose relationships that match both what customers want and what you can afford.'),

(@c, N'Revenue streams and cost structure',
N'Revenue streams show how each customer segment pays. Common types are:
- Asset sale: selling ownership of a product.
- Usage fee: paying per use, such as per ride or per gigabyte.
- Subscription: paying regularly for ongoing access.
- Licensing: paying to use protected intellectual property.
- Advertising: a third party pays to reach your users.

The cost structure lists the most important costs. Some businesses are cost-driven and try to keep every cost as low as possible, like budget airlines. Others are value-driven and focus on premium value, like luxury hotels.

A business model only works when the revenue streams can cover the cost structure over time.'),

(@c, N'Key resources, activities and partners',
N'The left side of the canvas describes the engine behind your value proposition.

Key resources can be physical (factories, equipment), intellectual (patents, brands, data), human (skilled staff) or financial (cash and credit).

Key activities are the things you must do well, such as production, problem solving for clients, or running a platform.

Key partnerships help you reduce risk, lower costs or get resources you do not own. Examples include suppliers, joint ventures and strategic alliances between non-competitors.

Remember the links to earlier courses: a patent is a key resource, and a licensing deal is a key partnership.'),

(@c, N'The Value Proposition Canvas',
N'The Value Proposition Canvas zooms in on two blocks of the Business Model Canvas: Customer Segments and Value Propositions.

The customer profile (circle) lists:
- Customer jobs: what customers are trying to get done.
- Pains: what annoys them or gets in their way.
- Gains: the outcomes and benefits they want.

The value map (square) lists:
- Products and services you offer.
- Pain relievers: how you reduce specific pains.
- Gain creators: how you create specific gains.

You achieve "fit" when your pain relievers and gain creators match the most important jobs, pains and gains of your customers. Fit is a guess until real customers confirm it.'),

(@c, N'Case study: the razor-and-blades model',
N'The razor-and-blades model is a well-known business model pattern. A company sells a basic product cheaply, sometimes at a loss, and earns its profit from repeat purchases of consumables.

Gillette made this pattern famous: razor handles were cheap, but the replacement blades were sold again and again at a healthy margin. Nespresso uses a similar idea with coffee machines and coffee capsules.

On the canvas:
- Revenue Streams: low one-off sale plus frequent repeat purchases.
- Key Resources: patents that stop rivals making compatible blades or capsules.
- Customer Relationships: long-term, built on habit.

Activity: sketch a canvas for a product you use that follows this pattern, such as a printer and its ink.');

-- Course 5: Startup Funding
INSERT INTO Courses (Title, Category, Description, Image) VALUES
(N'Startup Funding & Pitching', N'Finance',
 N'From bootstrapping to venture capital: understand the main sources of startup funding, how equity and dilution work, and how to build and deliver a pitch that wins investors.',
 N'images/startup-funding.png');
SELECT @c = CourseId FROM Courses WHERE Title = N'Startup Funding & Pitching';

INSERT INTO Lessons (CourseId, Title, Content) VALUES
(@c, N'Why startups need funding',
N'Most startups spend money before they earn it. They need cash to build a product, test it with customers, hire a team and grow.

The money a startup has in the bank, divided by how much it spends each month (its "burn rate"), gives its runway: how many months it can survive before it runs out of cash.

Example: a startup with RM 300,000 in the bank that spends RM 25,000 a month has a runway of 12 months.

Funding is not a goal in itself. Every source of money comes with conditions, such as giving away ownership, paying back a loan or reporting progress. In this course you will compare these sources and learn when each one makes sense.'),

(@c, N'Bootstrapping and friends & family',
N'Bootstrapping means growing the business with your own savings and the money it earns from customers, without outside investors.

Advantages:
- You keep full ownership and control.
- It forces discipline: you focus on customers who pay.

Disadvantages:
- Growth can be slow.
- Your personal savings are at risk.

The next step for many founders is the "friends, family and fools" round: small amounts from people who trust the founder rather than the business plan.

Tip: treat friends and family like real investors. Put the agreement in writing, explain the risk clearly, and only accept money they can afford to lose.'),

(@c, N'Angel investors',
N'Angel investors are wealthy individuals who invest their own money in early-stage startups, usually in exchange for equity (a share of ownership).

What angels typically offer:
- Smaller cheques than venture capital, at a very early stage.
- Experience, advice and introductions to customers or later investors.
- Faster decisions, because they invest their own money.

Many angels invest through angel networks or syndicates, where several angels share the research and invest together.

Angels look for a strong founding team, a large problem, early signs of traction and a clear plan for what the money will achieve. Choose angels whose experience fits your industry; good advice can be worth more than the money.'),

(@c, N'Venture capital and funding rounds',
N'Venture capital (VC) firms invest money from a fund, raised from institutions and wealthy individuals, into high-growth startups. They expect most investments to fail, so each one must have the potential to return the whole fund.

Startups usually raise money in rounds:
- Pre-seed and seed: proving the idea and finding early customers.
- Series A: growing a product that has shown product-market fit.
- Series B, C and later: scaling up, entering new markets or acquiring other firms.

VC is a good fit for innovation-driven enterprises (IDEs) aiming for fast, exponential growth. It is usually not a good fit for SMEs that grow steadily, because VCs need a large return within roughly 7 to 10 years, often through an acquisition or stock market listing.'),

(@c, N'Equity, valuation and dilution',
N'When investors buy equity, they buy a percentage of the company. The price depends on the company''s valuation.

- Pre-money valuation: what the company is worth before the investment.
- Post-money valuation: pre-money valuation plus the new investment.

Example: a startup is valued at RM 2 million pre-money and raises RM 500,000. The post-money valuation is RM 2.5 million, so the investor owns 500,000 / 2,500,000 = 20%.

Dilution is the fall in the founders'' percentage when new shares are issued. If the founders owned 100% before, they now own 80%.

Dilution is not automatically bad: owning 80% of a larger, better-funded company can be worth more than 100% of a small one.'),

(@c, N'Crowdfunding and grants',
N'Crowdfunding raises small amounts of money from a large number of people, usually online.
- Reward-based: backers receive the product or a reward, as on Kickstarter.
- Equity crowdfunding: backers receive shares in the company.
- Debt crowdfunding (peer-to-peer lending): backers lend money and are paid back with interest.

A successful campaign also proves demand, because people pay before the product exists.

Grants are funds from governments, universities or foundations that usually do not have to be repaid and do not take equity. In Malaysia, for example, agencies such as Cradle Fund support early-stage technology ventures.

Grants are attractive but competitive, and they often come with strict reporting rules and limits on how the money can be spent.'),

(@c, N'Building a pitch deck',
N'A pitch deck is a short presentation that explains your venture to investors. A common structure is:

1. Problem: the pain your customers feel.
2. Solution: how your product solves it.
3. Market: how big the opportunity is.
4. Product: a demo or screenshots.
5. Business model: how you make money.
6. Traction: customers, sales or other proof so far.
7. Competition: alternatives and why you are different.
8. Team: why you are the right people.
9. Financials: key numbers and forecasts.
10. The ask: how much you are raising and what it will achieve.

Guy Kawasaki''s 10/20/30 rule is a useful guide: about 10 slides, no more than 20 minutes, and no text smaller than 30 points.'),

(@c, N'Delivering your pitch and next steps',
N'A pitch is a conversation, not a speech. Investors judge the team as much as the slides.

Tips for delivery:
- Prepare an elevator pitch: a clear 30 to 60 second summary of what you do and why it matters.
- Tell a story: start with a real customer and their problem.
- Know your numbers: market size, costs, runway and how you will use the money.
- Answer questions honestly. Saying "I don''t know, but I will find out" is better than guessing.

If investors are interested, the next steps are usually a term sheet (a short document listing the main terms of the deal) and due diligence, where investors check your company''s legal, financial and technical details before they invest.');

-- Course 6: Customer Discovery
INSERT INTO Courses (Title, Category, Description, Image) VALUES
(N'Customer Discovery & Market Validation', N'Marketing',
 N'Test your idea before you build it: customer development, writing testable hypotheses, interviewing customers, sizing your market, running MVP experiments and recognising product-market fit.',
 N'images/customer-discovery.webp');
SELECT @c = CourseId FROM Courses WHERE Title = N'Customer Discovery & Market Validation';

INSERT INTO Lessons (CourseId, Title, Content) VALUES
(@c, N'Why customer discovery matters',
N'Many startups fail not because they cannot build their product, but because nobody wants it badly enough to pay for it. "No market need" is regularly reported as one of the most common reasons startups shut down.

Customer discovery means finding out, as early and cheaply as possible, whether a real problem exists and whether your idea solves it.

Ask yourself:
- Who exactly has this problem?
- How do they solve it today?
- How painful or costly is it for them?
- Would they pay for a better solution?

In this course you will learn methods to answer these questions with evidence, instead of opinions.'),

(@c, N'Steve Blank''s customer development model',
N'Steve Blank, whose ideas strongly influenced the Lean Startup, argued that startups need a customer development process alongside product development.

His model has four steps:
1. Customer discovery: test whether the problem and your proposed solution matter to customers.
2. Customer validation: prove that customers will actually buy, and that sales can be repeated.
3. Customer creation: create demand and grow the customer base.
4. Company building: move from a searching startup to a company executing a proven model.

The first two steps are about searching for a business model; the last two are about executing it. If validation fails, you go back to discovery and pivot, rather than spending heavily on growth.'),

(@c, N'Writing testable hypotheses',
N'Every block on your business model canvas is a guess until it is tested. Turning guesses into clear hypotheses makes them testable.

A useful format is:
"We believe that [customer segment] has a problem with [problem]. We will know we are right when [measurable result]."

Example: "We believe that university students struggle to find affordable textbooks. We will know we are right when at least 40 out of 100 students surveyed say they spent more than RM 300 on books last semester."

Good hypotheses are:
- Specific: one customer, one problem.
- Measurable: they include a number.
- Falsifiable: the result could prove you wrong.

Start by testing your riskiest hypothesis first.'),

(@c, N'Running customer interviews',
N'Customer interviews are the fastest way to learn about a problem. The hard part is getting honest answers, because people often say nice things to avoid hurting your feelings.

Rob Fitzpatrick''s book "The Mom Test" gives three simple rules:
1. Talk about their life, not your idea.
2. Ask about specific things that happened in the past, not opinions about the future.
3. Talk less and listen more.

Weak question: "Would you use an app that does this?"
Better question: "When did you last have this problem? What did you do about it? How much did it cost you?"

After each interview, write down what you learned and which hypothesis it supports or rejects.'),

(@c, N'Sizing your market: TAM, SAM and SOM',
N'Investors and founders need to know whether a market is big enough. Three numbers are commonly used:

- TAM (Total Addressable Market): total demand for your type of product if you had 100% of the market.
- SAM (Serviceable Available Market): the part of the TAM your business model and location can actually reach.
- SOM (Serviceable Obtainable Market): the share of the SAM you can realistically win in the next few years.

Example: an online tutoring startup might calculate all tutoring spending in Southeast Asia (TAM), then spending on online tutoring in Malaysia (SAM), then the share it could win in three years (SOM).

A bottom-up estimate (number of customers multiplied by price) is usually more convincing than a top-down guess.'),

(@c, N'Types of minimum viable product',
N'A minimum viable product (MVP) is the smallest thing you can build to test a hypothesis with real customers. It does not need to be a finished product.

Common types:
- Landing page (smoke test): describe the product and measure how many visitors sign up or pre-order.
- Explainer video: show how the product would work. Dropbox famously used a short demo video to test interest before the product was fully built.
- Concierge MVP: deliver the service by hand to a few customers.
- Wizard of Oz MVP: the product looks automated, but a person does the work behind the scenes.
- Prototype: a clickable mock-up or a simple working version.

Choose the cheapest MVP that can still prove or disprove your riskiest hypothesis.'),

(@c, N'Measuring validation with the right metrics',
N'An experiment is only useful if you measure the right thing. Eric Ries warns against vanity metrics: numbers that look impressive but do not guide decisions, such as total page views or app downloads.

Actionable metrics show real behaviour and link cause to effect:
- Conversion rate: what percentage of visitors sign up or buy.
- Pre-orders or deposits: people paying before launch.
- Retention: how many users come back after one week or one month.
- Referral: how many users invite others.

Decide your success target before you run the experiment. For example: "If at least 5% of landing page visitors join the waiting list, we continue; if not, we change the value proposition."'),

(@c, N'Product-market fit and when to pivot',
N'Product-market fit means your product satisfies a strong market demand: customers buy it, use it, stay and recommend it.

One popular test, suggested by Sean Ellis, asks users: "How would you feel if you could no longer use this product?" If around 40% or more answer "very disappointed", the product is likely close to product-market fit.

If your experiments keep failing, it may be time to pivot: change one part of your business model while keeping what you have learned. Common pivots include:
- Customer segment pivot: same product, different customers.
- Zoom-in pivot: one feature becomes the whole product.
- Revenue model pivot: for example, from one-off sales to subscription.

Pivoting is not failure. It is the learning loop working as intended.');

SELECT CourseId, Title, Category,
       (SELECT COUNT(*) FROM Lessons WHERE Lessons.CourseId = Courses.CourseId) AS Lessons
FROM Courses ORDER BY CourseId;

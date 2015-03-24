---
title: Real Software Engineers Do It With Patterns
author: Jamie Kurtz
layout: blog-post
permalink: /2014/08/05/real-software-engineers-do-it-with-patterns/
thumbnail: /img/uploads/2014/08/lasagna.png
dsq_thread_id:
  - 2903971567
categories:
  - Architecture
tags:
  - clean code
  - design
  - pattaerns
  - SOLID
---
**Patterns**. They make the world go round. They are the building blocks on which we base so much of what we create in society.

Whether it be established patterns for making coffee, a pattern for sowing a pair of pants, the tried-and-true patterns of building architecture, or the patterns software engineers use to design and build applications, patterns of all shapes and sizes really do make the world go round.

Without patterns every new idea or creation would require the creator to start from absolute scratch. Patterns allow creators to stand on the shoulders of those that have gone before them. They provide an experience-based toolbox with which great new ideas can be built.

The very word "pattern", as provided by Merriam Webster, means "*the regular and repeated way in which something happens or is done*". Here&#8217;s another related definition: "*something designed or used as a model for making things*". Those two definitions go hand in hand&#8230; a) we notice those regular ways in things that work well, and b) we extract those ways and create reusable models for making new things. These are the reusable patterns; design patterns. The assumption being that we can increase our chances of success on similar future attempts if we extract the good things from previous attempts and use them as templates.

<iframe class="vine-embed" src="https://vine.co/v/M9WnM1BDZaX/embed/simple" width="320" height="320" frameborder="0"></iframe><script async src="//platform.vine.co/static/scripts/embed.js" charset="utf-8"></script>

My goal with this post is to convince you, the software engineer, that you should learn the patterns. Love the patterns. Leverage the patterns. And if not you, then maybe someone that reports to you. Or maybe just an annoying coworker that thinks "patterns don&#8217;t apply to the applications I build", as I&#8217;ve heard on plenty of occasions.

# Why Patterns? {#why-patterns}

I&#8217;m a big believer in software design patterns. To me, patterns rank right up there with [SOLID][1] and [clean code][1] (thank you "Uncle" Bob Martin!)
. And unit tests! I&#8217;ve been managing developers for a while now, and I
always hammer on those three things. Languages and frameworks and libraries will come and go (these days about every other day), but the fundamentals of clean code and design patterns prove to be priceless gems over and over, no matter what kind of software you are building.

### You&#8217;re not alone {#youre-not-alone}

<img src="/img/uploads/2014/08/head-first-design-patterns-259x300.jpg" alt="head-first-design-patterns" width="259" height="300" class="alignright size-medium" />

You see, as mentioned above, patterns are &#8211; by definition &#8211; rooted in real experiences. They let us quickly scan back over decades of software engineering, where smart people have slaved away over difficult problems, and extract the most promising pieces. As so eloquently stated in [Head First Design Patterns][3], the very first sentence of chapter 1: "Someone has already solved your problems". Sure, not all the exact dirty details. But certainly the hard-to-get-right-the-first-time and hard-to-change-later parts of your problems. Seriously, the pressure is a lot less than you think! Stand on those shoulders, leverage the knowledge they have acquired and made available to you.

### Patterns help reduce the need for major refactoring {#patterns-help-reduce-the-need-for-major-refactoring}

&#8230; or, at least, make it easier when required!

Patterns increase the odds that you, the designer/developer, will get it "right" the first time. Designing and building quality software is hard. Really hard. And any seasoned engineer will tell you that some things need to be done right the first time, or else you will waste loads of time and money trying to dig your way out of a giant mess. Deciding to leverage established patterns can literally be the difference between a successful software project and one that just goes on and on and on and on&#8230; forever in bug-fix "I&#8217;ve almost got it" mode.

As a fairly common example, let&#8217;s say you were designing an application to process commands submitted to a web service. The list of commands will be evolving rapidly over the next year or so. But we don&#8217;t want to be constantly updating the service itself (because that equates to downtime and risk). Further, we want to know that whenever a new command is added, or an existing one is patched, we aren&#8217;t going to mess up the other commands.

<img src="/img/uploads/2014/08/strategy-300x112.gif" alt="strategy" width="300" height="112" class="alignleft size-medium wp-image-405" />

What&#8217;s our design approach? Well, as luck would have it, we can leverage the [Strategy Pattern][4], which allows us to "define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it." I&#8217;m betting that this pattern came about from a great many software engineers spending years designing for very similar scenarios. And the Strategy Pattern is what survived as the "right" way to go.

<img src="/img/uploads/2014/08/chain-300x114.gif" alt="chain" width="300" height="114" class="alignright size-medium wp-image-403" />

If you went with the Strategy Pattern, combined with [Chain of Responsibility][5], you would greatly increase your chances of getting done sooner, with less rework, and with a more reliable piece of software &#8211; including meeting the requirement of being able to handle a rapidly evolving set of commands. And if some design-level refactoring was still required, you can be sure that you&#8217;re job would be orders of magnitude more difficult had you not chosen the appropriate pattern(s).

### It&#8217;s All In The Name {#its-all-in-the-name}

In addition to being a set of best-practice tried-and-true design templates, patterns also give you and your peers a common language. Because the really useful common patterns are well defined, and have been around for a couple decades, their names mean something! If you were to say to me "we&#8217;re going to leverage the strategy pattern", I instantly know what you mean. It&#8217;s as if we were performing a macro-replacement on those two words, inserting 10+ pages of textbook-quality content into your statement. We can jump past hours of discussion and whiteboarding trying to come up with a pattern, and go straight to applying an established pattern.

<img src="/img/uploads/2014/08/patterns.jpg" alt="patterns" width="590" height="186" class="aligncenter size-full wp-image-409" />

Think of the last time someone told you they were cooking Chicken Marsala, or Lasagna, or Caesar Salad. Those names invoke mental images of dishes that you and your friends would all share. "How about lasagna for dinner?"&#8230; "That sounds great!". Well, *that* is well-known, and you can more-or-less trust your experience and agree to the dinner recommendation. Design patterns ought to do the exact same thing! When someone says "how about the strategy and chain of responsibility patterns?", images of UML diagrams, class methods and properties, and sample code should come alive in your head. And you should be able to assess whether or not those patterns apply to the current problem at hand.

Sharing that common language, knowing the pattern names and what they represent, will go a long way in efficient and successful communication with your colleagues.

# Design Patterns {#design-patterns}

I&#8217;d like to provide a few highlights related to patterns, for those that aren&#8217;t entirely sure of what I&#8217;ve been talking about. First and foremost, the book that is commonly referred to as "the seminal book on patterns", published in 1994, is called [Design Patterns: Elements of Reusable Object-Oriented Software][6], by Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides. Since the title is fairly long, and their are four authors, the book is almost always referred to as the "Gang of Four"; or, GoF for short. The 23 patterns in this book are commonly referred to as the "GoF patterns". If you do nothing else, you should learn these 23 patterns. They are foundational, and most other patterns are based off or composed of one or more of these 23. For example, Model View Controller is, according to the GoF, primarily composed of the Observer, Strategy, and Composite patterns.

Software design patterns are, in short, templates that represent best practices; templates that can be applied to specific problems. But they are not ready-made code. Patterns are not (typically) libraries or components that can be dropped in and executed. Generally speaking, a pattern&#8217;s exact implementation will vary slightly from problem to problem. Thus they are a template.

Think of a document template. It will guide you as to the overall style and flow and type of content to include, but ultimately you have to write the actual content. If you&#8217;ve ever written a requirements document, or filled out a code-review template, you know what I mean. Sure, without a template, you could eventually include all the appropriate information, format it effectively for quick consumption, and style in such a way that matches your company branding. But those templates let you jump straight to the good stuff &#8211; the actual value you are adding.

Patterns typically consist of some key properties, including:

  * Name
  * Intent (i.e. a sentence or two describing what the pattern does)
  * Motivation (i.e. why use the pattern?)
  * Structure (this is where the UML comes in)
  * Consequences, trade-offs, pros and cons
  * Sample Code
  * Example Uses

Think of these patterns, particularly the GoF, as a catalog of items, each with the above-listed properties. Each one includes about a dozen pages of text and diagrams. And there is usually some notion of classification. With the GoF, we have: Creational, Structural, and Behavorial. Other books might provide a slightly different set of classifications.

Beyond the GoF, a few other books come to mind. All three of these, along with the GoF book, are readily accessible at my desk:

  * [Patterns of Enterprise Application Architecture][7] (PoEAA), Martin Fowler, 2002
  * [Head First Design Patterns][3], Freeman and Freeman, 2004
  * [Learning JavaScript Design Patterns][8], Addy Osmani, 2012

Fowler&#8217;s PoEAA book builds on the GoF, presenting over 50 patterns that tend to apply to larger "enterprise" applications &#8211; i.e. those involving large sets of data, lots of users, complex business logic, and integration with other systems. You&#8217;ve no doubt heard of at least a few of them: Unit or Work, Repository, Active Record, Model View Controller, Service Layer, and Lazy Load. Many of Fowler&#8217;s patterns were either already or have become common place in today&#8217;s line of business applications.

For a more entertaining and modern narrative of the original GoF, I strongly recommend you checkout the Head First Design Patterns book. It is essentially the 23 GoF patterns, but presented in a such a way that really helps you get it. Where the GoF book is more of a text book, the Head First book is entertaining, funny, includes lots of pictures, and provides exercises that help ensure the information is sinking in. Personally, the Head First book did more for my understanding of patterns than the GoF book. But the GoF book is still a great reference book to keep within reach.

And lastly, with all of the JavaScript code popping up everywhere, going through Osmani&#8217;s design patterns book has shown me that even in the days of dynamic languages such as Ruby and JavaScript, the notion of patterns still very much applies. In fact, Osmani spends the first few chapters presenting the exact topic of this blog post: the what and why of design patterns. It&#8217;s an excellent book, and I strongly recommend it for anyone working in the web space these days. Many of the patterns in the book are JavaScript-centric views of the GoF. But there are also some newer patterns mixed in, as well.

# What To Do? {#what-to-do}

To wrap up this post, I&#8217;ve listed a few goals you can set for yourself with regards to software design patterns. Some great reading material was referenced above, but the following should give you something practical to shoot for.

<img src="/img/uploads/2014/08/hand-one-150x150.jpg" alt="one" width="150" height="150" class="alignright size-thumbnail wp-image-411" />

First, and this is probably obvious, learn the 23 GoF patterns &#8211; at least by name and basic definition. They are all useful, but if you&#8217;re short on time, I would probably start with the following:

  * Abstract Factory and Factory Method
  * Builder
  * Adapter (great for decoupling and allowing for mocking of statics, among other things)
  * Prototype (significant in JavaScript)
  * Facade
  * Observer
  * Chain of Responsibility (great way to avoid long switch statements for processing / selecting strategies)
  * Strategy
  * Template Method
  * Iterator (you are probably using this already)

<img src="/img/uploads/2014/08/hand-two-150x150.jpg" alt="two" width="150" height="150" class="alignright size-thumbnail wp-image-411" />

This will lead to what I consider a second goal. That is, recognizing when a problem is similar to a known pattern. Once you have some base line understanding of these patterns, your mind will start thinking of problems in those terms. In other words, you will automatically start trying to fit problems into one or more GoF (or other) patterns. This is a good thing, as it means you&#8217;re evolving from making up your own solutions from scratch to standing on the shoulders of those before you and applying what they&#8217;ve learned and passed on.

<img src="/img/uploads/2014/08/hand-three-150x150.jpg" alt="three" width="150" height="150" class="alignright size-thumbnail wp-image-411" />

And last, make it a goal to see development as using your creative mind to apply patterns. Don&#8217;t accidentally waste time and energy coming up with new ways of doing things, because chances are you will regret it. Sure, you may stumble on a great new approach that no one else has noticed yet. But this should be the exception, not the driving force. More often than not, you should be working to apply patterns such as GoF or Fowler&#8217;s. And don&#8217;t assume when you can&#8217;t immediately apply a known pattern to a problem that an appropriate pattern doesn&#8217;t exist. Make it a point to seek out appropriate patterns. Even if you can&#8217;t find one, you certainly haven&#8217;t wasted time researching a multitude of problem-specific patterns.

Thanks for reading my thoughts on software design patterns. I&#8217;d love to hear your thoughts, as well. What&#8217;s your favorite or most-used design pattern?

**Thanks to Brian Wortman for reviewing (and editing) this post. As I mentioned in the [book][9] we just completed, I learned most of patterns and clean code and doing things "right" from him. Thanks a ton, Brian!**

**For practical ASP.NET Web API implementations of common patterns, and some great info on REST, check out [REST and ASP.NET Web API][9]!**

 [1]: http://en.wikipedia.org/wiki/SOLID_(object-oriented_design)
 [2]: http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882
 [3]: http://www.amazon.com/Head-First-Design-Patterns-Freeman/dp/0596007124
 [4]: http://www.dofactory.com/Patterns/PatternStrategy.aspx
 [5]: http://www.dofactory.com/Patterns/PatternChain.aspx
 [6]: http://www.amazon.com/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612
 [7]: http://www.amazon.com/Patterns-Enterprise-Application-Architecture-Martin/dp/0321127420
 [8]: http://www.amazon.com/Learning-JavaScript-Design-Patterns-Osmani/dp/1449331815
 [9]: http://amzn.to/SR46eq
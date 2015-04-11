---
title: Using Drupal as an Enterprise Development Platform
author: Jamie Kurtz
layout: blog-post
permalink: /2013/12/15/using-drupal-as-an-enterprise-development-platform/
thumbnail: /img/uploads/2013/12/Drupal_Enterprise_Badge-150x150.png
dsq_thread_id:
  - 2052960549
categories:
  - Drupal
  - REST
  - Services
---
In this post I want to share the bottom-line belief that served as the basis for the new book [Thomas Belsuau](https://twitter.com/tbesluau) and I wrote, [Drupal as an Enterprise Development Platform](http://www.amazon.com/Pro-Drupal-Enterprise-Development-Platform/dp/1430260041). The belief that there has to be a better way.

A better way to create web sites and services than starting from scratch every time we sit down to build those applications. A faster and more cost effective approach than starting with a blank Visual Studio or PHP or Ruby/Rails project. More reliable and better tested than writing even one line of our own code &#8211; let alone 100s or 1000s.

## Seeking a Better Way {#seeking-a-better-way}

To start, ask yourself these questions:

<img src="{{ site.url }}/img/uploads/2013/12/question-mark.jpg" class="alignright" height="120" width="80" />

  * In a typical release cycle, how much time do you and your team spend writing code, writing tests, testing the code, then fixing the code?
  * Of that time, how much is spent on value-add business functionality &#8211; versus dealing with code-level or framework issues?
  * What kind of exposure and vulnerability come from your code? In other words, with all the code you write, what might happen if it doesn’t work as planned &#8211; i.e. there’s a bug?
  * What foundational functionality are you building from scratch today that has already been written, tested, packaged, and published?
  * How many common tasks of a development project &#8211; i.e initial code base, servers, test infrastructure, releases, backups &#8211; have you been able to automate efficiently?
  * Are you extremely competitive in bidding for projects that are architecturally close to some you’ve already done?

As Thomas and I both have been, or, currently are, in the consulting world, the honest answers to those questions drove us to seek out a better way. And so we combined his experience working on web sites and content management systems with my experience as an enterprise developer and architect to come up with a one-for-one matching of enterprise-level application concerns with "answers", if you will, that can be found within the Drupal platform.

I will say, too, that I love to write code. I&#8217;m a bonefied code slinger down to my core. I spend my nights and weekends working on all manner of new and cool tools and langauges. My current fancy, like everyone else these days, is writing web, service, and queue processing applications using NodeJS. Sometimes I&#8217;ll use [Node][3] (and Javascript) as a desktop scripting tool on my Linux laptop &#8211; instead of the typical shell script. And like most of you reading this post, I would much prefer to start every project with a blank slate and choice of language or platform. However, in the competitive world of consulting and building web and service applications, Thomas and I found that we needed an alternative approach. We needed to complete these applications faster and cheaper.

And, truth be told, we needed to empower our front-end web designers and developers &#8211; the folks working in both Photoshop and their favorite HTML/CSS editor on sexy shiny Mac Book Pros &#8211; to build more without having to engage "those appdev guys". In other words, if building a site or service doesn&#8217;t require creating new source trees from scratch, doesn&#8217;t require any server-side code at all, then those designers are suddendly sufficiently equipped to build a complete web site or back-end service. This becomes especially important for our mobile development team, as well. They simply aren&#8217;t staffed with backend .NET or PHP or Ruby developers, so being able to just "turn on" a complete REST or SOAP service layer without writing a single line of code is incredibly compelling.

## Common Concerns {#common-concerns}

A key requirement for whether or not we could even write the book was in being confident that Drupal could cover most or all common application architecture and development concerns. So we created a list of requirements you&#8217;d typically find in an enterprise-level application. Here&#8217;s a portion of that list (as seen in Chapter 1 of our book). This figure also describes how a developer might implement the functionality if using a code-level library &#8211; e.g. a Nuget package in .NET or a gem in Ruby, etc.

<img src="{{ site.url }}/img/uploads/2013/12/app-libraries.png" width="700" />

Then next we mapped those requirements into various Drupal modules &#8211; seen in this next figure.

<img src="{{ site.url }}/img/uploads/2013/12/app-libraries-drupal.png" width="700" />

Some of the other concerns we mapped into Drupal include: packaging and deployment, executing batch jobs, OAuth support, single sign-on with windows AD or other LDAP directory, change auditing, data caching, system-level settings, localization of content, and multi-tenancy. All of these are covered in our book.

## The Drupal Way {#the-drupal-way}

What is so exciting for Thomas and I is that all of those concerns are handled by Drupal *without writing any code*. That&#8217;s right, we aren&#8217;t talking about Nuget packages or Ruby gems that must be coded against. We aren&#8217;t talking about an MVC framework with which I can create HTML-based views and server-side controllers. Nor do I have to use Bootstrap to manually lay out a nice UI. Those modules shown above are what I like to call "full-stack modules". That is, you turn them on and you get everything &#8211; the database structures, server-side logic, and fully-functional UI components or pages.

<img src="{{ site.url }}/img/uploads/2013/12/Drupal_Enterprise_Badge.png" class="alignleft" height="100" width="80" />

Imagine being able to "turn on" Twitter and Facebook sign-on support by installing a module and simply setting a few configuration values. Turning that module on means you get full integration with Twitter and Facebook for the actual sign-on logic, database tables/columns that store the new sign-on information, and new UI widgets that show up on your site&#8217;s login screen. That&#8217;s it. Done. Database, business logic, and UI.

The same applies to turning on something like data imports and exports. We&#8217;ve all written code to read or parse out XML/CSV/text files, dumping them into a database. Parse and load code isn&#8217;t always straightforward, and typically takes some time to work out the kinks and various corner cases. But in Drupal, a module like Feeds can be installed that facilitates the import of a wide variety of data. You simply configure the file format, map some fields, create any needed business rules or constraints, and Drupal does the rest for you.

## Give it a Try! {#give-it-a-try}

In our minds, Drupal is more than just a Content Management System (CMS) &#8211; i.e. like WordPress. Sure, you can use Drupal to create a blog-centric web site. But the very architecture of Drupal provides an excellent plug-in platform that allows a massive community of developers to build the things we need. A common saying within the Drupal community is "There&#8217;s a Module for That". Seriously, if you need it, likely someone else has already thought of, coded, and tested it for you. Drupal truly is a highly componetized enterprise-class development platform. And because it&#8217;s so widely used and developed on, most modules are tested many times more than you could ever do yourself with your own from-scratch code.

The book we wrote is a reflection of our excitement for being able to leverage a platform like Drupal &#8211; much more than your typical CMS, and much more than a set of code-level packages and libraries. The next time you sit down to design a new web site or backend SOAP or REST service, we strongly encourage to take a look at Drupal You just might like it. And we can almost gaurantee your bosses and clients will like it.


**Information on Drupal can be found, among other places, on [Drupal.org][6] and [Acquia][7].**

 [1]: https://twitter.com/tbesluau
 [3]: http://nodejs.org/
 [6]: http://drupal.org
 [7]: https://www.acquia.com/

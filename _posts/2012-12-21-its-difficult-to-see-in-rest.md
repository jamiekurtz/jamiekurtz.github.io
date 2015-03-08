---
title: 'It&#8217;s Difficult to See in REST'
author: Jamie
layout: post
permalink: /2012/12/21/its-difficult-to-see-in-rest/
dsq_thread_id:
  - 1509650297
categories:
  - REST
tags:
  - MVC 4
  - REST
  - Web API
---
I&#8217;ve been thinking a lot lately about why it&#8217;s so hard for us developers to see web services through&nbsp;<a title="REST" href="http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm" target="_blank">REST</a>-colored glasses. It seems as if all of our object-oriented (OO) training and experience over the last nearly 20 years has shaped our design-minds into seeing software more in terms of functions than in terms of objects or resources. Ironically, it is exactly this *orientation around objects* that is supposed to make us see our programs as a bunch of &#8220;things&#8221; interacting with each other &#8211; usually via attributes and actions on those &#8220;things&#8221;. Why, then, is it so difficult to &#8220;see&#8221; in objects? Why does our code so often deteriorate&nbsp;into a mess of misplaced static/shared methods? And how does this difficulty relate to a difficulty designing RESTful services?

In this post I want to offer a few reasons why seeing in REST is not easy. And also present a couple ways to think about how we might slowly start to put down our old pair of glasses, and pick up and enjoy seeing through a new RESTful pair.

## It&#8217;s Not Easy to Model Players

For starters, creating a web of interacting objects is hard. It requires a lot of thinking about *who&#8217;s* doing stuff, as opposed to *what* they are doing. Let&#8217;s face it, people like us find it more comfortable to just write small bits of code that revolve around *doing* things (i.e. functions). It is much harder to take sufficient time to map out the players in our software, than to simply start writing code that *does *something. We want to get on with it, to see screens pop, lights flash, and music play. And we want it now!

<a href="http://www.tutorialspoint.com/uml/uml_basic_notations.htm" target="_blank"><img class="alignright" title="An Actor" src="http://www.tutorialspoint.com/images/notation_actor.jpg" alt="" width="108" height="107" /></a>

I believe this is why so many programs are written with the intention of being artfully object-oriented, yet all-too-commonly wind up as just a pile of methods. Sure, the methods belong to classes. And classes belong to namespaces. But effective and appropriate management of state (i.e., the data we should be attributing to our objects) gets tossed overboard early on in the code writing frenzy.

Why is it hard to think about the players in our software? Why is it harder to think of the *who* rather than the *what*? Honestly, I don&#8217;t really know! But, I&#8217;m almost certain you&#8217;ll agree that it is harder. At least for a while &#8211; as you get started on a new code base. And then one day you look up and realize that your code is a giant plate of&nbsp;spaghetti&nbsp;completely devoid of any notion of stateful objects.

## Method-Oriented Services

I believe another reason we are so trained to think about just&nbsp;*doing*, as opposed to *who&#8217;s* doing, is that the introduction of the internet spawned a bunch of technologies dealing almost exclusively with methods. We have things like Remote Procedure Call (RPC) and Remote Method Invocation (RMI). We have XML Web Services that center on dozens or more methods on a service-of-sorts. We also have CORBA &#8211; which is a large framework and standard for implementing RMI. Starting with .NET 3.0, we have Windows Communication Foundation (WCF) for broadening our reach of web services across many different protocols (e.g., HTTP, MSMQ, TCP/IP, named pipes) and options for user authentication. And even more recently developers are using various MVC frameworks to create web services (e.g., ASP.NET MVC Framework, PHP CodeIgniter, Ruby on Rails). Going the other way, most modern software languages are meant to provide an abstraction over lower level machine languages &#8211; who&#8217;s primary execution model centers on functions/operations like mov, add, sub, and jmp.

<a href="http://school.anhb.uwa.edu.au/personalpages/kwessen/apple1/Krusader.htm" target="_blank"><img class=" " title="Assembler" src="http://school.anhb.uwa.edu.au/personalpages/kwessen/apple1/R1-ASM.JPG" alt="" width="384" height="288" /></a>

We are focused very heavily on the *doing* within our code, and within our services. We get crafty with all manner of methods and message types. Every time we turn around we need a new method on a service &#8211; until, like the mess of spaghetti our OO code often turns into, we are left with a degenerate pile of misfit methods. We do our best by implementing such patterns as Aggregate Root (introduced by <a href="http://www.domaindrivendesign.org/resources/ddd_terms" target="_blank">Domain-Driven Design</a> to control access to a&nbsp;hierarchy&nbsp;of related objects). At the end of the day, though, we very naturally create methods &#8211; lots and lots of them; we really don&#8217;t want to think about the players.

## They Be Methods!

Yet another reason for this tendency towards lots of methods on services is that we create actual code methods when creating service behaviors! In .NET, whether dealing with the old XML Web Services, Remoting, WCF, or MVC, our behaviors are indeed real methods. Sometimes they are methods on a service class (web services and WCF), sometimes they are methods on transportable objects (Remoting), and sometimes they are methods on Controllers (MVC). But they are always methods. No wonder we tend to think of our services as a bunch of arbitrary methods. That&#8217;s exactly what they are!

## Constrain Yourself

So what if we designed our next service API (i.e., the methods and objects that people use to talk to our service) under the constraint of a predefined set of methods? What if we *couldn&#8217;t* create a new method for every behavior we implement? What if we force our design-brains to leverage the objects more than the methods to build our API?

For example, without this constraint on the methods we can invent, we might create a method on a `TaskService` like this:  


<pre>CreateTask(string title, string description, DateTime dueDate);</pre>

  
And we might invent a method like this:  


<pre>AddNewAssignee(int taskId, int userId);</pre>

  
Or, this:  


<pre>UpdateCategories(int taskId, int[] newCategories);</pre>

  
Going forward, what if we constrained our available methods to only those defined by HTTP (for now, just a subset of those, actually): GET, PUT, DELETE, POST?

There are many cases throughout life where applying a force of some kind in one area creates a desired result in another area. For example, I may not have sufficient discipline to study up on a new technology. But if I schedule a certification test for that new technology a few weeks from now, you can be sure I will study. Throwing a party at your house makes you clean everything from top to bottom. Going on a long vacation out of the country might make you update your will. Knowing that summer is approaching might make you eat fewer brownies &#8211; so you can fit into last year&#8217;s swimsuit. Forcing yourself to write unit tests forces you to write code that is testable (and testable code is indeed better code). Scheduling a client demo of some new features &nbsp;provides tremendous focus on what code you work on this week. Forcing yourself to limit method length to only five lines of code might seem slightly draconian, but it can really help modularize your classes and make them easier to test and refactor.

So what possible good could come out of constraining service methods to only those provided by HTTP? My claim is that you will be forced to think of the objects in more detail; to really map out resources that make sense in the big wide world of the web. You will be forced to take advantage of uniquely addressable resources (i.e., URLs) &#8211; which, in addition to using only predefined HTTP methods, is one of the tenets of a RESTful API.

Let&#8217;s alter our design according to this new &#8220;force&#8221; of only using GET, PUT, POST, and DELETE methods. Here&#8217;s what we had (plus a couple more):  


<pre>TaskService.GetTask(int taskId);
TaskService.CreateTask(string title, string description);
TaskService.AddNewAssignee(int taskId, int userId);
TaskService.UpdateCategories(int taskId, int[] newCategories);
TaskService.CompleteTask(int taskId);</pre>

  
If we instead leverage HTTP URLs and methods, we have something more like:  


<pre>GET /tasks/1234                       => Same as... GetTask()
POST /tasks                           => CreateTask()
PUT /tasks/1234/assignees/5678        => AddNewAssignee()
PUT /tasks/1234/categories            => UpdateCategories()
DELETE /tasks/1234                    => CompleteTask()</pre>

  
The URLs end up being the more descriptive and innovative part of the API, as opposed to the methods. And having descriptive (and unique) URLs in your API makes the API much more&nbsp;discover-able, readable, and navigable (not sure that&#8217;s a word!). Further, leveraging HTTP like this means your application can lean on HTTP technologies such as address-ability, security, caching, indexing, etc.

To quickly illustrate what I mean by&nbsp;address-ability, let&#8217;s look at how the two APIs above would look from a URL standpoint (assuming our TaskService was implemented with WCF).

<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      Get task 1234
    </td>
    
    <td>
      /api/taskservice.svc
    </td>
    
    <td>
      /api/tasks/1234
    </td>
  </tr>
  
  <tr>
    <td>
      Get task 0987
    </td>
    
    <td>
      /api/taskservice.svc
    </td>
    
    <td>
      /api/tasks/0987
    </td>
  </tr>
  
  <tr>
    <td>
      Get all task categories
    </td>
    
    <td>
      /api/taskservice.svc
    </td>
    
    <td>
      /api/tasks/1234/categories
    </td>
  </tr>
  
  <tr>
    <td>
      Get all task assignees
    </td>
    
    <td>
      /api/taskservice.svc
    </td>
    
    <td>
      /api/tasks/1234/assignees
    </td>
  </tr>
</table>

Notice how the more traditional RPC-style URLs are all the same. The details of exactly why this is a problem &#8211; and why we want to leverage more of HTTP &#8211; is beyond what I care to cover in this blog post. But you can read more about it in my short book titled &#8220;<a href="http://www.amazon.com/dp/1430249773" target="_blank">ASP.NET MVC 4 and the Web API: Building a REST Service from Start to Finish</a>&#8220;. In the book we explore all of the ins and outs of REST, how it works in tandem with HTTP, and how to transform your RPC-style services into full-blown RESTful services.

## The ASP.NET Web API Helps Constrain the Methods

To wrap it up, I want to point out that the new ASP.NET MVC 4 Web API actually helps you better &#8220;see&#8221; in REST. Unlike straight MVC Framework services, Web API services force you into implementing *only*&nbsp;GET, PUT, POST, and DELETE methods (and a few of the other available HTTP methods). So right off the bat, you are forced into thinking of your resources, your objects, how they interact, all of the URLs you need to address every part of the application&#8217;s resources, and how they all relate to each other. Essentially, the underlying technology or protocol forces you into thinking much more about the object in object-oriented programming, than you are in writing code that just does stuff. Twitter did this with its 140-character tweets &#8211; it has quite literally changed the way we communicate. Similarly, a Japanese Haiku constrains you to a line of 5 words, then 7 words, then 5 words again. While you might at first find this approach restrictive, it indeed forces you to think about your expression differently.

In short,&nbsp;deliberately&nbsp;constraining the methods we use in our services to *only* those offered by HTTP might at first seem like an overly restrictive pain-in-the-you-know-what. But I challenge you to give it a go. You might find that such constraints help you think more clearly about the real meat of your services: the resources and their URLs. Heck, you might even enjoy the view you get with your new REST-colored glasses.

*** For more nitty-gritty details on the ASP.NET Web API and using it to build RESTful services, be sure to check out my new <a href="http://www.amazon.com/dp/1430249773" target="_blank">book</a>.*

*** Special thanks to my friend and colleague at <a href="http://fusionalliance.com/?utm_source=jamiekurtzweb&utm_medium=jamiebook&utm_campaign=jamiekurtz" target="_blank">Fusion Alliance</a>, Jeff Pickett, for proofing this post and providing great industry context and insight.*
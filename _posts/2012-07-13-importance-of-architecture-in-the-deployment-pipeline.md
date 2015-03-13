---
title: Importance of Architecture in the Deployment Pipeline
author: Jamie
layout: blog-post
permalink: /2012/07/13/importance-of-architecture-in-the-deployment-pipeline/
tagazine-media:
  - 'a:7:{s:7:"primary";s:0:"";s:6:"images";a:1:{s:51:"http://geekswithblogs.net/jkurtz/aggbug/146581.aspx";a:6:{s:8:"file_url";s:51:"http://geekswithblogs.net/jkurtz/aggbug/146581.aspx";s:5:"width";s:1:"1";s:6:"height";s:1:"1";s:4:"type";s:5:"image";s:4:"area";s:1:"1";s:9:"file_path";s:0:"";}}s:6:"videos";a:0:{}s:11:"image_count";s:1:"1";s:6:"author";s:8:"37758482";s:7:"blog_id";s:8:"38292748";s:9:"mod_stamp";s:19:"2012-07-15 01:54:42";}'
categories:
  - Continuous Delivery
tags:
  - Agile
  - Architecture
  - Continuous Delivery
---
**<span style="font-size: small;">My Epiphany – Part 1</span>**

After reading <a href="http://www.amazon.com/Continuous-Delivery-Deployment-Automation-Addison-Wesley/dp/0321601912/ref=sr_1_1?ie=UTF8&qid=1313687382&sr=8-1" target="_blank">Continuous Delivery</a>, by Jez Humble and David Farley, I couldn’t help but think “wow! this is the key to becoming truly agile!”. I submit that may be a little overstated, but nonetheless my minor epiphany has grown into an outright passion for enabling rapid development AND delivery of small bite-sized pieces of applications.

As we’re all well immersed into the Agile way these days (or, at least, we’re all trying!!), our common goal should be to provide customers a continuous stream of value; value here is measured in terms of **bug fixes** and **new features** as requested by the customer. And you absolutely cannot support a continuous stream of value if you can’t rapidly and reliably move those bug fixes and new features all the way from the developer commit to the live production system.

And now with the recent focus on cloud-based hosting for our applications, it is even more important that we subscribe to the **paradigm shift** proposed by Jez and David. Yes, I said “paradigm shift”. And that’s the way I see it, honestly. There’s simply no way a software provider can compete these days if all of their value offerings are locked up in the source repository for months on end. To create any other kind of delivery infrastructure that does NOT follow the recommendations laid out in <a href="http://www.amazon.com/Continuous-Delivery-Deployment-Automation-Addison-Wesley/dp/0321601912/ref=sr_1_1?ie=UTF8&qid=1313687382&sr=8-1" target="_blank">Continuous Delivery</a>, is a guarantee that your value – i.e. what you’re charging the customer for – will stay locked away for longer than it takes that customer to shop elsewhere.

**<span style="font-size: small;">And Part 2</span>**

Now, being an architect, this is where my [minor] epiphany really grows some legs. Dare I propose the following:

  1. You can’t turn internal agile practices into a continuous customer value stream without the Humble/Farley automated “deployment pipeline”. And,
  2. You can’t truly support the automated “deployment pipeline” without an architecture that is highly componentized and very loosely coupled

Before I go any further… sure, you can create an automated deployment pipeline even with a big monolithic ball-of-mud application. I’ve seen it done. **But is is hard.** And when I say “hard” I don’t mean challenging or difficult and it’s Friday afternoon and I want to go home. I mean **too hard**. And costly. And frustrating. And people will get burned out quickly. If you try to push an application too quickly through a deployment pipeline when its underlying architecture can’t support it, it will be crazy hard. So there, yes, you can theoretically keep your ball-of-mud architecture, but you will be severely limited, frustrated, and probably sleep deprived!

**<span style="font-size: small;">Components (good) and Dependencies (bad)</span>**

The architecture I’m talking about centers around very small components. These small components can be considered the smallest possible unit of deployment for a given functional group or feature (or, group of features). That’s pretty subjective, but those of us with a little gray hair understand. If we draw a circle around a single component in the application, there can be too much in the circle. And there can be too little in the circle. We’ll defer a deep dive around componentization for later. Just know that the circle we draw has a lot to do with dependencies.

These components… **they must be totally isolated starting from inception and design all the way through to delivery**. That means the design teams and BAs and user experience experts aren’t hearing things like “*oh, you can’t improve that piece of the UI without upgrading the ENTIRE PLATFORM*” from the engineers. And they’re not being told that in order to create a new style on the buttons in one area “*we’ll have to upgrade the controls toolkit which will affect EVERY SCREEN IN THE SYSTEM*”.

Ok, sure, dependencies are a necessary evil. But we must always **strive to minimize dependencies between components**. The dependency diagram between components should look very flat, and ideally no lines between the components. Further, we must ruthlessly avoid implicit (and, usually, unnecessary) dependencies by way of dependencies on shared “framework” libraries. Because once you have two components with a dependency on a shared library, you can’t fix a bug or add a new feature by way of the shared library without necessarily affecting both components. And the more stuff that exists in the “framework”, the higher the chances are that your change will be in that framework.

Occasionally we must remove our geeky engineering hat and strive for balance between <a href="http://en.wikipedia.org/wiki/Don't_repeat_yourself" target="_blank">DRY</a> and dependencies on shared libraries. Duplicate code kills. But so do dependencies. Resist the urge to dump anything that even slightly smells like shared code into a “framework”. Sometimes it’s better to let these components live independently – even if they duplicate some code here and there. Heck, there’s duplicate code all around the world – i.e. we don’t all share the same exact “framework” libraries. It’s all in your perspective, and how big you draw your circle, that defines whether or not code is even duplicated in the first place.

One more thing about dependencies: try to depend on a contract of-sorts, and not on a binary. In other words, create an architecture that allows components to be tolerant of changes of other components. We want to allow components to change without requiring a complete build and regression run of all other components.

**<span style="font-size: small;">What Do We Get?</span>**

Once we have an architecture that consists of small isolated components, and we’ve minimized or eliminated dependencies, we not only can support the proposed automated deployment pipeline, we also reap other benefits. To name a few, we have an architecture and an environment that:

  * Promotes and supports agility from the entire team in terms of response to issues or new requests
  * Allows smaller bits and packages to be deployed – which lowers risk for the product owners and customers
  * Allows teams and components to utilize frameworks and patterns that best suite their own unique needs (rather than everyone depending on a lowest-common-denominator)
  * Avoids the situation where one component’s change in technology or development practice necessarily affects all other components.

I’m sure you’ve heard something like this: “but we’re not ready to support SuperLibrary version 2.0, we need to stay with 1.0 for the next 6 months. And since we’re sharing the SuperLibrary DLLs, you’ll have to find another (read: *more difficult and expensive*) way to meet your customer requests.”

We must understand that there is actual **realizable value** in being able to deliver independently from other components. And that value is *usually* higher than the value gained by trying too hard to avoid duplicate code. Not always – it’s a balance.

**<span style="font-size: small;">Some Common Antipatterns</span>**

To wrap it up, here’s a few things I’ve noticed might indicate that you aren’t ready to create a high-powered rapid customer value delivery pipeline. Feel free to comment on what you’ve witnessed.

**Long-running builds – **If it takes 10s of minutes just to compile you  
r solution/package, then it’s too big and needs to be broken down into smaller components. And if it takes 10s of minutes to compile and run all first-phase unit tests, it’s still too big! At the risk of sounding over-generalized, I think a single component should take about 15 to 30 seconds to compile and maybe another 30 seconds to run all unit tests. That’s pretty subjective, but you get the idea.

**Multiple web sites / virtual directories in one solution/package – **One easy way to draw a circle around a component is by way of its web application deployment package. And since two web sites are generally independent from a user’s viewpoint, you can most likely separate each web site project into its own component.

**Relying on feature branches to allow teams to work independently – **This is a common antipattern exhibited by an architecture that creates large components. In order for one team to fix bugs or create new features in their component, they must create a branch of the ENTIRE application. Anyone who has lived or is living through a feature-branch nightmare knows what I’m talking about. Don’t force branches for every team or every new feature. Let the components themselves be the “branch”.

**Creating a patch requires a build of all components – **Bugs happen. Hotfixes happen, too. And sometimes we need to create a patch and get it out quickly. But if that patch or hotfix requires me to rebuild the entire system – ouch!! We need to lower risk, not increase it. And we need to create patches that we feel confident will not introduce change into other areas of the system. And that starts with not rebuilding those other areas of the system!

<img src="http://geekswithblogs.net/jkurtz/aggbug/146581.aspx" alt="" width="1" height="1" />
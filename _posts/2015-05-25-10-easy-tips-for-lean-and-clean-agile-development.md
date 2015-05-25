---
title: 10 Easy Tips For Lead and Clean Agile Development
description:  A guided tour through ten easy-to-implement tips for reducing chaos, increasing efficiency, and helping your agile development teams run leaner and cleaner - and happier. 
author: Jamie Kurtz
layout: blog-post
permalink: /2015/05/25/10-easy-tips-for-lean-and-clean-agile-development/
thumbnail: /img/uploads/2015/05/cheetah-running-thumb.jpg
comments: true
categories:
  - Agile
  - Development
  - Continuous Delivery
  - Architecture
keywords: agile development, continuous delivery, architeture, agile, sprints, release, branching, branches
---

Software development is hard. And while agile methods can certainly deliver faster and cheaper and with higher quality, they can also more quickly spin out of control and create lots of wasted time and energy and increased frustration. 

<img src="{{ site.url }}/img/uploads/2015/05/cheetah-running.jpg" alt="cheetah" width="175" height="175" class="alignleft size-thumbnail" />

This post will be a brief guided tour through ten easy-to-implement tips for reducing chaos, increasing efficiency, and helping your agile development teams run leaner and cleaner - and happier. These aren't in any particular order. And they are based on my own experience over the last couple decades. No doubt other people will have differing opinions, which is great, and I would love to hear them. This is simply what I've found to work well in a practical way across many types of software projects and many types of teams.

<br />

#### 1. Utilize no-interpretation-needed severities in your bug tracker

First, **use a Severity field that is separate from Priority**. It's a fundamental fact of building software that an issue's severity in the eyes of a __user__ is distinct from priority in the eyes of the __business__ - or software provider. Priority should take into account all kinds of software-building things, like budget, stakeholder preference, release timing, market opportunities, and available skillset and tooling. This also implies that Priority can change over time for a given issue. And it often does!

But a changing priority value should absolutely **not** change the severity of the issue as seen by the user at the time it was reported. So make sure you issue tracker has both fields - Severity and Priority.

And second... stop using severity values like {1, 2, 3, 4, 5} or {Hi, Med, Low}. These are way too subjective and arbitrary. The development teams hardly ever know what these mean, and the poor users don't stand a chance. Here's what I recommend, which has worked well for me over the years:

    0 - Blocked
    1 - Crash, hang, data loss, security issue
    2 - Severe loss of functionality
    3 - Usability issue, functionality doesn’t match spec
    4 - Suggestion

I haven't found many issues that can't be placed into one of those severity levels. And again, these don't indicate business priority - but rather the importance of the issue from the user's perspective.

When entering these values into your issue tracker, just put the whole text in there... i.e. "0 - Blocked". No need to just put the numbers, and then make people try to figure out what the heck the "0" or the "3" actually mean. Trust me, put the whole darn thing in the list of Severity choices.

It's been amazing to me to watch the clarity this small change introduces to a development team. There's no guessing as to the nature of what user/tester found! 

These levels come courtesy years ago from one of the best team leads I've ever worked with - [Kevin Kelly](https://www.linkedin.com/in/kkelly18).

#### 2. Great Hardware for Your Developers and Testers

I'm continually astounded by the massive cost in time/billable-hours companies incur for something as trivial as a second or third monitor. You can just about make up the cost of a monitor in single day! 

I remember when 2nd monitors were just becoming popular, and I bought everyone on my team a second monitor to plug into their laptop. It cost me all of about $2000 total, and gained me something in the neighborhood of 30% increase in productiviy. Not to mention developer happiness. And, in this particular case, envy from developers on other teams in the company:)

Seriously, there's more than you think riding on a developer's ability to go fast and free. Freedom almost always wins!! And things like: good monitors, good keyboards, lots of RAM, plenty of CPU horsepower, and extra hardware lying around go **A LONG WAY** in offering freedom, increasing productivty, and overall keeping your top talent around a little longer.

<img src="{{site.url}}/img/uploads/2015/05/daskeyboard-ultimate.webp" width="175" height="175" class="alignright" />

The math is drop dead simple to do (e.g. $200 monitor to "buy back" an hour or two a day is a no brainer). Developer and tester happiness is a little harder to measure, but you can just ask, and watch, and listen. You claim to an agile shop - so try something new in the way of hardware, get some feedback, and adjust. These days, hardware is cheap, and people are expensive. And turnover is VERY expensive. So remember that the next time you're cringing at a mere $200 to double someone's RAM. 

If you don't believe me, try buying a nice keyboard for everyone on your team. I've been very happy with the [Model S Ultimate from daskeyboard](http://www.daskeyboard.com/model-s-ultimate/). It really does make you learn to type faster. Or the relatively new one from Jeff Atwood - approproiately named the [Code Keyboard](https://codekeyboards.com/). Sure, they are in the range of $150. But trust me, buy a few, see what happens. 

#### 3. Healthy Team Role Ratio

This is another one of those "try it and adjust" things. But don't sell yourself short before giving it a chance. 

Here's what I'm talking about... try a ratio of developers to testers to analysts like this:

    3 Developers
    2 Testers
    1 Business analyst

In short, a dev/test/ba ration of 3/2/1. 

Yes, I know there are other ways to carve up a team. But in my experience, the typical risk and subsequent tragedy is that we create teams that are more like: 10 developers, 1 tester (or, sometimes, no testers), and maybe a half-time analyst. Instead of that insanity, start with a 3/2/1 ratio, run it for a while, and adjust based on velocity and feedback and outcome.

If you find yourself already in a situation where the ratio isn't even close to 3/2/1, I strongly encourage you to adjust - somehow. Maybe that means **giving up** some developers in return for some more testers. Crazy, I know!! But when the ratio is off, bad things happen. So the goal is to **fix the ratio** - not just pile on more developers.

The thinking that more developers means more better output is just foolish. It is the __team__ that delivers, the __team__ that has velocity, the __team's__ collective ability that releases software - NOT JUST DEVELOPERS. Fix the ratio, and you'll deliver more and deliver better and with less stress.

<img src="{{site.url}}/img/uploads/2015/05/gears.png" height="150" class="alignleft" />

Someone once told me that too many developers without enough analysts means the developers just make crap up to build. That's not good, as it's wasted time and money and increases frustration. Not enough testers means that **your users** find the bugs - instead of you. To say it another way, developers will undoubtedly create bugs. So the question isn't "how many bugs are there?", the question is "who's going to find them?!?!". A healthy ratio helps ensure that your own team finds the bugs - not the users. And of course too many analysts and not enough developers results in wasted time and wasted specs for features that never make it into the product. Essentially, the backlog gets longer and longer, and people just give up on ever seeing their "thing" make it into the product.

"3/2/1" - that's the ratio to aim for.



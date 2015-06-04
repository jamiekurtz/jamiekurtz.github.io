---
title: 10 Easy Tips For Lean and Clean Agile Development
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

I'm continually astounded by the massive cost in time/billable-hours companies incur for something as trivial as a second or third monitor. You can just about make up the cost of a monitor in a single day! 

I remember when 2nd monitors were just becoming popular, and I bought everyone on my team a second monitor to plug into their laptop. It cost me all of about $2000 total, and gained me something in the neighborhood of 30% increase in productiviy. Not to mention developer happiness. And, in this particular case, envy from developers on other teams in the company:)

Seriously, there's more than you think riding on a developer's ability to go fast and free. Freedom almost always wins!! And things like: good monitors, good keyboards, lots of RAM, plenty of CPU horsepower, and extra hardware lying around go **A LONG WAY** in offering freedom, increasing productivty, and overall keeping your top talent around a little longer.

<img src="{{site.url}}/img/uploads/2015/05/daskeyboard-ultimate.webp" width="175" height="175" class="alignright" />

The math is drop dead simple to do (e.g. $200 monitor to "buy back" an hour or two a day is a no brainer). Developer and tester happiness is a little harder to measure, but you can just ask, and watch, and listen. You claim to an agile shop - so try something new in the way of hardware, get some feedback, and adjust. These days, hardware is cheap, and people are expensive. And turnover is VERY expensive. So remember that the next time you're cringing at a mere $200 to double someone's RAM. 

If you don't believe me, try buying a nice keyboard for everyone on your team. I've been very happy with the [Model S Ultimate from daskeyboard](http://www.daskeyboard.com/model-s-ultimate/). It really does make you learn to type faster. Or the relatively new one from Jeff Atwood - approproiately named the [Code Keyboard](https://codekeyboards.com/). Sure, they are in the range of $150. But trust me, buy a few, see what happens. 

#### 3. Effective Team Ratio

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

"3/2/1" - that's the ratio to aim for. Try it, and adjust for maximum **team** quality and velocity. 

#### 4. Wednesday to Wednesday Iterations

These days many (if not "most") development teams are utilizing some form of iterations or sprints to manage their work stream. This generally means you agree to start on day X, and end on day Y. For some reason it seems like the natural inclination is to start on a Monday and end on Friday. But for a few reasons, this is less than optimal, and can be downright maddening.

When you end on a Friday, everyone pretty much works under the assumption that they really have the weekend to finish. So Friday usually slides into Monday. And for good reason. Why would you give a team only 5 days to do some amount of work when you can instead give them 7 (or, 12 instead of 14, etc.). 

Further, those personal days and short vacations usually include Fridays and Mondays, so the chances of missing people are quite a bit higher if you start and/or stop on Mondays and Fridays.

Then there's the typical human emotional baggage of Mondays and Fridays. Mondays kind of suck, and by Friday afternoon most people (at least, the hardest working and most efficient ones) are pretty well ready to be done. So forcing some big demo/wrap-up meeting every Friday from 2 to 5 is pretty pointless. Especially when you've got out-of-town consultants on board, as they are typically headed home by Friday afternoon. You'll do your team a favor by giving back their Monday mornings and Friday afternoons.

If you currently run your sprints/iterations Monday to Friday, try switching to starting and ending on a Wednesday. I'm confident you'll find that the team is more likley to be fully engaged, and with weekends in there they might even get more done from time to time.

#### 5. Implement Continuous Delivery First

Hands down, the most effective way to really supercharge your development team is to ensure that they are receiving feedback early and often. This means the software is available for testing and general use early and often. This means, then, that the build-test-package-deployment process MUST be automated, or else some poor schmuck will end up spending all of his time manually preparing for and deploying "builds" (and, typically, screwing them up). 

If those frequent "builds" and deployments aren't happening, then your team is - quite simply - wandering around in the dark guessing at what work needs to be done next. 

The agile way of building software requires feedback. There's no way around it. One of my co-workers once said "constant feedback is baked into the agile way of creating software". I agree wholeheartedly. So much so that I tell people "if you aren't doing Continuous Delivery, then you aren't agile". Period. 

To be fair, you can't just "turn on" [continuous delivery](http://continuousdelivery.com/) (CD). It does take some skill and experience. So maybe this particular trick isn't easy. **But you can** bring on a consultant that will make it easy. It generally doesn't take a ton of time for an engineer experienced in the ways of CD to right the ship. So if this is a new concept to you, reach out to me at [Fusion Alliance](http://www.fusionalliance.com). Either myself or a number of others would be happy to take a few weeks to turn on CD, and help your team realize the full potential of agile.

#### 6. Press Release on the Wall

I learned years ago that one of the best things you can do to keep a team moving forwward, and in the right direction, is to "start with the press release". Before you worry about the backlog, or the next sprint, someone (usually the product owner or product/program manager type) needs to write a one-pager on the user-oriented things that will be in the next release. There are tips and templates online for writing press releases. But the main idea is to create a target of-sorts, which the development team can use to maintain focus. It's all too easy to miss the forest from the trees when you're staring at scrum boards and user stories all day everyday.

What you want is a succinct list of brief business scenarios and user experience enhancements that all those user stories roll up into. Where a release might include a few dozen user stories (depending on the size of the release of, course), our one-pager should list at most maybe ten high-level scenarios. Many people nowadays call them epics. Regardless, they are intentionally higher level than the user stories. 

So here's the the best part: make your one-pager big and colorful, like on a poster board, and put it on the wall for the entire team to see. I've even used graphic artists to create the poster so that it looks nice, looks professional, and then had them printed at Kinko's on nice big glossy posters. Then as stories get completed, you can indicate epic-level progress on the poster. This works very well to make sure everyone's working towards the bigger things, and not losing sight of the desired enhancements to the user's experience. 

I'd even recommend adding a screen mockup or two, or other visualation, to the poster. If a couple dozen user stories will result in a new screen, then put a mockup of that very screen on the poster for all to see. Having those visuals in plain site on the wall can really help in the way of collaboration and brainstorming within the team. Further, it helps communicate to passers by what the team is currently working on.

If you're struggling to come up with those top 10-or-so things to put on a poster, try creating a [User Story Map](http://www.agileproductdesign.com/presentations/user_story_mapping/). To quote Jeff Patton, the creator of User Story Mapping: "A prioritized user story backlog helps to understand what to do next, but is a difficult tool for understanding what your whole system is intended to do." As you can see in the picture below, the Story Map helps you aggregrate individual stories into user-centric goals and activities. 

<img src="{{site.url}}/img/uploads/2015/05/Story_Map.png" />
*(image taken from http://leanagilechange.com/leanagilewiki/index.php?title=Story_Mapping)*

If we use that image as example, you might have the following high-level items in your poster:

- "Ability to enter new orders with our streamlined order-entry wizard"
- "No more waiting for long pauses while processing orders!"
- "New and improved shipping dashboard to quickly and easily see the current status of all shipments"

Here's another example using the power of User Story Mapping:

<img src="{{site.url}}/img/uploads/2015/05/UserStoryMap.png" />
*(image taken from http://winnipegagilist.blogspot.com/2012/03/how-to-create-user-story-map.html)*

Again, using that image as an example, we might include the following on our poster for Release 1:

- "Basic email search and organization"
- "Ability to create and read emails, including RTF-formatted messages"
- "Meeting scheduling functionality, including appointment requests and accept/reject responses"

These types of short descriptions hanging on the wall for all to see are a great way to ensure your development team doesn't get lost in the weeds. I dare you to try it out!

#### 7. Think Open Source Projects

One of the things I love most about open source projects... they typically have a very low barrier for developers and other people to get involved. An open source project must make it drop dead simple for someone to jump in, contribute, and move on. Those types won't survive if it's too hard to get your environment set up. 

Imagine if your own projects were set up the same way? Imagine if the tooling, documentation, and configuration of the source code and tests and backlog were such that anyone could pull up to the code (and/or backlog, etc.), spend a few minutes ramping up, and quickly get to adding value? 

Over the years I've more often than not seen enterprise/business teams that make it horribly hard to get involved. There's a bit of short-sited thinking around environment configuration, where everyone just relies on that one guy stopping by to offer a bit of critical tribal knowledge. And then it takes around a dozen of these undocumented and ad-hoc interactions in order to run the tests or run the app. And in my experience, days and even weeks go by while this is happening. If these were open source projects they wouldn't have survived the first week!

Even recently, at a large global client of ours, it took a small team literally two weeks to get their development environments set up. And not because it was **that** complicated (because it wasn't). It was because no one had taken the time to streamline the process, automate what could be automated, and simply write down all those things that half a dozen people had to step in and help with (in person, when they were available, not at lunch or on vacation, etc.).

There's also an emotional factor here, where developers these days are getting more accustomed to open source projects that are easy to jump into. So when yours sucks, when yours is a pain the neck, people will go elsewhere. The same as happens with overly difficult open source projects - the good developers and testers, the ones you want working on your project, they are the ones that won't put up with it.

So, here are some practical and generally easy things you can and should ensure on your project:

**First and foremost, and good README file**. A developer or tester should have to do literally nothing else beyond what is explained in the README in order to be up and running. If someone needs to ask "that guy" how to do something, you can do better. Remember, open source projects rely on all kinds of people, across many time zones, countries, and cultures. Try to think the same way.

**Leverage the power of a "go" script"**. In addition to an awesome README file, provide a single point of entry for automating anything that can possibly be automated. This means things like: database creation, environment variables or registry entries, SSL certificates, mutli-project compilations, running tests, running code analysis, and anything else commonly performed by developers. Sometimes you can implement your "go script" with a build tool, like Ant or MSBuild or Grunt or Gulp. Other times you might want to just use a shell script or DOS batch file. I've done this in the past by writing scripts that delegate off to other build tools and such. Here are some examples:

    ./go buildDb
    ./go dropDb
    ./go runTests
    ./go createCerts
    ./go clean
    ./go build
    ./go resetAll
    ./go init

Ideally, a new developer could clone the repository, quickly read through the README, run the `./go init` command, and be off to the races - all without requiring any ad-hoc tribal knowledge from anyone.

**Use great and popular tools**. There's nothing worse for a developer or tester or project manager than to start a new client or employer or project and be staring at an old or obscure source control or ticketing system. People quit jobs over crap like that. Developers will not hang around if they have to keep using old or difficult source control systems. At least not the good ones. Same is true for documentation tools, work item or ticketing tools, and build systems. A developer's decision to work with you can honestly come down to your tooling selection.

I suggest that if you aren't using them now, just go with the Atlassian toolset. Are there better ones out there? Sure, for some scenarios. But you'll spend more time and money trying to find "the perfect tool" than is worth it. Just about any developer or tester or PM worth hiring these days will have at least some familiarlity with the Atlassian tools. And if not those specific tools, then at least their general concepts (e.g. Git source control, Wiki-based sites, user stories and task boards). This means: Stash source control, Jira work item tracking, Confluence online sites and documentation, Bamboo build system, and HipChat for online chat and collaboration.

At the risk of sounding like a broken record... trust me. Model your enterprise projects after open source projects and your team will go much faster, more efficient, and will be much happier.

#### 8. Set aside "core programming hours"

As a software engineer, I can honestly say that one of the greatest gifts you can give a developer (or tester) is a consistence uninterupted block of time in which to work. The ability for your team members to get into a [flow](http://en.wikipedia.org/wiki/Flow_%28psychology%29) is crucial to its success in speed and efficiency. An environment conducive to flow (a.k.a. "the zone") is correspondingly an environment that fosters increased satisfaction and happiness, and reduced stress and frustration. 

Awareness of flow goes back thousands of years, with many studies on the topic over the past couple hundred. Bottom line, your team, your project, your product **needs** flow - and it's everyone's job to make sure it happens. Fight for flow. Don't let anyone or anything steal it from your team. 

This is where the concept of core programming hours comes into play. Try to ensure that each member of your development team has a good three or four hours everyday to get into flow - and stay there. Carve out time every day in which people know meetings won't happen, where phones can be turned off, and email and chat software can be shut down. Maybe start with only two hours at a time if that's all you can set aside. And then keep an eye on team velocity and overall well being. I gaurantee you will see increases in both.

#### 9. 







Architecture up front, with adequate docs and samples
Reduce branching, be careful of feature branches, favor lean and clean

Above the line - below the line, do whatever’s fastest separate from reporting
Feature toggles over branches
Release features is marketing and feature toggles
Bring in fresh blood, consultants… the different view is priceless
Dependencies kill! Ruthlessly remove them.


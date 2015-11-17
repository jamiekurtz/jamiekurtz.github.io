---
title: My Docker Light Bulb Moment
description: A small example illustrating what helped me understand Docker.
author: Jamie Kurtz
layout: blog-post
permalink: /2015/11/17/my-docker-light-bulb-moment/
thumbnail: /img/uploads/2015/11/docker.jpg
comments: true
categories:
  - Docker
  - Development
  - Continuous Delivery
  - Architecture
keywords: docker, containers, deployment, continuous delivery, architecture
---

As a consultant regularly dealing with builds and deployments, it's pretty common these days to get into discussions about [Docker](https://www.docker.com/). The problem solving potential of this tool is pretty amazing - once you understand what it does (and doesn't do). But honestly, most of the technologists I talk to don't have the foggiest idea what Docker is or what it can or should be doing for them.

Straight on the Docker website it says this: "Docker is an open platform for building, shipping and running distributed applications."

"OK???... that sounds cool. I think??"

Or this: "it's all about shipping containers!"

"OK???... what do shipping containers have to do with building and releasing software??"

Or "Docker lets you easily build, ship, and run microservices".

"Hmmmmmmmm"


#### So What Are We Really Talking About?

According to best practices related to deployment pipelines, the best thing you can do in building and deploying software is:

1. Create your deployable thing right up front in your build process
2. Test that thing
3. Sign and store the thing
4. Deploy the tested and signed thing to any number of environments

When it comes to software, we typically create ZIP files, JARs, installers, DLLs, or similar from the build process. This build output more-or-less represents an immutable and (hopefully) versioned package that we can deploy to testing and production environments. 

The problem is that our build output isn't all we need. It's only the application itself - not all the surrounding gunk needed to actually **run** the application.

Let's say we have a build process (e.g. in Jenkins) that pulls the code for a Node/Express app from a Git repo, runs various gulp or grunt tasks, and then creates a nice ZIP file containing all the files we need to run the thing. To deploy this ZIP file, we might follow steps like this:

1. Create a new Ubuntu server
1. Install NodeJS
1. Install a few global NPM packages
1. Install our database driver of choice
1. Maybe create some needed folders/files somewhere (e.g. to hold uploads or something)
1. Create a few environment variables (e.g. database connection string)
1. Create an Upstart/systemd "service" to run your NodeJS app
1. And finally, extract the ZIP file to a known location so the new service can run your app

While just an example, the above is fairly typical of a Node/Express deployment. Sure, for a single test server you might not repeat all those steps every time you deploy a new version. And you can certainly automate most/all of that using a simple shell script or more advanced tools like Chef/Puppet/Ansible. But at that point we are deploying a known and tested and signed app into a brand new environment that **wasn't** tested with the app! Further, we have to trust that whoever tries to run our app will actually follow those steps - automated or not. 

In the end, we deliver our nice tested app (i.e. the ZIP file) along with a Word doc and possibly some automation scripts. Not bad, but also not that reliable. A lot can go wrong in those first set of steps; especially when we try to scale out to many servers.

What we need is to **bundle the surrounding configuration and runtime with our app**. If we can pull that off, then all of the above steps will be baked into our signed and tested package - not just the application itself. To say it another way, it would be great if we could bundle up the results of ALL those steps - not just the last one.

It runs out, we can.


#### Docker = Application + Environment

With a .NET application you might use MSBuild to compile and package up your web site. With a Java Spring MVC application you might use Maven. And with JavaScripty things like Node you might use a set of Gulp tasks to create that final output ZIP file.

Now imagine one additional step where we add that build output to a runnable environment. This environment might be created a build time using steps similar to the ones listed in the previous section. The key difference being that we're doing this at build time - NOT deployment time. So now, our build output consists of not just a ZIP of our application, but an image of the entire environment needed to run the application (including the application itself, of course). 

What we've just built is a Docker image.


Further, scaling out means you will be doing all those steps a lot.




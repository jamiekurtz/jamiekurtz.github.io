---
title: My Docker Light Bulb Moment
description: A small example illustrating what helped me understand Docker.
author: Jamie Kurtz
layout: blog-post
permalink: /2015/11/17/my-docker-light-bulb-moment/
thumbnail: /img/uploads/2015/11/docker-small-question.jpg
comments: true
categories:
  - Docker
  - Development
  - Continuous Delivery
  - Architecture
keywords: docker, containers, deployment, continuous delivery, architecture
---

As a consultant regularly dealing with builds and deployments, it's pretty common these days to get into discussions about [Docker](https://www.docker.com/). The problem-solving potential of this tool is pretty amazing - once you understand what it does (and doesn't do). 

<img src="{{ site.url }}/img/uploads/2015/11/docker-big-question.jpg" alt="docker" width="175" class="alignleft size-thumbnail" />

But honestly, most of the technologists I talk to don't have the foggiest idea what Docker is or what it can or should be doing for them. Straight on the Docker website it says this: "Docker is an open platform for building, shipping and running distributed applications."

"OK???... that sounds cool. I think??"

Or this: "it's all about shipping containers!"

"OK???... what do shipping containers have to do with building and releasing software??"

Or, "Docker lets you easily build, ship, and run microservices".

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

It turns out, we can.


#### Docker = Application + Environment

With a .NET application you might use MSBuild to compile and package up your web site. With a Java Spring MVC application you might use Maven. And with JavaScripty things like Node you might use a set of Gulp tasks to create that final output ZIP file.

Now imagine one additional step where we add that build output to a runnable environment. This environment might be created at build time using steps similar to the ones listed in the previous section. The key difference being that we're doing this at build time - NOT deployment time. So now, our build output consists of not just a ZIP of our application, but an image of the entire environment needed to run the application (including the application itself, of course). 

What we've just built is a Docker image. And that image can be moved from one machine to another using built-in Docker tools and commands. So now all I need is a bare Linux box running Docker, and I can deploy my tested app along with its configuration and runtime. No need for the corresponding step-by-step instructions in Word, or even a set of provisioning scripts. Just run the Docker image!

Let's look at an example.

#### My Mongotools Image

A few months ago I was helping support a Node app that was built on MongoDb. I needed to connect to the database, but I didn't have all the Mongo tools installed on my laptop. I didn't really feel like installing them, either. I really just wanted to quick do a dump of a mongo database and move on. 

So I sat for a minute, wondering to myself... "how can I run `mongodump` without installing a bunch of stuff I don't really want right now?"

Docker to the rescue!

You can read all the ins and outs of Docker on their website, including a great set of tutorials. But bottom line, I created a Dockerfile with the following content:

    FROM ubuntu

    RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
    RUN apt-get update -y \
        && apt-get install -y mongodb-org-shell \
        && apt-get install -y mongodb-org-tools

Which allowed me to run the following to build my image:

    docker build -t jakurtz/mongotools .

It took a while the first time, as the base Ubuntu Docker image hadn't been cached yet. 

Once the image was built, I could simply run the following to be at a shell inside an environment that had all the mongo tools installed:

    docker run -it --rm jakurtz/mongotools

I can even alias this to something like mongotools:

    alias mongotools="docker run -it --rm jakurtz/mongotools"

Then anytime I need to run a mongo tool, I just need to type `mongotools` in my terminal and we're good to go!


#### Making Available on Docker Hub

Of course all of that, while totally awesome, is only good on the machine on which I built the Docker image. How do I share it, make it more useful across other machines and for other people?

You can use a public Docker registry called Docker Hub. This is very similar to [NPM](https://www.npmjs.com/) for Node packages, or [Nuget](https://www.nuget.org/) for .NET packages. Except that instead of just storing build output (i.e. ZIP, DLL, JAR files) as we discussed above, it is built to store entire Docker images. 

Given the mongotools image demonstrated in the previous section, I just had to run the following to make my new image available to anyone anywhere:

    docker push jakurtz/mongotools

That's it! You can actually see the image on [my Docker Hub page](https://hub.docker.com/u/jakurtz/). And once you have Docker installed on your machine, you can do the same as me:

    docker run -it --rm jakurtz/mongotools

The run command will by default pull images from Docker Hub. Once downloaded (which might take a few minutes the first time), you can run that command and instantly be at a shell that can run all the mongo tools.


#### In Conclusion

To bring it back around, the main point here is that my mongotools image delivers anyone a fully functional mongo environment - without having to follow any specific instructions or run any other deployment scripts (outside of installing Docker, of course). 

And this same can be true of web apps written in Node, or Ruby/Rails, or PHP. Or maybe you just want a Docker container running a database server - e.g. MySQL. Or a cache server with Redis. Here's a short sample of the images that are publicly available on Docker Hub:

- [Ubuntu](https://hub.docker.com/_/ubuntu/)
- [NodeJS](https://hub.docker.com/_/node/)
- [Redis](https://hub.docker.com/_/redis/)
- [Drupal](https://hub.docker.com/_/drupal/)
- [Wordpress](https://hub.docker.com/_/wordpress/)
- [MySQL](https://hub.docker.com/_/mysql/)

So if you want to run a local copy of Drupal, execute the following:

    docker run --name MyDrupal -d drupal

Give it a minute to download, and you'll have a fully functional Drupal site running inside your very own Docker container. It's a thing of beauty!

So remember... **Docker images give us the ability to bundle all dependencies and configuration with our applications**. And this approach is much more repeatable and reliable than building and shipping just the applications themselves.

_In a future post I'll be exploring how to use Docker to create consistent build environments for build machines and developers_.


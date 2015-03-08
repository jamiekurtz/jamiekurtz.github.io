---
title: Leveraging Continuous Delivery and Pandoc for Publishing Content
author: Jamie
layout: post
permalink: /2013/10/11/leveraging-continuous-delivery-and-pandoc-for-publishing-content/
dsq_thread_id:
  - 2032781498
categories:
  - Continuous Delivery
---
As a follow-up to a [previous post][1] on using continuous delivery to publish books, I&#8217;d like to explore the idea of leveraging an agile continuous delivery process to create and publish content.

Before we start, I want to say that I love Google Docs, and use it all the time for both personal and work-related documents. You simply can&#8217;t beat, or even come close to, the level and quality of collaboration Google has achieved. That said, I find myself wanting to fit content authoring (books, articles, blog posts, documentation) into the same &#8220;machine&#8221; that I use all the time as a developer. Really, the machine that we use as a software development organization. When we keep it simple and stick to the usual patterns and practices for agile development, this machine works very well, and is very fast,

In this post I hope to convince you of certain scenarios where this approach might work well. And then also illustrate a simple implementation option.

## Software Development {#software-development}

Just to make sure we&#8217;re on the same page, we know that software is composed of features. To build those features you start with some flavor of requirements &#8211; be they written down formally or just scratched onto a whiteboard. You then push features based on those requirements through the deployment pipeline: write code, run tests against the code, run tests against the app, deploy the app, file bugs, fix bugs (by writing more code), &#8230; and repeat.

We also have the concept of zero-bug-bounce. This comes into play when we want to know when is a good moment to ship our features (and corresponding bug fixes). Anyone involved in building and maintaining software knows that there will always be bugs, and you never find them all. Therefore, what we aim to do is reduce the gap between a theoretical number of bugs and the number of bugs found. The size of the gap defines the level of confidence we have when claiming that a release is ready to go. In other words, you may have found and fixed 200 bugs, but if you&#8217;re fairly certain that you should have found 1000 bugs, confidence is low in saying &#8220;done&#8221;. And only a seasoned development or test engineer would be able to provide that gut feel on how many bugs *should* be found.

Bottom line, we write software based on ideas and requirements, we test and deploy the software, find and file bugs, fix the bugs, and redeploy. Then at some point we become reasonably confident that we&#8217;ve both found and fixed &#8220;enough&#8221; bugs, and we deploy to a production environment. Hopefully this process isn&#8217;t new to you!

Ok, back to the point of this post&#8230; I&#8217;m proposing that some subset of documentation can and should follow a similar process. A user manual section or a book chapter or a more-than-trivial blog post; these are &#8220;features&#8221; that will have bugs, will need to be revised, and then redeployed. So rather than creating a separate workflow or process, and separate deployment mechanism, let&#8217;s leverage what we&#8217;ve already got in place.

*** Note: While the approach outlined below relies mostly on using [markdown][2] and a tool called [pandoc][3], there are certainly other options available. Tools like [HelpStudio][4] from Innovasys or [RoboHelp][5] from Adobe would, in theory, support this approach to building and deploying content.*

## The Approach {#the-approach}

This approach is actually quite simple, especially given that us developer-types are generally already familiar with how to manage source code, commit that code to version control, and run some continuous integration/delivery process to automagically deploy the build output to a server or other such drop location. Of course, we first must create some requirements or guidance documents. Personally, I find that using a mind map in [XMind][6] is a great way to organize my thoughts and create a roadmap for an article, a blog post, or a book chapter.

But since this post is about the technical details of creating and publishing content, let&#8217;s skip &#8220;requirements&#8221; and create some documentation source. For this example, I&#8217;m going to keep things super simple in terms of the sample document(s). We&#8217;ll simply create a title page and three very short chapters of a larger book. On my Linux Mint laptop, I might do something like this:  


<pre><!--DVFMTSC-->echo -e "% My Book \n% Jamie Kurtz" > ch00.md

echo -e "# Chapter 1 \nThis is Chapter 1 \n\n## Section 1-1 \nThis is Section 1-1 \n" > ch01.md

echo -e "# Chapter 2 \nThis is Chapter 2 \n\n## Section 2-1 \nThis is Section 2-1 \n" > ch02.md

echo -e "# Chapter 3 \nThis is Chapter 3 \n\n## Section 3-1 \nThis is Section 3-1 \n" > ch03.md</pre>

  
To string them together into a single document, I can just use the `cat` command:  


<pre>cat ch*.md<!--DVFMTSC--></pre>

  
Then to turn this set of markdown-formatted chapter files into a publishable piece of content, we could do any of the following (and more):  


<pre><!--DVFMTSC-->cat ch*.md | pandoc -s -o MyBook.html

cat ch*.md | pandoc -o MyBook.docx

cat ch*.md | pandoc -o MyBook.pdf

cat ch*.md | pandoc -o MyBook.epub</pre>

  
Or, maybe you want to keep the chapters as separate files &#8211; which might be especially useful for an HTML-based book or online user manual:  


<pre><!--DVFMTSC-->for file in ch*.md; do pandoc "$file" -o ${file/.md/.pdf}; done

<!--DVFMTSC--></pre>

  
To create PDF files with pandoc, you need to first install [LaTeX][7], a popular text-based file format used throughout the scientific community. It is substantially more flexible and descriptive than markdown. I recommend following the instructions for installing the full TexLive package as referenced here: http://www.tug.org/texlive/.

I don&#8217;t know about you, but being able to create some simple markdown files, and automatically turn them into an ePub file with a simple command&#8230; that is truly awesome.

> * * *
> 
> **Publishing to a WordPress API**  
> Though I haven&#8217;t tried it yet myself, there is a cool little plug-in for WordPress that allows you to create and edit blog posts via REST/JSON calls. So in theory, you could leverage this API at the end of your build process to push pandoc generated HTML to a WordPress site &#8211; automagically.  
> Here&#8217;s the plugin&#8217;s web site: <http://wordpress.org/plugins/json-api/>   
> I&#8217;m sure someday I&#8217;ll give it a try. Please let me know if you&#8217;ve already done so. I&#8217;d love to hear about your experience.</p> 
> 
> * * *

It is worth noting that pandoc can do a lot &#8211; much more than I care to get into here. But it does support quite a bit of formatting, various input and output options, as well as being able to define templates, table of contents, headers, footers, and processing variables. Pandoc can convert from and to many different formats &#8211; not just markdown. You can even author the original content files in JSON.

## When to Use {#when-to-use}

As we&#8217;ve discussed, this approach to publishing content is based on having &#8220;source&#8221; for our content that is distinctly separate from the output files, This is very similar, of course, to application source code and build output. As such, content where we&#8217;ve already separated source from output would make good candidates for this style of authoring and publication. This might include an application&#8217;s help system. An online article. An ePub book. Or even an entire book that is published online as a set of web pages. The point being that the files used to author the content is different from the files of its published form.

This approach might also benefit larger content projects authored by more than one person. Specifically if those developers are already accustomed to working with many files that are checked into a version control system. Again, similar to your typical application code base. Or, even non-developers that don&#8217;t mind learning to separate their content into multiple files, and use source control. In the past I&#8217;ve used HelpStudio in this fashion, where each help topic was a separate file, and all topics were checked into TFS. We then used some command-line tools within HelpStudio during the build process to compile the source files into both a CHM file and a set of HTML files.

Markdown itself also lets you separate images and styles from the actual content &#8211; very similar to how you would author pages with HTML. In other words, the combination of markdown and pandoc lets you keep images and CSS files separate from the actual content, and then merge them together into a single file. The pandoc website includes some examples where a CSS file is used to customize the look of the generated HTML file.

It also might work well (to treat content as a piece of software in development) for cases where you just want a clear separation between the person (or people) authoring the content and the people reviewing or approving it. This again lets the reviewers/approvers see and file bugs against the finished product. It also prevents those reviewers from editing the content directly &#8211; as they must file a bug and wait for the next build.

Another scenario, as mentioned above, might be when using a WordPress site &#8211; but you want to keep content such as blog posts separate and under version control. Using the json-api plugin, you can easily publish content straight into a WordPress site &#8211; even though the source content is maybe markdown or similar. I think it&#8217;s safe to say that the normal authoring technique to creating WordPress content is either directly in the admin site itself; or, using an offline blog writing tool &#8211; such as [Windows Live Writer][8].

Lastly, an obvious advantage to this approach would be the desire to have several output formats from one set of source files. For example, you may want the build process to create a Word doc, a PDF file, and a set of HTML files. Using a tool like pandoc as part of the automated build lets authors create the content once, and then via some simple configuration generate those various output files/formats for publication.

## Conclusion {#conclusion}

If you&#8217;ve followed my blog, or have seen me speak at user group gatherings, you know that I&#8217;m a huge fan of continuous delivery. It simply provides so much benefit to the process of creating and publishing software. I believe, however, that in much the same way that agile originated from outside the software development community, continuous delivery can greatly benefit the authoring and delivery of non-code pieces of functionality.

If you believe that using your version control system and continuous delivery &#8220;machine&#8221; might provide the benefits I outlined above, give it shot! And let me know how it goes. I&#8217;d love to explore this approach with others in the community.

* * *

> *Special thanks again to Jeff Pickett for reviewing and filing &#8220;bugs&#8221; for this post. I know he, like me, is always looking for better, faster, easier ways to build things &#8211; including content. Also, thanks to [Jarrett Meyer][9] for kicking around this idea with me. Vim and Markdown all the things!! <img src="http://www.jamiekurtz.com/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley" /> *

 [1]: http://www.jamiekurtz.com/2013/02/13/agile-continuous-delivery-with-books/
 [2]: http://daringfireball.net/projects/markdown/
 [3]: http://johnmacfarlane.net/pandoc
 [4]: http://www.innovasys.com/product/hs/overview
 [5]: http://www.adobe.com/products/robohelp
 [6]: http://www.xmind.net/
 [7]: http://en.wikipedia.org/wiki/LaTeX
 [8]: http://www.microsoft.com/en-us/download/details.aspx?id=8621
 [9]: http://www.jarrettmeyer.com
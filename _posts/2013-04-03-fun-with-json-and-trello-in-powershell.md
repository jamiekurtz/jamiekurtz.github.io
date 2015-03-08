---
title: Fun with JSON (and Trello) in PowerShell
author: Jamie
layout: post
permalink: /2013/04/03/fun-with-json-and-trello-in-powershell/
dsq_thread_id:
  - 1506416755
categories:
  - PowerShell
  - REST
---
[<img class="alignleft  wp-image-256" title="json-trello-ps" src="img/uploads/2013/04/json-trello-ps1.png" alt="" width="222" height="207" />][1]Like most people who&#8217;ve tried it, I love <a href="http://www.trello.com" target="_blank">Trello</a>. And like a lot of other developers, we use at <a href="http://www.fusionalliance.com" target="_blank">Fusion</a> for basic software project task board management. But&#8230; one thing that is **really missing** thus far is any capability remotely related to &#8220;reporting&#8221;. Even getting a list of list names or card names looks to be impossible (as of 4/3/2013, anyway).

Today I needed to copy a list of our cards over to a separate document to be reviewed by some project manger-ish folks and other stakeholders. Granted, we don&#8217;t have 100s of cards. But I really didn&#8217;t want to re-type all of their names manually; especially given that I will likely need to do this a few more times in the future. As a developer, and lover of the command line, I figured there must be a way to script out an alphabetical list of our card names.

Alas &#8211; with some Google-ing and PowerShell 3.0 (included in Windows 8; <a href="http://www.microsoft.com/en-us/download/details.aspx?id=34595" target="_blank">available for download on Windows 7</a>), &nbsp;I was able to get my names within a matter of a few minutes. Not to mention, it&#8217;s now repeatable &#8211; and I even learned how to mess with JSON in PowerShell, as well as download data directly from Trello.

## Prerequisites

If you want to follow along in your own PowerShell console, make sure you are either running Windows 8, or have <a href="http://www.microsoft.com/en-us/download/details.aspx?id=34595" target="_blank">PowerShell 3.0 installed on Windows 7</a>. I&#8217;m using some new commands not yet available in PowerShell 2.0.

To download data directly from Trello, I am going to use the new Invoke-RestMethod cmdlet in PowerShell 3.0. You could also use curl.exe, if you prefer. I quite regularly use the copy of curl that is included in the Git for Windows install:&nbsp;<https://code.google.com/p/msysgit/downloads/list>. Among many other Linux-based commands, curl.exe is included in the Git bin folder.

And, of course, if you want to download some Trello data, you need to have access to a Trello board. For this example, I&#8217;m going to use a <a href="https://trello.com/board/powershell-json-access/515cdb395543704e7f0004db" target="_blank">public board created just for this blog post</a> &#8211; which means you, too, should have read-only access to it for the purpose of the code below.*&nbsp;If you want REST access to a private board, read the following for help on obtaining and using your Trello application key:&nbsp;<https://trello.com/docs/gettingstarted/>.*

## Let&#8217;s Start With Just JSON

Before we worry about directly downloading from Trello, let&#8217;s start by loading some JSON in PowerShell. Navigate to the <a href="https://trello.com/board/powershell-json-access/515cdb395543704e7f0004db" target="_blank">public Trello board I created</a>, and click on the Options button on the right-hand side. Near or at the bottom of the list of options, you should see one titled &#8220;Share, Print, and Export&#8230;&#8221; &#8211; click it. Then click on the Export JSON option &#8211; which will download a file called &#8220;powershell-json-access.json&#8221; to a local folder. I&#8217;m going to assume in the code below that the file was downloaded to your Downloads folder.

Now open a PowerShell console. At the prompt, run the following command:  


<pre>PS> gc ~/downloads/powershell-json-access.json</pre>

  
That will simply pipe all of the board&#8217;s JSON data to the console as a big long string. To convert to a JSON object, run the following:  


<pre>PS> gc ~/downloads/powershell-json-access.json&nbsp;| convertfrom-json</pre>

  
You should now see the same content, only represented as a full-fledged PowerShell object &#8211; including properties for the relevant data from the Trello board.

Now, to see a list of all cards, let&#8217;s try this:  


<pre>PS>&nbsp;&nbsp;(gc ~/downloads/powershell-json-access.json | convertfrom-json).cards</pre>

  
That should result in a list of card objects &#8211; i.e. we&#8217;re reading the cards collection from the converted JSON object.

To get a list of the actual card names, I&#8217;m going to use the alias for Select-Object &#8211; i.e. &#8220;select&#8221; (sans quotes):  


<pre>PS>&nbsp;(gc ~/downloads/powershell-json-access.json | convertfrom-json).cards | select name</pre>

  
And finally, to&nbsp;alphabetize&nbsp;the names:  


<pre>PS>&nbsp;(gc ~/downloads/powershell-json-access.json | convertfrom-json).cards | select name&nbsp;| sort name</pre>

<div>
  Now let&#8217;s look at grabbing our board data directly from Trello&#8217;s REST API.
</div>

<div>
  &nbsp;
</div>

## Direct Download from Trello

<div>
  The only real difference from above is the <em>source</em> of the JSON we&#8217;re using. In the case of Trello, anyone can perform an HTTP GET against a public board. So, using the&nbsp;<a href="https://trello.com/board/powershell-json-access/515cdb395543704e7f0004db" target="_blank">public board I created for this post</a>, run the following command:
</div>

<pre>PS>&nbsp;invoke-restmethod "https://api.trello.com/1/boards/515cdb395543704e7f0004db"</pre>

<div>
  The Invoke-RestMethod cmdlet automatically converts JSON content into a JSON object &#8211; so we no longer need to use the ConvertFrom-JSON cmdlet. Note that the returned data represents the basic board information &#8211; without any list or card data. So let&#8217;s now update our GET request to tell Trello to include this information:
</div>

<pre>PS>&nbsp;invoke-restmethod "https://api.trello.com/1/boards/515cdb395543704e7f0004db?lists=open&cards=open"</pre>

<div>
  The returned JSON object should now include two additional collection properties: lists and cards. And, similar to the commands above, we can list out the card names as follows:
</div>

<pre>PS>&nbsp;(invoke-restmethod "https://api.trello.com/1/boards/515cdb395543704e7f0004db?lists=open&cards=open").cards | select name | sort name</pre>

<div>
  &nbsp;
</div>

## Even More Fun

Now that we&#8217;ve established that we can play with JSON objects in PowerShell, and we can also use Invoke-RestMethod to download JSON-formatted data directly from Trello (or, for that matter, any other REST endpoint), let&#8217;s look at a few other PowerShell capabilities.

Run the following commands to get a table of cards and their associated statuses (where the status names are just the list names where the cards reside).  


<pre>PS>&nbsp;$j = invoke-restmethod "https://api.trello.com/1/boards/515cdb395543704e7f0004db?lists=open&cards=open"
PS>&nbsp;$lists = @{}
PS>&nbsp;$j.lists | % {$lists.add($_.id, $_.name)}
PS>&nbsp;$j.cards | select Name, @{name="status"; expression={$lists[$_.idList]}}, due</pre>

  
With those commands, you should see a list of cards and their associates status names and due dates. The &#8220;%&#8221; alias is used as a for-each in PowerShell, which we&#8217;re leveraging to add our list IDs and names to an empty hash table called $lists. Then we use the select alias, along with a computed property, to create a table of cards, their status values, and their due dates.

To show one more little PowerShell trick related to a formatted table and some grouping, try these commands (assuming you ran the previous set of commands):

<div>
  <pre>PS>&nbsp;$status = $j.cards | select Name, @{name="status"; expression={$lists[$_.idList]}}, due | sort status, due
PS>&nbsp;$status | ft -groupby status -property name, due</pre>
</div>

<div>
  At this point, you could pipe the output to your clipboard like this:
</div>

<pre>PS>&nbsp;$status | ft -groupby status -property name, due | clip</pre>

<div>
  And then simply paste the contents into an email to your boss!
</div>

<div>
  &nbsp;
</div>

<div>
  <em>&nbsp;</em>
</div>

<div style="padding-left: 30px;">
  <em>In this post, I covered how to download JSON data from a REST service within PowerShell. If you would like to build a REST service with the ASP.NET Web API, and aren&#8217;t sure where to start, check out my latest book&nbsp;<a href="http://www.amazon.com/Using-ASP-NET-Web-API-MVC/dp/1430249773" target="_blank">ASP.NET MVC 4 and the Web API: Building a REST Service from Start to Finish</a> .</em>
</div>

 [1]: img/uploads/2013/04/json-trello-ps1.png
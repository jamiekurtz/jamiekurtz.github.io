---
title: Custom NuGet Packages Directory
author: Jamie
layout: blog-post
permalink: /2012/10/11/custom-nuget-packages-directory/
jabber_published:
  - 1350010800
categories:
  - Uncategorized
---
Most of the source trees for .NET projects I create look something like this:

<pre>/trunk
   /docs
   /lib
      /log4net
      /Moq
      /NHibernate
      /Nunit
   /src
      /ProjectFolder1
      /ProjectFolder2
      /MySolution.sln
</pre>

By default, however, NuGet puts all libraries in a packages folder at the same folder level as the solution file &#8211; i.e. a peer to the project folders. That means my source tree would look like this instead:

<pre>/trunk
   /docs
   /src
      /ProjectFolder1
      /ProjectFolder2
      /packages
         /log4net
         /Moq
         /NHibernate
         /Nunit
      /MySolution.sln
</pre>

Well&#8230; I don&#8217;t like that!! So, in order to force NuGet to use **my** source tree structure &#8211; i.e. not put a packages folder next to my solution file &#8211; I create a small NuGet config file right in the src folder. Like this:

<pre>/trunk
   /docs
   /lib
      /log4net
      /Moq
      /NHibernate
      /Nunit
   /src
      /ProjectFolder1
      /ProjectFolder2
      /MySolution.sln
      /nuget.config
</pre>

The content of the nuget.config file is:

<div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;margin:20px 0 10px;width:97.5%;font-family:'Courier New', courier, monospace;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;padding:4px;" id="codeSnippetWrapper">
  <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">settings</span><span style="color:#0000ff;">&gt;</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span>     <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">repositorypath</span><span style="color:#0000ff;">&gt;</span>..lib<span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">repositorypath</span><span style="color:#0000ff;">&gt;</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span> <span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">settings</span><span style="color:#0000ff;">&gt;</span></pre>
    
    <!--CRLF-->
  </div>
</div>

You might need to close and reopen Visual Studio if you create the nuget.config while the solution is open.
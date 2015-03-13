---
title: Composite Application Library (“PRISM”) and loading modules from multiple directories
author: Jamie
layout: blog-post
permalink: /2012/07/12/composite-application-library-prism-and-loading-modules-from-multiple-directories/
categories:
  - Uncategorized
---
I’m working on a project where we are using the <a href="http://www.codeplex.com/CompositeWPF" target="_blank">Composite Application Library from Microsoft’s patterns & practices team</a>. You can read the official documentation on that site and on <a href="http://msdn.microsoft.com/en-us/library/cc707819.aspx" target="_blank">MSDN</a> for all the details, but basically the CAL allows you to build applications using totally decoupled modular components – or “modules” in CAL vernacular. These modules are discovered at runtime and are registered in the CAL container, which then handles each modules’ loading, showing, unloading, etc. (I’m greatly simplifying here).

To enable runtime module discovery, you can pick between one of four different “cataloging” methods:

  * Populate from code 
  * Populate from XAML 
  * Populate from a configuration file 
  * Populate from a directory 

The fourth one, populating from a directory, is what we wanted to use. This method of cataloging allows you to drop modules into a directory and have them picked up by the CAL. Essentially, it examines all assemblies in the directory and looks for types decorated with the ModuleAttribute attribute. 

The CAL’s implementation of this directory cataloging only allows for a single directory. It does this through the DirectoryModuleCatalog catalog. As taken from the CAL’s documentation, the following example will configure your application to search in a Modules subdirectory for all modules:

<div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;margin:20px 0 10px;width:97.5%;font-family:'Courier New', courier, monospace;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;padding:4px;" id="codeSnippetWrapper">
  <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> <span style="color:#0000ff;">protected</span> <span style="color:#0000ff;">override</span> IModuleCatalog GetModuleCatalog()</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span> {</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>     <span style="color:#0000ff;">return</span> <span style="color:#0000ff;">new</span> DirectoryModuleCatalog() {ModulePath = <span style="color:#006080;">@".Modules"</span>};</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span> }</pre>
    
    <br /> <!--CRLF-->
  </div>
</div>

Very cool!! But… we need to search through **multiple** directories – not just a single directory.

Long story short, I was able to subclass the DirectoryModuleCatalog to create a new directory-based catalog that can search as many directories as you want to give it. Now, you might laugh at my new catalog, but it does work!! Here it is:

<div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;margin:20px 0 10px;width:97.5%;font-family:'Courier New', courier, monospace;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;padding:4px;" id="codeSnippetWrapper">
  <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> <span style="color:#008000;">/// &lt;summary&gt;</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span> <span style="color:#008000;">/// Allows our shell to probe multiple directories for module assemblies</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span> <span style="color:#008000;">/// &lt;/summary&gt;</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span> <span style="color:#0000ff;">public</span> <span style="color:#0000ff;">class</span> MultipleDirectoryModuleCatalog : DirectoryModuleCatalog</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span> {</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum6">   6:</span>     <span style="color:#0000ff;">private</span> <span style="color:#0000ff;">readonly</span> IList&lt;<span style="color:#0000ff;">string</span>&gt; _pathsToProbe;</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum7">   7:</span>      </pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum8">   8:</span>     <span style="color:#008000;">/// &lt;summary&gt;</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum9">   9:</span>     <span style="color:#008000;">/// Initializes a new instance of the MultipleDirectoryModuleCatalog class.</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum10">  10:</span>     <span style="color:#008000;">/// &lt;/summary&gt;</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum11">  11:</span>     <span style="color:#008000;">/// &lt;param name="pathsToProbe"&gt;An IList of paths to probe for modules.&lt;/param&gt;</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum12">  12:</span>     <span style="color:#0000ff;">public</span> MultipleDirectoryModuleCatalog(IList&lt;<span style="color:#0000ff;">string</span>&gt; pathsToProbe)</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum13">  13:</span>     {</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum14">  14:</span>         _pathsToProbe = pathsToProbe;     </pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum15">  15:</span>     }</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum16">  16:</span>  </pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum17">  17:</span>     <span style="color:#008000;">/// &lt;summary&gt;</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum18">  18:</span>     <span style="color:#008000;">/// Provides multiple-path loading of modules over the default &lt;see cref="DirectoryModuleCatalog.InnerLoad"/&gt; method.</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum19">  19:</span>     <span style="color:#008000;">/// &lt;/summary&gt;</span></pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum20">  20:</span>     <span style="color:#0000ff;">protected</span> <span style="color:#0000ff;">override</span> <span style="color:#0000ff;">void</span> InnerLoad()</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum21">  21:</span>     {</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum22">  22:</span>         <span style="color:#0000ff;">foreach</span> (<span style="color:#0000ff;">string</span> path <span style="color:#0000ff;">in</span> _pathsToProbe)</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum23">  23:</span>         {</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum24">  24:</span>             ModulePath = path;</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum25">  25:</span>             <span style="color:#0000ff;">base</span>.InnerLoad();</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum26">  26:</span>         }</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum27">  27:</span>     }</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum28">  28:</span> }</pre>
    
    <br /> <!--CRLF-->
  </div>
</div></p> 

All you need to do is provide an IList<string> of paths – that’s it! So, to update the CAL’s sample:

<div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;margin:20px 0 10px;width:97.5%;font-family:'Courier New', courier, monospace;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;padding:4px;" id="codeSnippetWrapper">
  <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> <span style="color:#0000ff;">protected</span> <span style="color:#0000ff;">override</span> IModuleCatalog GetModuleCatalog()</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span> {</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>     IList&lt;<span style="color:#0000ff;">string</span>&gt; pathsToProbe = GetPathsToProbe();</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span>     <span style="color:#0000ff;">return</span> <span style="color:#0000ff;">new</span> MultipleDirectoryModuleCatalog(pathsToProbe);</pre>
    
    <br /> <!--CRLF-->
    
    <br /> 
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span> }</pre>
    
    <br /> <!--CRLF-->
  </div>
</div>

<img src="http://geekswithblogs.net/jkurtz/aggbug/137638.aspx" width="1" height="1" />
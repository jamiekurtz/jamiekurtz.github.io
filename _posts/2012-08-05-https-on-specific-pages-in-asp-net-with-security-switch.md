---
title: HTTPS on Specific Pages in ASP.NET with Security Switch
author: Jamie
layout: blog-post
permalink: /2012/08/05/https-on-specific-pages-in-asp-net-with-security-switch/
jabber_published:
  - 1344218140
categories:
  - Uncategorized
---
The <a href="http://code.google.com/p/securityswitch/" target="_blank">Security Switch</a> library saved me a lot of time on a recent ASP.NET project. It allows you to designate which pages require HTTPS by simple listing their paths in the web.config file:

> *Security Switch enables various ASP.NET applications to automatically switch requests for pages/resources between the HTTP and HTTPS protocols without the need to write absolute URLs in HTML markup.*

Like this:

<div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;margin:20px 0 10px;width:97.5%;font-family:'Courier New', courier, monospace;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;padding:4px;" id="codeSnippetWrapper">
  <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">securitySwitch</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span>     <span style="color:#ff0000;">mode</span><span style="color:#0000ff;">="RemoteOnly"</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>     <span style="color:#ff0000;">xmlns</span><span style="color:#0000ff;">="http://SecuritySwitch-v4.xsd"</span> <span style="color:#ff0000;">xmlns:xsi</span><span style="color:#0000ff;">="http://www.w3.org/2001/XMLSchema-instance"</span> <span style="color:#ff0000;">xsi:noNamespaceSchemaLocation</span><span style="color:#0000ff;">="SecuritySwitch-v4.xsd"</span><span style="color:#0000ff;">&gt;</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span>     <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">paths</span><span style="color:#0000ff;">&gt;</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span>         <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">add</span> <span style="color:#ff0000;">path</span><span style="color:#0000ff;">="~/Login.aspx"</span> <span style="color:#0000ff;">/&gt;</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum6">   6:</span>         <span style="color:#0000ff;">&lt;</span><span style="color:#800000;">add</span> <span style="color:#ff0000;">path</span><span style="color:#0000ff;">="~/Default.aspx"</span> <span style="color:#0000ff;">/&gt;</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:white;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum7">   7:</span>     <span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">paths</span><span style="color:#0000ff;">&gt;</span></pre>
    
    <!--CRLF-->
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;margin:0;width:100%;font-family:'Courier New', courier, monospace;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;"><span style="color:#606060;" id="lnum8">   8:</span> <span style="color:#0000ff;">&lt;/</span><span style="color:#800000;">securitySwitch</span><span style="color:#0000ff;">&gt;</span></pre>
    
    <!--CRLF-->
  </div>
</div>

Unfortunately, it doesn’t [yet] work with ASP.NET MVC Framework routes.
---
title: 5 Keys To Web App Token Authentication
description: Understanding how to leverage token-based authentication in web sites where Facebook or Twitter OAuth integration isn't possible.
author: Jamie Kurtz
layout: blog-post
permalink: /2014/11/25/5-keys-to-web-app-token-authentication/
thumbnail: /img/uploads/2014/11/token-150x150.jpg
comments: true
dsq_thread_id:
  - 3263472479
categories:
  - AppSec
  - Architecture
  - REST
keywords: json web token, jwt, rest, asp.net web api, nodejs, authentication, authorization
---

There are many scenarios where using token-based authentication is desired, but leveraging OAuth-based authentication against Facebook or Twitter in your web application or RESTful API isn&#8217;t possible.

<img src="{{ site.url }}/img/uploads/2014/11/token-150x150.jpg" alt="token" width="150" height="150" class="alignleft size-thumbnail wp-image-425" />

As a consultant, where the bulk of the sites and web APIs we build are line-of-business applications over existing databases (specifically, existing users), most of the time we can&#8217;t simply forgo our own custom authentication. In fact, I don&#8217;t believe I&#8217;ve ever seen an enterprise application where taking a user&#8217;s Twitter-provided OAuth token would have been an acceptable solution. We simply aren&#8217;t working on social-enabled web applications. Nor are we building mobile apps where customers want their users to log in with social accounts.

But that doesn&#8217;t mean we need to completely throw out token-based authentication. In fact, I much prefer leveraging JSON Web Tokens for traditional server-rendered web sites, Single Page Applications making AJAX calls, and RESTful APIs supporting mobile applications. In the end, I believe claims-based tokens are an excellent way to know who&#8217;s accessing your application and what they are allowed to do &#8211; even for the cases where you need to utilize existing usernames and passwords in an existing database or other credential store.

In this post I want to share five keys to understanding token-based authentication in your web and mobile applications. This is not an explanation of how OAuth works, nor is it instructions for implementing one of the OAuth grant types. In fact, I&#8217;m not going to show you any code! Crazy, I know. But as I spend time helping developers architect and implement authentication/authorization, the main gap seems to be an understanding of the basic idea of token-based authentication. There doesn&#8217;t seem to be much trouble finding an appropriate library or blocks of code on Stack Overflow.

As such, the purpose of this post is to help you understand the underlying flow of data involved in utilizing tokens in those cases where you need to validate user credentials against an existing set of usernames and passwords in some internal database. I.e. those cases where OAuth with Facebook simply isn&#8217;t an option.

## Five Keys {#five-keys}

Let&#8217;s look at what I consider to be five keys to understanding token-based authentication. First, in this context, **a token is just a collection of claims**. A claim is simply a key-value pair. For example, `username: bsmith`, or `email: bsmith@example.com`. To see an example of and create your own JSON Web Token (JWT), you can visit my [Online JSON Web Token Builder][1]. On that page you will see that the format of a JWT is very simple &#8211; again, just a collection of key-value pairs that "claim" something about the caller: "My name is Bob Smith, and my email address is bsmith@example.com", etc. Some claims are special (e.g. expiration date). My online token builder includes a handful of these special claims. You can see them all [here][2].

Here&#8217;s an example token (in raw form, prior to signing and base64 encoding):

<pre>{
        "iss": "Online JWT Builder",
        "iat": 1416797419,
        "exp": 1448333419,
        "aud": "www.example.com",
        "sub": "jrocket@example.com",
        "GivenName": "Johnny",
        "Surname": "Rocket",
        "Email": "jrocket@example.com",
        "Role": [
            "Manager",
            "Project Administrator"
        ]
    }
</pre>

The first five claims in that token are a subset of the special &#8211; or, reserved &#8211; claims. Most libraries used in processing JSON Web Tokens will understand these special claims.

Now that we know a JWT is just a collection of claims, the second key is to make sure these claims **include enough user properties sufficient to avoid hitting the database on subsequent requests**. This is important for a couple of reasons. First, and most obvious, you can avoid the performance hit of performing the exact same database call on every single web or AJAX request. The idea here is that the user&#8217;s properties (e.g. email address, first and last name, roles) will likely not change from one request to another. So we don&#8217;t really need to take the database hit on every request.

Second, you will find that a stand-alone token &#8211; one that contains all relevent claims for the user &#8211; is much easier to work with in development, testing, and production troubleshooting. And since our token includes all that we need to know the identity and roles of the caller, we can simply convert the claims to a User (e.g. an IUserPrincipal in .NET, a simple User object literal in NodeJS). This operation is a mere copying of claims from the token to properties on a user object. Remember, a database call to get more information is not required.

At this point we have a token that contains claims that tell us all we need to know about a user/caller. Exactly how you validate a user&#8217;s credentials and generate the token will depend on your platform and selected library. But in the end, you authenticate the user, generate a token, and associate it with the caller. For a web site, this is typically done with a browser cookie. For a non-browser client, we simply provide the token for them to submit in the header of subsequent HTTP requests. The third key, then, is that your **web site will examine the incoming cookie collection and the HTTP Authorization header for the expected token**. We don&#8217;t really care where it is, as long as the token is present on all HTTP requests.

And with that, we arrive at the fourth key. Because we are checking both the cookie collection and the HTTP Authorization header, we can **support both browser and non-browser clients all with the same token and same token validation code**. Any HTTP GET or POST, for example, a page request or a form submission, will include the cookie that contains the token that identifies the user. The same applies to AJAX requests from JavaScript/jQuery code &#8211; i.e. AJAX requests automatically include all cookies for the web site. And finally, any non-browser clients calling into your site &#8211; e.g. a mobile application consuming your REST API &#8211; will submit the token via the HTTP AUthorization header. Same token, same token validation code, just a different spot in the HTTP request.

Now, you maybe wondering&#8230; if any caller can just toss a token on an HTTP request to our web site, how do we know it is valid? Or, more accurately, how do we know that *we* generated the token? In essence, how do we know the token&#8217;s content (i.e. its claims) can be trusted? In the world of web site security, trust is paramount. We absolutely must be able to trust that the claims in the token are true and haven&#8217;t been tampered with. For this, we sign the token. **If a token is signed, then we can trust it was created by our own site**. This is our fifth and final key. Validation of the token&#8217;s signature is typically left to a 3rd party library of some kind, so we won&#8217;t go into those details here.

To summarize the five keys&#8230; we are using what&#8217;s called a JSON Web Token (JWT), which is simply a collection of claims the caller is making about himself. Because the token includes all claims necessary to both identify and authorize the caller, we can avoid querying the database on every request in order to fetch user properties. We will examine the HTTP request&#8217;s cookie collection and Authorization header for the token, which allows both browser-based and non browser-based clients to securely use our web site and API. And finally, because the token was signed by our own site, and we can easily verify its signature on every HTTP request, we can take the token&#8217;s claims as truth, and simply copy those individual claims to a user object associated with the request. In this way all downstream code will have access to the caller&#8217;s name, email address, roles, favorite color, date of birth, whatever is needed.

## Logging In {#logging-in}

The first thing a user is going to do on your site is log in. As such, we need to make sure the login process not only validates the user&#8217;s credentials, but also creates our signed JWT with all necessary claims. Then the application just needs to set the newly created JWT as a cookie on the HTTP response. This process is shown below. Note that I haven&#8217;t referenced any specific language or library. This is intentional as the process is the same no matter your underlying platform.

![][3]

To start the login process, the user&#8217;s browser posts his/her credentials to your server code &#8211; i.e. some kind of login route or action. The route or action will validate those credentials against the existing credential store. Assuming the credentials are valid, the server code will then get the user information from the database (or, other user store) &#8211; for example, a Users table in a database, or a user record in Active Directory.

Using the various properties on the new user object, your code will create claims for a token, accumulating the claims into token data. Remember, the claims are just name-value pairs. And those claims should include enough information for you to simply convert them into a full-blown user object on subsequent requests (which we&#8217;ll look at shortly). If working within a NodeJS application, these claims would look similar to the raw JSON text shown earlier in this post. Don&#8217;t forget to set the "special" reserved claims &#8211; e.g. iss, exp, aud, sub.

Next, in order to create a signed JWT, we need a signing key. In most cases, this key can be just about anything. Some libraries are pickier than others, so make sure you use a key that is appropriate for your given platform and JWT library. My own [Online JSON Web Token Builder][1] web site allow you to create 32, 64, and 128 byte keys. Some libraries will also support the use of asymmetric private keys &#8211; e.g. from an X.509 certificate. The [JwtAuthForWebAPI][4] .NET Nuget package I created allows for either symmetric keys or certificates. Regardless, you would typically use the platform&#8217;s config system to retrieve a signing key.

Then we use some kind of library to create the actual signed and base64-encoded JWT &#8211; given the signing key we just retrieved from config. Finally, we use the current request&#8217;s response object to set a cookie whose value is our signed JWT. I usually name the cookie "usertoken" or "ut" or something similar. Remember to set the HttpOnly and Secure flags on the cookie!

At the conclusion of this login process, the user&#8217;s browser contains a cookie that will grant them access to your web site &#8211; both web page browsing *and* jQuery AJAX calls (since all AJAX calls automatically include the site&#8217;s cookies). And the cookie&#8217;s value &#8211; i.e. the JWT &#8211; is signed, so you know you can trust it. If anyone tampers with the token&#8217;s claims, signature validation will fail, and you can prevent the user from further access.

#### Non-browser Support {#non-browser-support}

At this point, in order to support non-browser clients, you simply need to provide a RESTful endpoint that accepts a caller&#8217;s credentials, and returns the same signed JWT we just created above. Only this time, we aren&#8217;t using the request&#8217;s response object to set a cookie. We merely want to return the token to the caller as part of a JSON response (or similar). The non-browser client will then set an HTTP Authorization header on all subsequent requests, with the header&#8217;s value being of the form: "Bearer the_jwt" &#8211; sans quotes.

## Resource Protection {#resource-protection}

Now let&#8217;s examine the process of protecting your site&#8217;s resources using the signed JWT from above. Per one of our five keys defined previously, we can expect the token to exist in either the request&#8217;s cookie collection, or, in the HTTP Authorization header. Either way, we don&#8217;t care &#8211; as long as one of those slots contains the token.

The entire validation and protection process is shown below.

![][5]

The start, the client (e.g. browser, mobile application) makes an HTTP request to our server, trying to access a protected resource. By that we just mean a web page or other resource for which the caller must be authorized to view.

#### The Middleware Hook {#the-middleware-hook}

Per the platform we&#8217;re working with, we will have some sort of middleware hook in place to intercept the request and do some token-based validation. In ASP.NET Web API this would be a DelegatingHandler. If writing a NodeJS/ExpressJS application, a simple function callback will do.

As mentioned previously, we need to check first in the request&#8217;s cookie collection for our JWT. If not found, then we look for our token in the Authorization header. If neither location contains the token we expect, then we&#8217;re done and we let the processing of the request continue. Note that we don&#8217;t want to generate a 401 HTTP response at this point &#8211; because we don&#8217;t actually know that the requested resource even requires an authorized user.

Conversely, if the token is present, then we need to do some validation. First we retrieve our signing key from the config system. Then we use it to decode the signed and based64-encoded token string. If the signature is valid, we will end up with a token object of some kind that includes the original claims data we created during the login process (described in the previous section).

Next we need to validate some of the claims &#8211; namely, the expiration date (exp), intended audience (aud), not valid before value (nbf), and any other claims information we feel necessary to validate. If any of the validation fails, we simple halt the validation process and let the request process continue. Again, we aren&#8217;t interested in preventing a caller from accessing a resource just yet. We&#8217;re only trying to create a valid User object.

Assuming validation succeeds, we then convert the token&#8217;s claims to a User object, and then set the new User object on the request thread or request object (depending on the underlying platform). Now all downstream code will have access to a User object &#8211; including any checks of the caller&#8217;s roles.

All of the steps we just covered typically happen within the site&#8217;s middleware hook, which is intended to intercept every single HTTP request. So we haven&#8217;t yet gotten into any application routes or resources or API endpoints.

#### Resource Authorization {#resource-authorization}

Once the process above completes, the actual resource or route code can execute. And since we should have a valid User object at this point, we can check that its roles allow it to access the resource. For example, in an ASP.NET MVC or Web API application this is usually accomplished with an attribute on a route or controller action. Regardless, if the user&#8217;s roles don&#8217;t allow access; or, if a user object doesn&#8217;t even exist (i.e. if the middleware code wasn&#8217;t able to successfully validate the incoming token), then we can at this point return a 401 HTTP response to the caller. Or, sometimes a 403.

It is important to realize that the process of looking for and converting a token into a User object is separate from that of authorizing the user for the requested resource. In some cases, for example resources that are allowed to be accessed by an anonmyous user, not finding a valid token is ok &#8211; it&#8217;s up to the resource to decide.

## In Closing {#in-closing}

I want to close by saying again that it is generally preferable to use a 3rd party token issuer or sign-on server of some kind. Leveraging a user&#8217;s Facebook or Twitter account to obtain an OAuth token is definitely a great way to go. But as I stated above, I haven&#8217;t seen too many enterprise applications where the client wanted its users to sign in with a social account. And many times an old legacy application has already been running for quite some time, and so they already have users and users&#8217; credentials &#8211; and they don&#8217;t want to mess with those. So this post was really about using JWT-based authentication in those scenarios where you have to work with a custom credential store (e.g. a Users table in a database).

Here again are my five keys to remember for token authentication:

  * A token is just a collection of claims
  * Include enough user properties sufficient to avoid hitting the database on subsequent requests
  * Your web site will examine both the request&#8217;s cookie collection and HTTP Authorization header for the expected token
  * Because of this, you can support both browser and non-browser clients with the same token and same token validation code
  * Since the token is signed, you can trust that it was created by your own site, and so can accept the token&#8217;s claims as truth

&nbsp;

*As promised, I didn&#8217;t show any code in this post. If you have trouble finding code or libraries that turn this information into something that works, please let me know in the comments below and I&#8217;ll put some examples together.*

 [1]: http://jwtbuilder.jamiekurtz.com
 [2]: http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html
 [3]: http://www.websequencediagrams.com/cgi-bin/cdraw?lz=dGl0bGUgRWFzeSBUb2tlbiBBdXRoZW50aWNhdGlvbiAtIExvZ2dpbmcgSW4KCgoKCkJyb3dzZXIgLT4gTG9naW4gQWN0aW9uOiBQT1NUIGNyZWRlbnRpYWxzCgATDCAtPiBDABMJIFN0b3JlOiBWYWxpZGF0ZQAaHVVzZXIAKQhnZXRVc2VyKHVzZXJuYW1lKQoAFAogLQCBAhFVc2VyAHYRAIEoDkNyZWF0ZSB0b2tlblxuZGF0YSBmcm9tABgjR2V0IHNpZ25pbmcga2V5XG4AMwVjb25maWcAgWsRSldUIExpYnJhcnk6IGMAbwVKV1QoAHIFRGF0YSwga2V5KQoAHAsAgTwTU2lnbmVkIEpXVACCSxFSZXNwb25zZSBPYmplY3Q6IFNldCBjb29raWUgd2l0aAAwBQAWDwCCLAUAg0gHOiBTRVQtQ09PS0lFLCAzMDIgdG8gaG9tZSBwYWdlCgo&#038;s=vs2010
 [4]: https://www.nuget.org/packages/JwtAuthForWebAPI/
 [5]: http://www.websequencediagrams.com/cgi-bin/cdraw?lz=dGl0bGUgRWFzeSBUb2tlbiBBdXRob3JpemF0aW9uIC0gUmVzb3VyY2UgUHJvdGVjdGlvbgoKCkNsaWVudCAtPgAPCGVkACEJOiBHRVQvUE9TVApNaWRkbGV3YXJlIEhvb2sgLT4gUmVxdWVzdCBPYmplY3Q6IExvb2sgZm9yIHQAegVpbiBjb29raWVzCm5vdGUgcmlnaHQgb2YgADwPCiAgIElmIG5vdCBmb3VuZCxcbmNoZWNrAIE7BSBoZWFkZXJcbmZvciBCZWFyZXIgc2NoZW1lCmVuZCBub3RlAGU2AIIPDgBgBgoKAIFFDiAtLT4AgR4QOgCBVwcob3IgbnVsbCkKCm9wdCBpZgCBbwdub3QAEwUAgh0UADsRR2V0IHNpZ25pbmcga2V5XG5mcm9tIGNvbmZpZwCCXhRKV1QgTGlicmFyeTogZGVjb2RlSldUKACCawUsIGtleSkKABgLAIEjHGNsYWltcyBkYXRhAINHFACBZBFWYWxpZGF0ZSBleHAsXG5uYmYsIGF1ZABBBwAeJUNvbnZlcnQAdAdcbnRvIFVzZXIgbwCEOgUAYSVTZXQALQduIHRocmVhZFxub3IAhQAJAEMHZW5kCgphbACDEAVVc2VyCiAgIACFShMAhVsYUm9sZS1iYXNlZFxuYXNzZXIAhiQFAC4WLS0-QnJvd3NlcjogcgCGVwhyZXNwb25zZQplbHNlIGVsc2UAGyM0MDEALgtuZAo&#038;s=vs2010
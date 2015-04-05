---
---
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <channel>
        <title>{{ site.title | xml_escape }}</title>
        <description>{% if site.description %}{{ site.description | xml_escape }}{% endif %}</description>
        <link>{{ site.url }}</link>
        <atom:link href="{{ site.url }}/feed.xml" rel="self" type="application/rss+xml" />
        {% for post in site.posts limit:10 %}
        <item>
            <title>{{ post.title | xml_escape }}</title>
            {% if post.author.name %}
            <dc:creator>{{ post.author.name | xml_escape }}</dc:creator>
            {% endif %}
            <description>{{ post.content | strip_html | truncatewords: 100 | xml_escape}}</description>
            <content type="html">
                {{ post.content | xml_escape}}
            </content>
            <pubDate>{{ post.date | date: "%a, %d %b %Y %H:%M:%S %z" }}</pubDate>
            <link>{{ site.url }}{{ post.url }}</link>
            <guid isPermaLink="true">{{ site.url }}{{ post.url }}</guid>
            {% for category in post.categories %}
                <category>{{ category }}</category>
            {% endfor %}
        </item>
        {% endfor %}
    </channel>
</rss>
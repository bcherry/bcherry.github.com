---
title: JS Find-and-Replace with Split/Join
layout: post
tags: [javascript, performance]
permalink: /2009/11/JS-Find-and-Replace-with-SplitJoin
---

***Update: This advice is now totally out-of-date and wrong. Just use `replace`.  As [recent Browserscope results show](http://jsperf.com/test-join-and-split), all browsers have optimized `replace` to be much faster than `split`/`join`.  Thanks to Luigi van der Pal for pointing this out in the comments!***

When trying to do a find-and-replace in Javascript with static search and replace strings, it's always faster to use `String.split()` and `String.join()`` than to use `String.replace()`. Compare:

    var myString = '......some long text.....'; 
    mystring.replace(/,/g,"; "); // Replace the commas with semi-colon-space

with

    mystring.split(",").join("; "); // Replace the commas with semi-colon-space

The latter split/join method will always be faster. Note that this is only useful for static find-and-replace. For instance, you could not do anything like the following with splits and joins:

    mystring.replace(/^[0-9]+([A-Za-z]*)/g, "$1");

Of course, you could also use this method to strip characters out of a string:

    mystring.split(",").join('');

Good luck!

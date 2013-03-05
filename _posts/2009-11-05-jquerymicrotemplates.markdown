---
title: jQuery Micro-templates
layout: post
tags: [javascript, jquery]
feed_id: http://www.adequatelygood.com/2009/11/jQuery-Micro-templates
permalink: /jQuery-Micro-templates.html
alias: /2009/11/jQuery-Micro-templates/index.html
---

John Resig wrote a neat micro-templating Javascript function a [while back](http://ejohn.org/blog/javascript-micro-templating/). I've been playing with this, and have discovered two things:

1. These templates are totally nestable. Just make an element to be templated within a template, and call the sub-template code beneath the main call.
2. I found myself tending to do lines like `$("...").html(tmpl("...",{...}))`, which seemed clumsy. It was very easy to extend jQuery to include this templating engine (just add this underneath the existing code):

    jQuery.fn.tmpl = function(str,data){ return this.html(tmpl(str,data)); }

Then you can just do the following to templatize any number of elements:

    $(".myElems").tmpl("myTemplate",myDataObj);

I'm still playing with these templates, and working on a new project, so I hope to have more to write about it soon.

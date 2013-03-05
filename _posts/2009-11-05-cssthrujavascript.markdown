---
title: Managing CSS Through JavaScript
layout: post
tags: [javascript, css]
feed_id: http://www.adequatelygood.com/2009/11/Managing-CSS-Through-Javascript
permalink: /Managing-CSS-Through-Javascript.html
alias: /2009/11/Managing-CSS-Through-Javascript/index.html
---

It's often very difficult to keep track of what CSS goes where. Especially when you load up on Javascript controls and files in a large application, which render markup that depends on some CSS being there. One solution is to "inline" the CSS in the JavaScript, by adding style to each element as it's created. This works, but it's messy. Also, browsers are heavily optimized to apply CSS, faster than any Javascript solution could be. But when you've got a fancy script manager like LABjs, remembering to statically link all of the important CSS is a pain. Especially so if you're not sure at page load whether certain CSS will be needed. Here's a simple function to do this for you (note the XHR stuff is pretty basic, and I'd recommend changing it to use whatever JS library you use in your applications):

    (function() {
      var loadedFiles = {}; 
      this.$css = function(filename) { 
        if (loadedFiles[filename]) { 
          return; 
        } 
        loadedFiles[filename] = true; 
        var xhr = new XMLHttpRequest(); 
        xhr.open("GET", filename, true); 
        xhr.onreadystatechange = function() { 
          if (xhr.readyState === 4) { 
            var head = document.getElementsByTagName("head")[0]; 
            var styleTag = document.createElement("style"); 
            var style = document.createTextNode(xhr.responseText);
            styleTag.appendChild(style); 
            head.appendChild(styleTag);
          } 
        }; 
        xhr.send(null); 
      };
    })();

Now, from any Javascript, just do the following:

    $css("styles/main.css"); 
    $css("styles/controls.css");

The `$css()` function keeps track of what's already been loaded, so that you'll never load the same stylesheet twice. So don't be afraid to spell out each CSS dependency your Javascript files have.

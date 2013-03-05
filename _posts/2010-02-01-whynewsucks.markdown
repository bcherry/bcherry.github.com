---
title: Why JavaScript's "new" Keyword Sucks
layout: post
legacy_id: http://www.adequatelygood.com/2010/2/Why-JavaScripts-new-Keyword-Sucks
permalink: /Why-JavaScripts-new-Keyword-Sucks.html
alias: /2010/2/Why-JavaScripts-new-Keyword-Sucks/index.html
tags: [javascript]
---	

	>>> function F() { return function inner() { return "inner invoked"; }; }
	>>> F()
	inner()
	>>> F()()
	"inner invoked"
	>>> new F
	inner()
	>>> new F()
	inner()
	>>> (new F)
	inner()
	>>> (new F)()
	"inner invoked"
	>>> new (F())
	{ }
	>>> new ((F)())
	{ }
	>>> (new F())()
	"inner invoked"
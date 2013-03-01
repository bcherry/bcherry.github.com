---
title: Why JavaScript's "new" Keyword Sucks
layout: post
permalink: /2010/2/Why-JavaScripts-new-Keyword-Sucks
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
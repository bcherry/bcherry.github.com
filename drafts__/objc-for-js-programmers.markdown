---
title: Objective-C for JavaScript Programmers
layout: post
permalink: /Objective-C-for-JavaScript-Programmers.html
published: true
tags: [objective-c]
---


* Looping, if, etc
* Types
* Objects/Classes
 * properties
 * methods
 * inheritance
* Scope
* Blocks
* Delegates
* Selectors
* Notifications
* Timers
* GUI programming
* Functions
* ARC
* CF, low-level stuff

* Header files
* CocoaPods



As "mobile" development is becoming critical to most technology companies, many front-end engineers are finding themselves starting to learn about development for iOS and Android, and some are even beginning to do native mobile development full-time. This article serves as a detailed introduction to the Objective-C language and the iOS platform for developers who are already experienced with JavaScript. 

## What is Objective-C?

Objective-C is a **superset** of the C programming language, and serves as the fundamental language for Mac OS X and all of its relatives, including iOS. Most importantly, and unsurprisingly, it introduces an object-oriented programming model to C, along with many other nice modern language features. Objective-C has a daunting and verbose syntax, but is remarkably powerful and flexible, with some very clever features. There are a few warts of course, but as a JavaScript programmers we're all used to that sort of thing.

## Static Typing

One of the harder adjustments for JavaScript programmers moving to Objective-C is adjusting to **static typing**. Each variable, function argument, and return value must have it's type explicityldeclared by the programmer, and mixing-and-matching types is strictly disallowed.  This means that you can't simply declare a variable with `var` and worry about the type later. Luckily, the compiler helps you out and will let you know very loudly if you're breaking the rules.  So keep this in mind as you read on, as you'll see a lot of types being declared everywhere.

## Structure of an Objective-C Program

When you crack open an Objective-C project, you'll find two main sorts of files: **Header files** (`*.h`), and **Implementation files** (`*.m`). Each pair of files generally represents a single **class**. This pair of files is used to separate the **public interface** of a class from it's **private implementation**. JavaScript programs do not have the concept of privacy, although this will be familiar to developers who have used classical object-oriented languages such as Java or Ruby.

While most developers will organize their code into many folders, the Objective-C linker discards the folder structure when building the program.  This means that each file (including 3rd-party dependences) must have a unique name.  Most developers choose a prefix for their company, team, or project, and use that throughout their code to avoid naming collisions.  For this article, we'll use the prefix "AG".

## Classes and Objects

Objective-C implements a classical inheritance model. JavaScript implements a prototypal inheritance model, although many JavaScript programmers choose to use a classical model instead, through one of the many libraries available. CoffeeScript makes classical inheritance the standard, and includes a simple syntax inspired by Ruby. If you've done any of these before, you'll be familiar withe concept.

### The Header File

The header file contains the public interface for a class. All you'll find here is a class definition and **function prototypes**, which define the function name and arguments, but do not contain the implementation. Let's take a look:

    // AGHello.h
    
    @interface AGHello : NSObject
    
    @property (nonatomic, retain) NSString *name;
    
    - (void)sayHello;
    
    @end

The class definition runs between the `@interface` statement and the `@end` statement.  Anything included outside of those lines will not be part of this class definition.  In this case, we have a comment line beginning with `//`. Commenting in Objective-C is identical to JavaScript.

The first line, names the class and defines it's **subclass**, which is `NSObject` in this case. `NSObject` is the base class of all objects, so this is the default to use if you don't need to inherit anything in particular.

The second line is a property definition.  The property's name is `name`, and its type is `NSString *` (a string).  The bit between the parens is some boilerplate, we'll look at that in a bit more detail later on. For now, the `*` simply means "instance of".

The third line is a function prototype (method definition). Because it starts with `-`, we know that we're defining an **instance method**, which means that instances of this class will expose this method. In JavaScript, this is equivalent to placing a method on a constructor's prototype.  The method is named `sayHello` and takes no arguments. It has no return value, which we specify using the special term `void`.

### The Implementation

Now that we have a header, let's implement this class. Here's the implementation file:

    // AGHello.m
    
    #import "AGHello.h"
    
    @implementation AGHello
    
    - (void)sayHello
    {
      NSLog(@"Hello, %@", self.name);
    }
    
    - (void)dealloc
    {
      self.name = nil;
    }
    
    @end

In order to offer an implementation of `AGHello`, we must first know about it. To do that, we'll `#import` the file. This simply tells the compiler to include that file inside of this one. If we needed any external libraries, we'd `#import` them here as well.  Notice that the filename is listed without any directories. As I mentioned above, the compiler discards directory structures, so the filename must be unique within all files in the project.

Next, we begin the implementation with the unsurprising `@implementation AGHello`.  Our property (`name`) will be implemented automatically (that's what that whole `(nonatomic, retain)` part was about), so we just need to implement our `sayHello` method.

Once again, we include the full method signature so it's clear that we're implementing the same method that the header file declared.  Then we simply open a pair of brackets and include the method body.  In this case, our method is a simple call to `NSLog`, which is a built-in function roughly equivalent to JavaScript's `console.log`.  We pass two arguments: a string literal, and the value of our `name` property.  Within instance methods, we can always refer to the current instance as `self`, and access properties by name with dot-notation. The Objective-C string literal syntax is unfortunate, you'll have to remember to always prefix the string with `@`, or else you'll make a C-string, which behaves quite differently. `NSLog` accepts format strings, just like `console.log`. The format specified `%@` is equivalent to `%s` in `console.log`, it will just print the string value of the argument, which is `self.name` in this case.

Finally, we have to define the `dealloc` method. This method comes by default on all classes, and handles dellocation of the object. If you're using ARC (Automatic Reference Counting, a feature of iOS 5 and up), you'll simply need to assign each of your properties that was declared as `retain` (remember that property definition in the header) to `nil` (the `null` value for object types in Objective-C) to prevent memory leakage.

### Using Our Class

Now it's time to really accomplish something!  We'll make a new iOS application in [XCode](XCode), add in `AGHello`, and try running it.  If you want to play along: In XCode, just choose "New Project", and you can make an iOS "Single View Application" called "AGDemo" (using the prefix "AG"), leaving all the defaults selected.  Then, choose "New File", and add an "Objective-C class" called "AGHello" with the subclass "NSObject". Once you've got those files, just copy the contents of AGHello.h and AGHello.m that I defined above.

The starting point for all iOS applications is the **application delegate**. This is usually named (with your own prefix) `AGAppDelegate`. This file contains a bunch of stubbed out methods, but we'll focus on the first one for now, called `application:didFinishLaunchingWithOptions:`.  In "AGAppDelegate.m", we'll find this method and add a few lines to the body:

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        AGHello *hello = [[AGHello alloc] init];
        hello.name = @"Ben";
    
        [hello sayHello];
    
        return YES;
    }

We'll come back to the more complicated method signature on top in a bit, let's focus on the method body for now.

First, we declare a new variable, named `hello`, with the type `AGHello *` (which means it will hold an instance of our `AGHello` class).  Then, we initialize a new instance of `AGHello` and assign it.

Objective-C has a remarkable implementation of methods for objects. Most classical languages add regular functions to objects, but Objective-C uses a concept called **message passing** instead. This was inspired by Smalltalk, and is really a great feature once you get used to it.  The syntax for message passing is `[RECEIVER messageName]`.  So to initialize our `AGHello`, we actually nest messages.  First, we send the `alloc` message to the class itself, (`[AGHello alloc]`), which asks for an instance to be allocated in memory.  That message returns an instance, which we then send the message `init`, which tells it to initialize itself for use.  This is the simplest example of creating a new object instance in Objective-C. We'll cover messages in much more detail in just a bit.

Once we have our instance, we can assign our property to it. This is done simply with dot-notation. Notice again that we are using the special Objective-C string notation `@"Ben"`. This actually causes a new `NSString` object to be created. If you'll recall, we defined the `name` property to have the type `NSString *`, so it's important that we assign an instance of `NSString`.

Finally, we'll call our `sayHello` method. Once again, we pass a message to our instance with the square-bracket notation: `[hello sayHello]`.  The final line, `return YES;`, is just part of this method's original implementation, and we'll leave it alone.

If we run this program in the iOS Simulator ("Product" -> "Run"), we'll see "Hello, Ben" logged out into the debugger console.  Success!

## Methods and Messages

Methods in Objective-C come in two primary flavors, **instance** and **static**.  Instance methods (which we've already seen briefly) are available to each instance of the class (like methods in JavaScript's prototype chain).  Static methods are accessible directly on the class itself, just like methods attached to constructor functions in JavaScript.

To declare an instance method, prefix it with `-`. Static methods are prefixed with `+`.

    @interface AGFoo : NSObject
    
    + (void)aStaticMethod;

    - (void)anInstanceMethod;
    
    @end

It's important that you preserve the correct `+`/`-` prefix when implementing the method as well. Calling these methods is straightforward with the message-passing syntax we used earlier:

    [AGFoo aStaticMethod];
    [[[AGFoo alloc] init] anInstanceMethod];

### Return Values

Since Objective-C is statically-typed, you'll need to declare your **return type** (if any) when you declare the method.  Each method can return only one value, of only one type. This always goes in the parentheses just in front of the method name:

    - (NSString *)foo
    {
        return @"foo";
    }

If your method has no return value, just use `void` as the return type.  Once you've declared a return type, it's your job to stick to it.  If you break the your contract, the compiler will usually refuse to build your program.

### Arguments

Method arguments are a little different in Objective-C. Rather than being thrown into one long list, each one is spelled-out one-by-one in the method name itself.  For instance:

    - (void)sayHello:(NSString *)name
    {
        NSLog(@"Hello, %@", name);
    }

If you need more arguments:

    - (void)sayHelloTo:(NSString *)name1 and:(NSString *)name2
    {
        NSLog(@"Hello, %@ and %@", name1, name2);
    }

You'll notice that the `NSLog` function doesn't use this message-passing syntax. That's because `NSLog` is a normal function, just like what JavaScript has.  You'll deal with functions on occassion, but most of the time in Objective-C you'll be using methods and the message-passing syntax.

Calling these methods with arguments is straightforward:

    AGHello *hello = [[AGHello alloc] init];

    [hello sayHelloTo:@"Ben" and:@"Marcus"];

## Method Names

The formal name of the method is derived from the signature, by removing the `+`/`-`, the return type, and all of the argument types and names. So our second method above is named `sayHelloTo:and:`. Notice that we keep the colon character in place for each spot where an argument should be inserted (including at the end).

## Messages

Messages bring with them some nice properties. For instance, passing a message to `nil` is always ok, and always returns `nil`.  So the following code will run with no errors:

    AGHello *hello = nil;
    [hello sayHello];

This saves a lot of time that would otherwise be spent guarding against method invocations on a null object reference.

You can also get a typed reference to a method name using a **selector**:

    SEL sayHelloMethod = @selector(sayHello);

    AGHello *hello = [[AGHello alloc] init];
    [hello performSelector:sayHelloMethod];

Using the method `respondsToSelector:`, you can easily test objects in cases where you're operating outside the bounds of static typing and need to know about an object:

    [hello respondsToSelector:@selector(sayHello)]; // true

    [hello respondsToSelector:@selector(sayGoodby)]; // false

Usually, selectors will be used to establish callbacks for events in UI programming.

## Properties

Properties are a special type of method.  When you use the `@property` declaration in a class, you're actually telling it to define a getter and a setter method.  By default, these are named after the property with `get` or `set` prepended. The value is stored in a private **instance variable** that is the property name with an `_` in front.  In some cases you'll actually want to override the getter or setter, in which case you'll do this:

    @interface AGHello : NSObject
    
    @property (nonatomic, retain) NSString *name;
    
    @end
    
    @implementation AGHello
    
    - (void)setName:(NSString *)name
    {
        NSLog(@"Name was set");
        _name = name;
    }
    
    - (NSString *)getName
    {
        NSLog(@"Name was gotten");
        return _name;
    }
    
    @end

Any time you use dot-notation to retrieve or assign a property value, these methods will be called.  You can also call them directly with messages if you prefer: `[hello setName:@"Ben"]`.  Dot-notation is also `nil`-safe, just like message passing.

## Common Types

Objective-C contains quite a few built-in types that you'll use quite a bit.

### Numbers

Unlike JavaScript, which has only a single `Number` type, Objective-C contains a bunch of a numeric types for different situations. I'll cover the basics here.

The most common floating-point type is `double`, which is a double-precision floating-point number (64 bits).  This is what JavaScript uses for `Number`, and is pretty flexible.  There is also the lower-precision `float`, and a special type of `double` for CoreGraphics operations called `CGFloat`. Any number literal containing a decimal point is assumed to be a `double`.

For integers, you'll usually want `NSInteger` or `NSUInteger`. The latter is **unsigned**, which means that it can hold values twice as large, at the expense of being unable to hold negative values.  If you've used C or Java before, try to resist the urge to use `int` and `unsigned int` directly, and just stick to `NSInteger` and `NSUInteger`.  Any number integer literal is assumed to be an `NSInteger`.

Arithmetic on numbers is very similar to JavaScript.  All of the standard operators are there, including `++` and `+=`.  It's extremely important to remember that using the division operator, "`/`" on integer values will always result in integer division (`5 / 3 == 1`). You must cast your integers to floating-point values if you want floating-point division: (`(double)5 / (double)3 == 1.6666666666666667`).

#### Booleans

Boolean values are just a special case of integers in Objective-C.  Their type is `BOOL` and the values are `YES` and `NO`.

#### NSNumber

The final number type is a bit different. It's known as `NSNumber` and is actually an object type. It can hold any of the primitive number types, but exists as a proper object.  You'll use `NSNumber` in container classes, which can only contain objects. Moving values in and out of `NSNumber` is easy with the helper methods.

    NSInteger i = 1;
    NSNumber *n = [NSNumber numberWithInteger:i];
    i == [n integerValue]; // true

You can also define `NSNumber` values with a literal syntax:

    NSNumber *n = @1;
    NSNumber *m = @1.0;

Be careful! Since `NSNumber` is an object, it is always truthy, even when holding a false value:

    if (@NO) {
        // This will be executed!
    }

Make sure you pull out the `boolValue` if you need to do a truthiness check.   

### Strings

The primary string class in Objective-C is `NSString *`. As we've already seen, you can define them using a literal syntax:

    NSString *s = @"Hello, world";

Common string operations are available as static and instance methods:

    // Concatenation
    NSString *s = [@"foo" stringByAppendingString:@"bar"];

    // Case conversion
    NSString *s = [@"foo" uppercaseString];

`NSString` also support format strings:

    NSString *s = [NSString stringWithFormat:@"Hello, %@, user #%d", @"Ben", 53];

Be sure to explore the [documentation][NSString]. 

### Arrays

Objective-C contains a modern array implementation called `NSArray`. Arrays are a **container object**, which means they hold other objects.  Container objects in Objective-C can only hold other objects of any type (but no primitive values), and cannot hold `nil` values.

Defining an accessing an array is easy with the literal syntax:

    NSArray *a = @[@1, @"foo", @YES];
    NSLog(a[1]); // "foo"

Because arrays are objects, accessing elements is nil-safe:

   ((NSArray *)nil)[1]; // no problem, just returns nil

Just like `NSString`, the `NSArray` class contains many helpful methods for filtering, sorting, joining, and many other operations.

The `NSArray` class is immutable. If you wish to have a mutable array, you should use `NSMutableArray`.  This will allow you to add, remove, and change values.  Note that the type returned by the `@[]` literal is an `NSArray`, so you'll need to convert it.  You can convert an `NSArray` to an `NSMutableArray` with the `mutableCopy` method: `[@[] mutableCopy]`.

The `for-in` "fast enumeration" statement can be used to iterate over an `NSArray`:

    for (NSNumber *n in @[@1, @2, @3]) {
        // do something with n
    }

If you don't know the type of the values in the array (or they have many types), use the generic object type `id`:

    for (id val in someArray) {
        // ...
    }

### Dictionaries

We also have a basic dictionary type, `NSDictionary` (and its mutable cousin, `NSMutableDictionary`):

    NSDictionary *d = @{ @"foo": @"bar" };

Just like with `NSArray`, none of the keys nor the values may be `nil`, and the must all be objects. The keys need not be strings, they can be any object.  You can access values with square brackets: `d[@"foo"]`.  Using a `for-in` loop on an `NSDictionary` will enumerate the keys of the dicitonary.

### Null Values

Finally, we come to null values. Objective-C has three: `NULL`, `nil`, and `[NSNull null]`.

`NULL` is a primitive value that can be used with any primitive numeric type.  `NULL` is falsy when used in an `if` statement.

`nil` is used for object types. It has the type `id`, which is the generic object type.  `nil` cannot be placed in a container, but can be the receiver of any message. `nil` is also falsy.

`[NSNull null]` is a singleton instance of `NSNull`, and it is for use in containers. If you need to put a null value into an `NSArray`, use `[NSNull null]`. `[NSNull null]`, as an object, is truthy when used in an `if` statement, so be careful.





[XCode]: https://developer.apple.com/xcode
[NSString]: http://example.com
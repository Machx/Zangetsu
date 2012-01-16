# Zangetsu Framework #

Zangetsu is a general purpose 64 bit ARC enabled Framework for Mac OS X 10.7 and as a static library for iOS 5. It has a number of convenience functions and Foundation categories that help in the development of Mac OS X Cocoa & iOS Cocoa Touch applications. It is the framework that helps power many of my apps. Going forward as I can more and more non application specific code from my apps will be added to this Framework. This framework is made available under the nonviral Open Source MIT License. Although it is not required, if you do use this I'd love it if you let me know what apps you use this in. Thanks!

Note: As a library for iOS 5 this project is still in the early stages of development right now. It is stable on Mac OS X, but is undergoing work to port code from Mac OS X to iOS.

## What's in Zangetsu? ##

Zangetsu contains

* Macros to make creating NSDictionaries, NSArrays, etc easy, check for nil IBOutlets, asserts with stack trace,etc...

* Objective-C Associated Objects

* Easy debug logging

* SHA1 & MD5 Convenience APIs

* Base64 & ZLib encoding & decoding

* Objective-C Data Structures like Stacks,Trees,Queues,etc.

* CWTask a wrapper around NSTask that makes it easy to configure & launch NSTasks...

* Host Version Info Convenience APIs

* Additional methods for NSArray, NSDictionary, NSSet & NSString to make using & enumerating over them easier.

* Networking classes like CWURLRequest to handle authentication/redirects/etc...

* Asynchronous & Synchronous NSURLConnection download APIs

* And much more...

## What does Zangetsu mean? ##

Zangetsu ( 斬月 ) is Japanese and means Slaying Moon. The inspiration for the name for this project comes from the Japanese Anime Bleach. Specifically a character called Ichigo Kurosaki and his zanpakutō ( 斬魄刀 literally "soul-cutter sword" ). It is a sword that takes many shapes. In the same way I intend this framework to do the same.

## Where is the Documentation ##
There is Doxygen support in the framework. All you need to do is download Doxygen and generate the documentation from the Doxyfile

## Where do I report bugs? ##
File issues in the issue section on the github project.

## Zangetsu Licence ##
Zangetsu is licensed under the MIT license

	Copyright (c) 2011 Colin Wheeler

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
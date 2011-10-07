# Zangetsu Framework #

Zangetsu is a general purpose 64 bit ARC enabled Framework for Mac OS X 10.7 and later with preserved snapshots available for those who need 10.6 Snow Leopard support in the downloads. It has a number of convenience functions and Foundation categories that help in the development of Mac OS X Cocoa applications. It is the framework that helps power many of my apps. Going forward as I can more and more non application specific code from my apps will be added to this Framework. This framework is made available under the nonviral Open Source MIT License. Although it is not required, if you do use this I'd love it if you let me know what apps you use this in. Thanks!

## What's in Zangetsu? ##

Zangetsu contains

* Macros to make creating NSDictionaries, NSArrays, etc easy

* Objective-C Associated Objects

* Easy debug logging

* SHA1 & MD5 Convenience APIs

* Base64 encoding/decoding

* Objective-C Data Structures like Stacks,Trees,etc.

* NSTask Conveience APIs

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

## GC Support ##

There is no more Garbage Collection Support. If you need GC Support you can fork this repo and revert it back to commit 4e211f890b777ac6d551f29a1f918331fb168fb9 or download [the Garbage Collection Snapshot](https://github.com/downloads/Machx/Zangetsu/Zangetsu-GCSnapshot.zip).

## I need to use Zangetsu on 10.6 Snow Leopard ##
Download the [Zangetsu 10.6 SDK Snapshot](https://github.com/downloads/Machx/Zangetsu/Machx-Zangetsu-10_6.zip) and feel free to use it within the terms of the MIT License. Alternatively you may fork the project and revert it to the last commit before settings where updated for 10.7 which is commit 4c1feb41487720d4ae8101796d5cc8f88b542668 on the master branch.

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
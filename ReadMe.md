# Zangetsu Framework #

Zangetsu is a general purpose 64 bit ARC enabled Framework for Mac OS X 10.7 and as a static library for iOS 5. It has a number of convenience functions and Foundation categories that help in the development of Mac OS X Cocoa & iOS Cocoa Touch applications. It is the framework that helps power many of my apps. Going forward as I can more and more non application specific code from my apps will be added to this Framework. This framework is made available under the nonviral Open Source MIT License. Although it is not required, if you do use this I'd love it if you let me know what apps you use this in. Thanks!

Note: As a library for iOS 5 this project is still in the early stages of development right now. It is stable on Mac OS X, but is undergoing work to port code from Mac OS X to iOS.

This project uses submodules so once you have checked it out you will need to update it with `git submodule update -i --recursive`.

## What's in Zangetsu? ##

Zangetsu contains

* Macros to make creating NSDictionaries, NSArrays, etc easy, check for nil IBOutlets, asserts with stack trace,etc...

* Objective-C Associated Objects

* Easy debug logging

* SHA1 & MD5 Convenience APIs

* Base64 & ZLib encoding & decoding

* Objective-C Data Structures like Stacks,Trees,Queues,Tries,etc.

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
Zangetsu is licensed under the BSD license.

```
Copyright (c) 2013, Colin Wheeler
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 - Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

 - Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
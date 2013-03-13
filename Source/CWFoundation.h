/*
//  CWFoundation.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/16/10.
//  Copyright 2010. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
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
 */
 
#import <Foundation/Foundation.h>

/**
 Determines if an Objective-C Class exists in the Objective-C Runtime
 
 Until true weak linking classes comes to the Mac OS X & iOS SDKs
 this will be necessary to determine if a class exists or not. Internally
 this uses NSClassFromString() if a Class object is returned the class 
 does exist in the runtime, otherwise it doesn't.
 
 @param class a NSString with the name of an Objective-C Class
 @return a BOOL with YES if the class exists or no if it doesn't
 */
BOOL CWClassExists(NSString * class);

/**
 Returns a unique NSString prepended by the passed in string
 
 @param preString the string to be prepended on the unique string
 @return NSString with a UUID String prepended with the prestring argument
 */
NSString *CWUUIDStringPrependedWithString(NSString *preString);

/**
 Returns a unique c string prepended by the passed in string
 
 @param preString the string to be prepended on the unique string
 @return C String with a UUID String prepended with the prestring argument
 */
const char *CWUUIDCStringPrependedWithString(NSString *preString);

/**
 Schedules the block to be executed on the next run loop on the main thread
 
 @param block the block to be executed on the next runloop on the main thread
 */
void CWNextRunLoop(dispatch_block_t block);

/**
 Inspired by println in Go, Prints all the variables, space seperated,to NSLog()
 
 @args all the variables you want printed to NSLog()
 */
void CWPrintLine(NSArray *args);

/**
 Inspired by println in Go, Prints all the variable, space separated, to printf
 
 @args all the variables you want printed to printf()
 */
void CWPrintfLine(NSArray *args);

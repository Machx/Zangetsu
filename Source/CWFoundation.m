/*
//  CWFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/16/10.
//  Copyright 2010. All rights reserved.
//

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
*/

#import "CWFoundation.h"

/**
 Determines if an Objective-C Class exists in the Objective-C Runtime
 
 Until true weak linking classes comes to the Mac OS X & iOS SDKs
 this will be necessary to determine if a class exists or not. Internally
 this uses NSClassFromString() if a Class object is returned the class 
 does exist in the runtime, otherwise it doesn't.
 
 @param class a NSString with the name of an Objective-C Class
 @return a BOOL with YES if the class exists or no if it doesn't
 */
BOOL CWClassExists(NSString * class)
{
	Class _class = NSClassFromString(class);
	return (_class) ? YES : NO;
}

/**
 Returns a NSString value of 'YES' or 'NO' corresponding to the bool value passed in
 
 @param value a BOOL value of YES or NO
 @return a NSString value of @"YES" if YES was passed in or @"NO" if NO was passed in
 */
NSString *CWBOOLString(BOOL value)
{
    return (value) ? @"YES" : @"NO";
}

/**
 Returns a unique NSString prepended by the passed in string
 
 @param preString the string to be prepended on the unique string
 @return a string containing the preString argument prepended onto a unique string value
 */
NSString *CWUUIDStringPrependedWithString(NSString *preString)
{
	NSString *unqiueString = [NSString stringWithFormat:@"%@%@",preString,[NSString cw_uuidString]];
	return unqiueString;
}

/**
 Returns a unique c string prepended by the passed in string
 
 @param preString the string to be prepended on the unique string
 @return a string containing the preString argument prepended onto a unique string value
 */
const char *CWUUIDCStringPrependedWithString(NSString *preString)
{
	return [CWUUIDStringPrependedWithString(preString) UTF8String];
}

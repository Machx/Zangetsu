/*
//  NSColor+CWNSColorAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/29/12.
//  Copyright (c) 2012. All rights reserved.
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
 
#import <AppKit/AppKit.h>

@interface NSColor (CWNSColorAdditions)
/**
 Converts a NSColor to its equivalent CGColorRef
 
 Given a valid NSColor object, this method takes that NSColor object and creates
 an equivalent CGColorRef object from it. This method returns an owned 
 CGColorRef object which you must free when you are done with it.
 
 @return a CGColorRef object equivalent to the receiving NSColor object
 */
-(CGColorRef)cw_CGColor CF_RETURNS_RETAINED;
@end

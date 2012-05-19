/*
//  NSStringAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/5/10.
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

#import <Foundation/Foundation.h>

@interface NSString (CWNSStringAdditions) 
/**
 Convenience method for Core Foundations CFUUIDCreate() function
 */
+ (NSString *)cw_uuidString;
/**
 Asynchronous & Synchronous string enumeration 
 this method was created for being able to enumerate over all the lines
 in a string asychronously, but make the whole operation of enumerating 
 over all the lines, synchronous
 */
- (void)cw_enumerateConcurrentlyWithOptions:(NSStringEnumerationOptions)options
                                 usingBlock:(void (^)(NSString *substring))block;
/**
 Escapes entities that would need to be escaped in urls
 */
- (NSString *) cw_escapeEntitiesForURL;
/**
 Quick test for an empty string
 */
- (BOOL) cw_isNotEmptyString;
@end

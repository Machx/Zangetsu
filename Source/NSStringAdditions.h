/*
//  NSStringAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/5/10.
//  Copyright 2010. All rights reserved.
//
 
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
 */

#import <Foundation/Foundation.h>

@interface NSString (CWNSStringAdditions) 
/**
 Returns a UUID String
 
 On OS X 10.8 and later this method calls the new [[NSUUID UUID] UUIDString]
 function. For 10.7 compatibility this method calls CFUUIDCreateString() if the
 NSUUID class doesn't exist.
 
 @return a new UUID NSString instance
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

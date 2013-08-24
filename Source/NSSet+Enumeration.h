/*
//  NSSet+Enumeration.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/24/13.
//
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

@interface NSSet (Zangetsu_NSSet_Enumeration)

/**
 Ruby Inspired method for enumerating over Objects in a set
 
 This method is really a wrapper for NSArrays -enumerateObjectsUsingBlock
 now and makes the code a little more conscice. It enumerates over all the
 objects in the set or until the bool pointer is set to YES.
 
 @param block a block taking a id and BOOL pointer arguments
 */
-(void)cw_each:(void (^)(id obj, BOOL *stop))block;

/**
 Enumerates over all the objects in a set or stop is set to YES
 
 This method then concurrently enumerates all objects or until  the stop pointer
 is set to yes and waits until all blocks have finished executing before
 exiting. This is equivalent to calling enumerateObjectsWithOptions:usingBlock:
 passing in NSEnumerationConcurrent for the option.
 
 @param block a Block taking a id and BOOL* arguments
 */
-(void)cw_eachConcurrentlyWithBlock:(void (^)(id obj,BOOL *stop))block;

@end

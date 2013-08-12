/*
//  NSArray+Enumeration.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/12/13.
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

@interface NSArray (Zangetsu_Enumeration)

/**
 Iterates over all the objects in an array and calls the block on each object
 
 This iterates over all the objects in an array calling the block on each object
 until it reaches the end of the array or until the BOOL *stop pointer is set to
 YES. This method was inspired by Ruby's each method and works very similarly to
 it, while at the same time staying close to existing ObjC standards for block
 arguments which is why it passes a BOOL *stop pointer allowing you to signal
 for enumeration to end.
 
 Important! If block is nil then this method will throw an exception.
 
 @param obj this is the object in the array currently being enumerated over
 @param index this is the index of obj in the array
 @param stop set this to YES to stop enumeration
 */
-(void) cw_each:(void (^)(id object, NSUInteger index, BOOL *stop))block;

/**
 Enumerates over the receiving arrays objects concurrently
 
 Enumerates over all the objects in the receiving array concurrently. That is it
 will go over each object and execute a block passing that object in the array
 as a parameter in the block. This methods asynchronously executes a block for
 all objects in the array but waits for all blocks to finish executing before
 going on.
 
 Important! If block is nil then this method will throw an exception.
 
 @param index the position of the object in the array
 @param obj the object being enumerated over
 @param stop if you need to stop the enumeration set this to YES
 */
- (void) cw_eachConcurrentlyWithBlock:(void (^)(id object, NSUInteger index, BOOL * stop))block;

@end

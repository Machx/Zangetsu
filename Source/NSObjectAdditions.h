/*
//  CWNSObjectAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
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

@interface   NSObject (CWNSObjectAdditions)

//Block Timing Methods -

/**
 Executes the passed in block after a specified time delay
 
 @param delay time to delay executing block after
 @param block to be executed after the time delay
 */
-(void)cw_performAfterDelay:(NSTimeInterval)delay
				  withBlock:(dispatch_block_t)block;

//Queueing  Methods -

/**
 Performs selector with obj as an argument on queue using NSInvocationOperation
 
 This method creates a NSInvocationOperationw with itself as the target and
 using the select/obj arguments on a specified NSOperationQueue.
 
 @param selector the selector to be performed
 @param obj an optional object arguemnt for selector
 @param queue the NSOperationQueue to invoke a NSInvocationOperation on
 */
-(void)cw_performSelector:(SEL)selector
			   withObject:(id)obj
				  onQueue:(NSOperationQueue *)queue;

/**
 This method calls dispatch_async() using queue and then invokes selector
 
 If any of the arguments are nil/NULL then the method will throw an assertion.
 
 @param selector the selector to be performed on queue. Cannot be NULL.
 @param obj an optional object argument. Cannot be nil.
 @param queue the queue to be used for the dispatch_async() call.Cannot be NULL.
 */
-(void)cw_performSelector:(SEL)selector
			   withObject:(id)obj
			   onGCDQueue:(dispatch_queue_t)queue;

/**
 Calls -performSelector but directs clang to ignore a potential leak
 
 This tells clang to ignore a potential leak when calling -performSelector
 just for the duration of this one call.
 
 @param selector the selector to be called
 @return id the object returned from NSObject -performSelector: method
 */
-(id)cw_ARCPerformSelector:(SEL)selector;

/**
 Returns YES on any non nil object, nil objects will return NO
 
 @return a BOOL with YES if the object is non nil, otherwise NO if nil
 */
-(BOOL)cw_isNotNil;

@end

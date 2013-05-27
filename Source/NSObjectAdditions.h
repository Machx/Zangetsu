/*
//  CWNSObjectAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
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

@interface   NSObject (CWNSObjectAdditions)

#pragma mark Objective-C Associated Objects -

/**
 Returns the value associated with a key
 
 @param key that was used to associate an object with the receiver
 @return the value associated with the given key
 */
-(id)cw_valueAssociatedWithKey:(void *)key;

/**
 Associates the value with a key using a strong reference
 
 @param value the object to be associated with the receiver
 @param key to be used to lookup value later
 */
-(void)cw_associateValue:(id)value
				  atomic:(BOOL)atomic
				 withKey:(void *)key;

/**
 Associates the value with a key using a weak reference
 
 @param value the object to be associated with the receiver
 @param key to be used to lookup value later
 */
-(void)cw_associateWeakValue:(id)value
					 withKey:(void *)key;

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
 
 @param selector the selector to be performed on queue
 @param obj an optional object argument
 @param queue the queue to be used for the dispatch_async() call
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

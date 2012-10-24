/*
//  CWNSObjectAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 12/15/10.
//  Copyright 2010. All rights reserved.
//
 
 */

#import <Foundation/Foundation.h>

@interface   NSObject (CWNSObjectAdditions)

// Objective-C Associated Objects

/**
 returns the value associated with a key
 */
-(id)cw_valueAssociatedWithKey:(void *)key;

/**
 Associates the value with a key using a strong reference
 */
-(void)cw_associateValue:(id)value withKey:(void *)key;

/**
 Associates the value with a key using a weak reference
 */
-(void)cw_associateWeakValue:(id)value withKey:(void *)key;

// Block Timing Methods

/**
 Executes the passed in block after a specified delay time
 */
-(void)cw_performAfterDelay:(NSTimeInterval)delay withBlock:(void (^)())block;

// Queueing  Methods

/**
 Creates a NSInvocation operation with self as the target and the passed in selector and
 adds the operation to the passed in NSOperationQueue.
 */
-(void)cw_performSelector:(SEL)selector withObject:(id)obj onQueue:(NSOperationQueue *)queue;

/**
 Creates a NSInvocation operation with the receiver as the target and the passed in selector and
 adds the operation to the passed in dispatch_queue_t.
 */
-(void)cw_performSelector:(SEL)selector withObject:(id)obj onGCDQueue:(dispatch_queue_t)queue;

/**
 Calls -performSelector but directs clang to ignore a potential leak
 
 This tells clang to ignore a potential leak when calling -performSelector
 just for the duration of this one call.
 
 @param selector the selector to be called
 @return id the object returned from NSObject -performSelector: method
 */
-(id)cw_ARCPerformSelector:(SEL)selector;

-(BOOL)cw_isNotNil;

@end

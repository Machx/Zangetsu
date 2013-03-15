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

#pragma mark Objective-C Associated Objects -

/**
<<<<<<< HEAD
 returns the value associated with a key	*/
-(id)cw_valueAssociatedWithKey:(void *)key;

/**
 Associates the value with a key using a strong reference	*/
-(void)cw_associateValue:(id)value withKey:(void *)key;

/**
 Associates the value with a key using a weak reference	*/
-(void)cw_associateWeakValue:(id)value withKey:(void *)key;
=======
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
				 withKey:(void *)key;

/**
 Associates the value with a key using a weak reference
 
 @param value the object to be associated with the receiver
 @param key to be used to lookup value later
 */
-(void)cw_associateWeakValue:(id)value
					 withKey:(void *)key;
>>>>>>> upstream/master

//Block Timing Methods -

/**
<<<<<<< HEAD
 Executes the passed in block after a specified delay time	*/
-(void)cw_performAfterDelay:(NSTimeInterval)delay withBlock:(void (^)())block;
=======
 Executes the passed in block after a specified time delay
 
 @param delay time to delay executing block after
 @param block to be executed after the time delay
 */
-(void)cw_performAfterDelay:(NSTimeInterval)delay
				  withBlock:(dispatch_block_t)block;
>>>>>>> upstream/master

//Queueing  Methods -

/**
<<<<<<< HEAD
 Creates a NSInvocation operation with self as the target and the passed in selector and
 adds the operation to the passed in NSOperationQueue.	*/
-(void)cw_performSelector:(SEL)selector withObject:(id)obj onQueue:(NSOperationQueue *)queue;

/**
 Creates a NSInvocation operation with the receiver as the target and the passed in selector and
 adds the operation to the passed in dispatch_queue_t.	*/
-(void)cw_performSelector:(SEL)selector withObject:(id)obj onGCDQueue:(dispatch_queue_t)queue;
=======
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
>>>>>>> upstream/master

/**
 Calls -performSelector but directs clang to ignore a potential leak
 
 This tells clang to ignore a potential leak when calling -performSelector
 just for the duration of this one call.
 
 @param selector the selector to be called
 @return id the object returned from NSObject -performSelector: method	*/
-(id)cw_ARCPerformSelector:(SEL)selector;

/**
 Returns YES on any non nil object, nil objects will return NO
 
 @return a BOOL with YES if the object is non nil, otherwise NO if nil
 */
-(BOOL)cw_isNotNil;

@end

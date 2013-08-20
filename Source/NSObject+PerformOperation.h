//
//  NSObject+PerformOperation.h
//  Zangetsu
//
//  Created by Colin Wheeler on 8/20/13.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (Zangetsu_NSObject_PerformOperation)

/**
 Executes the passed in block after a specified time delay
 
 @param delay time to delay executing block after
 @param block to be executed after the time delay
 */
-(void)cw_performAfterDelay:(NSTimeInterval)delay
				  withBlock:(dispatch_block_t)block;

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

@end

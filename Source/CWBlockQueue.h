/*
//  CWBlockQueue.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
//  Copyright (c) 2012. All rights reserved.
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

/**
 CWBlockQueue is a lightweight alternative to NSOperationQueue
 Its job is to manage a GCD Queue (dispatch_queue_t) & make it easy to
 do things you wanted to do with NSOperationQueue like set target queues,
 set operations with completion blocks, barrier blocks, etc. Unlike 
 NSOperation(Queue) CWBlockQueue has been designed from the beginning for
 asynchronous operations, you can do some synchronous operations, but
 the bulk of the class has been designed with asynchronous operations in mind.
 This means the queue is not concerned with the state of operations, which is 
 why CWBlockOperation has no -isExecuting -isFinished, etc.
 */

#import <Foundation/Foundation.h>

static NSString * const kCWBlockQueueNoQueueLabel = @"No Queue Present";
static NSString * const kCWBlockQueueGenericGCDQueueLabel = @"GCD Queue";

@interface CWBlockOperation : NSObject

/**
 Returns a new CWBlockOperation object
 
 Creates a new CWBlockOperation object. The Block itself must not be nil,
 otherwise this method will throw an assertion and abort.
 
 @param block the block to be used with the operation object. Must not be nil.
 @return a CWBlocKOperation instance
 */
+(instancetype)operationWithBlock:(dispatch_block_t)block;

@end

typedef enum : NSUInteger {
	kCWBlockQueueTargetPrivateQueue = 0,      //private GCD Queue
	kCWBlockQueueTargetMainQueue = 1,         //GCD Main Queue
	kCWBlockQueueTargetGCDLowPriority = 2,    //GCD Low Global Priority Queue
	kCWBlockQueueTargetGCDNormalPriority = 3, //GCD Normal Global Priority queue
	kCWBlockQueueTargetGCDHighPriority = 4    //GCD High Global Priority queue
} CWBlockQueueTargetType;

@interface CWBlockQueue : NSObject

/**
 Returns a global CWBlockQueue object initialized to point at the GCD Main Queue
 
 @return mainQueue a CWBlockQueue object using the GCD Main Queue
 */
+(instancetype)mainQueue;

/**
 Returns a global CWBlockQueue object initialized to point at the GCD Default
 Priority Queue
 
 @return globalDefaultQueue a CWBlock queue object initialized and using the GCD
 Default Priority Queue
 */
+(instancetype)globalDefaultQueue;

/**
 Creates a Temporary Queue that you can use to throw a block on for execution in
 the background
 
 This creates a temporary dispatch_queue_t and then asynchronously executes the
 block and when the block has completed executing the queue is immediately 
 released. The temporary queue has a unique label like 
 'com.Zangetsu.CWBlockQueue_TemporaryQueue_1A5F...' etc. If the block being 
 dispatched is nil this will catch an assertion and call abort().
 
 @param block the block to be executed on a temporary queue. Cannot be nil.
 */
+(void)executeBlockOnTemporaryQueue:(dispatch_block_t)block;

/**
 Initializes a CWBlockQueue object with a queue type and label as applicable
 
 @param type the Queue type to use for dispatching blocks on
 @param concurrent a BOOL set to YES for concurrent queue or NO for serial
 @param label if a private queue is used this labels the queue with your label
 
 @return an initialed CWBlockQueue
 */
-(instancetype)initWithQueueType:(CWBlockQueueTargetType)type
					  concurrent:(BOOL)concurrent
						   label:(NSString *)qLabel;

/**
 Initialzes a CWBlockQueue object with a specified gcd queue
 
 @param a dispatch_queue_t queue that CWBlockQueue should manage
 @return an initialized CWBlockQueue object
 */
-(instancetype)initWithGCDQueue:(dispatch_queue_t)gcdQueue;

/**
 The internal queue that CWBlockQueue dispatches to
 
 @return the dispatch_queue_t the queue uses
 */
@property(readonly,assign) dispatch_queue_t queue;

/**
 The internal queues label
 
 This returns the internal queus label and will be one of several values. If the
 queue is non-existant (nil) then this returns "No Queue Present." Otherwise 
 the result from dispatch_queue_get_label() is returned, except if the result
 returned is NULL, in which case "GCD Queue" is returned.
 
 @return the label for the queue used to make it distinct
 */
@property(readonly,retain) NSString *label;

/**
 Sets the CWBlockQueues gcd queue to target another gcd queue.
 
 @param blockQueue the queue to target, if nil this does nothing
 */
-(void)setTargetCWBlockQueue:(CWBlockQueue *)blockQueue;

/**
 Sets the CWBlockQueues gcd queue to target another gcd queue.
 
 @param GCDQueue to be targeted by this queue, if NULL this does nothing
 */
-(void)setTargetGCDQueue:(dispatch_queue_t)GCDQueue;

/**
 Adds an operation object & asynchronously executes it
 
 The operations operation block is executed first then the completion block
 
 @param operation a CWBlockOperation object
 */
-(void)addOperation:(CWBlockOperation *)operation;

/**
 Asnchronously executes a block on the gcd queue
 
 @param block a dispatch_block_t type to be executed on the queue
 */
-(void)addoperationWithBlock:(dispatch_block_t)block;

/**
 Synchronously executes a CWBlockOperation object
 
 The operations operation block is executed first then the completion block
 
 @param operation a CWBlockOperation object to be executed Synchronously
 */
-(void)addSynchronousOperation:(CWBlockOperation *)operation;

/**
 Synchronously executes a block on the gcd queue
 
 @param block a dispatch_block_t to be executed Synchronously
 */
-(void)addSynchronousOperationWithBlock:(dispatch_block_t)block;

/**
 Asynchronous operation that waits for the queue to finish & then executes block
 
 @param block the dispatch_block_t to be executed when all others have finished
 */
-(void)executeWhenQueueIsFinished:(dispatch_block_t)block;

/**
 Waits for the queue to finish executing all previously queued blocks
 */
-(void)waitUntilAllBlocksHaveProcessed;

/**
 Suspends the execution of further blocks on the queue
 */
-(void)suspend;

/**
 Resumes the execution of blocks on the queue
 */
-(void)resume;

@end

/*
//  CWBlockQueue.h
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
//  Copyright (c) 2012. All rights reserved.
//
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
 why CWBlockOperation has no -isExecuting -isFinished, etc.	*/

#import <Foundation/Foundation.h>

@interface CWBlockOperation : NSObject
/**
 Returns a new CWBlockOperation object
 
<<<<<<< HEAD
 @param block the block to be used with the operation object. This must not be nil.
 @return a CWBlocKOperation instance	*/
=======
 @param block the block to be used with the operation object. Must not be nil.
 @return a CWBlocKOperation instance
 */
>>>>>>> upstream/master
+(CWBlockOperation *)operationWithBlock:(dispatch_block_t)block;

/**
 a Block executed once the main block of the operation has finished executing	*/
@property(copy) dispatch_block_t completionBlock;
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
<<<<<<< HEAD
 Returns a global CWBlockQueue object initialized to point at the GCD Main Queue	*/
+(CWBlockQueue *)mainQueue;

/**
 Returns a global CWBlockQueue object initialized to point at the GCD Default Priority Queue	*/
=======
 Returns a global CWBlockQueue object initialized to point at the GCD Main Queue
 
 @return mainQueue a CWBlockQueue object using the GCD Main Queue
 */
+(CWBlockQueue *)mainQueue;

/**
 Returns a global CWBlockQueue object initialized to point at the GCD Default
 Priority Queue
 
 @return globalDefaultQueue a CWBlock queue object initialized and using the GCD
 Default Priority Queue
 */
>>>>>>> upstream/master
+(CWBlockQueue *)globalDefaultQueue;

/**
 Creates a Temporary Queue that you can use to throw a block on for execution in
 the background
 
 This creates a temporary dispatch_queue_t and then asynchronously executes the
 block and when the block has completed executing the queue is immediately 
 released. The temporary queue has a unique label like 
 'com.Zangetsu.CWBlockQueue_TemporaryQueue_1A5F...' etc.
 
<<<<<<< HEAD
 This creates a temporary dispatch_queue_t and then asynchronously executes the block and when 
 the block has completed executing the queue is immediately released. The temporary queue has a 
 unique label like 'com.Zangetsu.CWBlockQueue_TemporaryQueue_1A5F...' etc. 	*/
=======
 @param block the block to be executed on a temporary queue
 */
>>>>>>> upstream/master
+(void)executeBlockOnTemporaryQueue:(dispatch_block_t)block;

/**
 Initializes a CWBlockQueue object with a queue type and label as applicable
 
<<<<<<< HEAD
 @param type a NSInteger with the type of the queue to be used as defined in the header
 @param concurrent a BOOL thats used if the private queue type is specified to mark the private queue as serial or concurrent
 @param label a NSString thats used for the queue label if a private queue type is specified	*/
-(id)initWithQueueType:(CWBlockQueueTargetType)type concurrent:(BOOL)concurrent label:(NSString *)qLabel;
=======
 @param type the Queue type to use for dispatching blocks on
 @param concurrent a BOOL set to YES for concurrent queue or NO for serial
 @param label if a private queue is used this labels the queue with your label
 
 @return an initialed CWBlockQueue
 */
-(id)initWithQueueType:(CWBlockQueueTargetType)type
			concurrent:(BOOL)concurrent
				 label:(NSString *)qLabel;
>>>>>>> upstream/master

/**
 Initialzes a CWBlockQueue object with a specified gcd queue
 
 @param a dispatch_queue_t queue that CWBlockQueue should manage
 @return an initialized CWBlockQueue object	*/
-(id)initWithGCDQueue:(dispatch_queue_t)gcdQueue;

/**
 The internal queue that CWBlockQueue dispatches to	*/
@property(readonly,assign) dispatch_queue_t queue;

/**
 A NSString with the label you have given to the queue if initialized with one,
 otherwise it contains a automatically generated one.	*/
@property(readonly,retain) NSString *label;

/**
 Sets the CWBlockQueues gcd queue to target another gcd queue.
 
<<<<<<< HEAD
 If nil is passed in this method does nothing.	*/
=======
 @param blockQueue the queue to target, if nil this does nothing
 */
>>>>>>> upstream/master
-(void)setTargetCWBlockQueue:(CWBlockQueue *)blockQueue;

/**
 Sets the CWBlockQueues gcd queue to target another gcd queue.
 
<<<<<<< HEAD
 If NULL is passed in this method does nothing.	*/
=======
 @param GCDQueue to be targeted by this queue, if NULL this does nothing
 */
>>>>>>> upstream/master
-(void)setTargetGCDQueue:(dispatch_queue_t)GCDQueue;

/**
 Adds an operation object & asynchronously executes it
 
<<<<<<< HEAD
 The operations operation block is executed first then the completion block (if its set)	*/
-(void)addOperation:(CWBlockOperation *)operation;

/**
 Asnchronously executes a block on the gcd queue	*/
=======
 The operations operation block is executed first then the completion block
 
 @param operation a CWBlockOperation object
 */
-(void)addOperation:(CWBlockOperation *)operation;

/**
 Asnchronously executes a block on the gcd queue
 
 @param block a dispatch_block_t type to be executed on the queue
 */
>>>>>>> upstream/master
-(void)addoperationWithBlock:(dispatch_block_t)block;

/**
 Synchronously executes a CWBlockOperation object
 
<<<<<<< HEAD
 The operations operation block is executed first then the completion block (if its set)	*/
-(void)addSynchronousOperation:(CWBlockOperation *)operation;

/**
 Synchronously executes a block on the gcd queue	*/
-(void)addSynchronousOperationWithBlock:(dispatch_block_t)block;

/**
 Asynchonously waits for all already queued blocks to finish executing and then executes the passed in block	*/
-(void)executeWhenQueueIsFinished:(dispatch_block_t)block;

/**
 Synchronously waits for the queue to finish executing before continuing execution	*/
-(void)waitForQueueToFinish;
=======
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
>>>>>>> upstream/master

/**
 Suspends the execution of further blocks on the queue	*/
-(void)suspend;

/**
 Resumes the execution of blocks on the queue	*/
-(void)resume;

@end

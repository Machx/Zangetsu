/*
//  CWBlockQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/27/12.
//  Copyright (c) 2012. All rights reserved.
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

#import "CWBlockQueue.h"

@interface CWBlockOperation()
@property(copy) dispatch_block_t operationBlock;
@end

@implementation CWBlockOperation

@synthesize operationBlock = _operationBlock;
@synthesize completionBlock = _completionBlock;

-(id)initWithBlock:(dispatch_block_t)block
{
	self = [super init];
	if (self) {
		_operationBlock = block;
		_completionBlock = NULL;
	}
	return self;
}

/**
 Returns a new CWBlockOperation object
 
 @param block the block to be used with the operation object. This must not be nil.
 @return a CWBlocKOperation instance
 */
+(CWBlockOperation *)operationWithBlock:(dispatch_block_t)block
{
	NSParameterAssert(block);
	return [[self alloc] initWithBlock:block];
}

@end

@interface CWBlockQueue()
-(dispatch_queue_t)_getDispatchQueueWithType:(NSInteger)type 
								  concurrent:(BOOL)concurrent 
									andLabel:(NSString *)label;
@property(readwrite,assign) dispatch_queue_t queue; //the queue that CWBlockQueue manages
@end

@implementation CWBlockQueue

@synthesize queue = _queue;

/**
 Initializes a CWBlockQueue object with a queue type and label as applicable
 
 @param type a NSInteger with the type of the queue to be used as defined in the header
 @param concurrent a BOOL thats used if the private queue type is specified to mark the private queue as serial or concurrent
 @param label a NSString thats used for the queue label if a private queue type is specified
 */
-(id)initWithQueueType:(NSInteger)type 
			concurrent:(BOOL)concurrent 
				 label:(NSString *)label
{
	self = [super init];
	if (self) {
		_queue = [self _getDispatchQueueWithType:type 
									  concurrent:concurrent 
										andLabel:label];
	}
	return self;
}

/**
 Initialzes a CWBlockQueue object with a specified gcd queue
 
 @param a dispatch_queue_t queue that CWBlockQueue should manage
 @return an initialized CWBlockQueue object
 */
-(id)initWithGCDQueue:(dispatch_queue_t)gcdQueue
{
	self = [super init];
	if (self) {
		_queue = gcdQueue;
	}
	return self;
}

-(dispatch_queue_t)_getDispatchQueueWithType:(NSInteger)type 
								  concurrent:(BOOL)concurrent 
									andLabel:(NSString *)label
{
	dispatch_queue_t queue = NULL;
	
	if (type == kCWBlockQueueTargetPrivateQueue) {
		dispatch_queue_attr_t queueConcurrentAttribute = (concurrent) ? DISPATCH_QUEUE_CONCURRENT : DISPATCH_QUEUE_SERIAL;
		if (label) {
			queue = dispatch_queue_create([label UTF8String], queueConcurrentAttribute);
		} else {
			queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWBlockQueue_"), queueConcurrentAttribute);
		}
		
	} else if (type == kCWBlockQueueTargetGCDHighPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	
	} else if (type == kCWBlockQueueTargetGCDNormalPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	} else if (type == kCWBlockQueueTargetGCDLowPriority) {
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
	
	} else if (type == kCWBlockQueueTargetMainQueue) {
		queue = dispatch_get_main_queue();
	}
	return queue;
}

/**
 Returns the Queue Label from the Queues GCD Queue
 
 @return a NSString with the queue label or nil.
 */
-(NSString *)label
{
	static NSString *queueLabel = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		if ([self queue]) {
			const char *gcdQueueLabel = dispatch_queue_get_label([self queue]);
			if (gcdQueueLabel) {
				queueLabel = [NSString stringWithCString:gcdQueueLabel encoding:NSUTF8StringEncoding];
			}
		}
	});
	return queueLabel;
}

/**
 Sets the CWBlockQueues gcd queue to target another gcd queue.
 
 If nil is passed in this method does nothing.
 */
-(void)setTargetCWBlockQueue:(CWBlockQueue *)blockQueue
{
	if (blockQueue) {
		dispatch_set_target_queue([self queue], [blockQueue queue]);
	}
}

/**
 Sets the CWBlockQueues gcd queue to target another gcd queue.
 
 If NULL is passed in this method does nothing.
 */
-(void)setTargetGCDQueue:(dispatch_queue_t)GCDQueue
{
	if (GCDQueue) {
		dispatch_set_target_queue([self queue], GCDQueue);
	}
}

/**
 Returns a global CWBlockQueue object initialized to point at the GCD Main Queue
 */
+(CWBlockQueue *)mainQueue
{
	static CWBlockQueue *mainBlockQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mainBlockQueue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetMainQueue 
													  concurrent:NO 
														   label:nil];
	});
	return mainBlockQueue;
}

/**
 Returns a global CWBlockQueue object initialized to point at the GCD Default Priority Queue
 */
+(CWBlockQueue *)globalDefaultQueue
{
	static CWBlockQueue *gcdDefaultQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		gcdDefaultQueue = [[CWBlockQueue alloc] initWithQueueType:kCWBlockQueueTargetGCDNormalPriority 
													   concurrent:NO //bool flag ignored here
															label:nil];
	});
	return gcdDefaultQueue;
}

/**
 Creates a Temporary Queue that you can use to throw a block on for execution in the background
 
 This creates a temporary dispatch_queue_t and then asynchronously executes the block and when 
 the block has completed executing the queue is immediately released. The temporary queue has a 
 unique label like 'com.Zangetsu.CWBlockQueue_TemporaryQueue_1A5F...' etc. 
 */
+(void)executeBlockOnTemporaryQueue:(dispatch_block_t)block
{
	dispatch_queue_t tempQueue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWBlockQueue_TemporaryQueue_"), DISPATCH_QUEUE_SERIAL);
	dispatch_async(tempQueue, block);
	dispatch_release(tempQueue);
}

/**
 Adds an operation object & asynchronously executes it
 
 The operations operation block is executed first then the completion block (if its set)
 */
-(void)addOperation:(CWBlockOperation *)operation
{
	dispatch_async([self queue], ^{
		[operation operationBlock]();
		if ([operation completionBlock]) {
			[operation completionBlock]();
		}
	});
}

/**
 Asnchronously executes a block on the gcd queue
 */
-(void)addoperationWithBlock:(dispatch_block_t)block
{
	dispatch_async([self queue], block);
}

/**
 Synchronously executes a CWBlockOperation object
 
 The operations operation block is executed first then the completion block (if its set)
 */
-(void)addSynchronousOperation:(CWBlockOperation *)operation
{
	dispatch_sync([self queue], ^{
		[operation operationBlock]();
		if ([operation completionBlock]) {
			[operation completionBlock]();
		}
	});
}

/**
 Synchronously executes a block on the gcd queue
 */
-(void)addSynchronousOperationWithBlock:(dispatch_block_t)block
{
	dispatch_sync([self queue], block);
}

/**
 Asynchonously waits for all already queued blocks to finish executing and then executes the passed in block
 */
-(void)executeWhenQueueIsFinished:(dispatch_block_t)block
{
	dispatch_barrier_async([self queue],block);
}

/**
 Synchronously waits for the queue to finish executing before continuing execution
 */
-(void)waitForQueueToFinish
{
	dispatch_barrier_sync([self queue], ^{
		CWDebugLog(@"Queue %@ Finished",self);
	});
}

/**
 Suspends the execution of further blocks on the queue
 */
-(void)suspend
{
	dispatch_suspend([self queue]);
}

/**
 Resumes the execution of blocks on the queue
 */
-(void)resume
{
	dispatch_resume([self queue]);
}

/**
 Returns if the CWBlockQueues gcd queues are the same
 */
-(BOOL)isEqual:(id)object
{
	if ([object isMemberOfClass:[self class]]) {
		return ([self queue] == [object queue]);
	}
	return NO;
}

-(void)dealloc
{
	if ([self queue] != dispatch_get_main_queue()) {
		//make sure we only release on a private queue
		//doing this on the global concurrent queues does nothing
		dispatch_release(_queue); 
	}
}

@end
